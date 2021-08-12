//
//  UITableView+WWQExtension.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import "UITableView+WWQExtension.h"
#import "UITableView+Private.h"
#import <objc/runtime.h>


@implementation UITableView (WWQExtension)


- (void)setWwq_delegate:(id<UITableViewDelegate>)delegate {
    NSAssert(delegate, @"delegate为空");
    //动态的给viewModel里面的delegate和dataSource添加委托实现方法
    [self wwq_dynamicDelegate:delegate];
}

- (id<UITableViewDelegate>)wwq_delegate {
    return self.delegate;
}

- (void)setWwq_dataSource:(id<UITableViewDataSource>)dataSource {
    NSAssert(dataSource, @"dataSource为空");
    [self wwq_dynamicDataSource:dataSource];
}

- (id<UITableViewDataSource>)wwq_dataSource {
    return self.dataSource;
}

/**
 持有viewModel数据源
 */
- (void)setWwq_viewModel:(WWQViewModel *)viewModel {
      NSAssert(viewModel, @"viewModel为空");
      objc_setAssociatedObject(self, @selector(wwq_viewModel), viewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WWQViewModel *)wwq_viewModel {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark 注册cell

/**
 持有config配置表
 */
- (void)setWwq_config:(WWQTableViewConfig *)config {
    if (config != nil) {
        objc_setAssociatedObject(self, @selector(wwq_config), config, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self registerCell:config];
        [self registerHeaderCell:config];
    }
}

- (WWQTableViewConfig *)wwq_config {
    return objc_getAssociatedObject(self, _cmd);
}

/**
 注册cell
 */
- (void)registerCell:(WWQTableViewConfig *)config {
    NSArray *array = config.tableViewCellArray;
    for (NSInteger i = 0; i < array.count; i++) {
        id cell = array[i];
        //生成cellid
        NSString *cellID = wwq_tableView_cellID(i);
        if ([cell isKindOfClass:[UINib class]]) {
            [self registerNib:cell forCellReuseIdentifier:cellID];
        } else {
            [self registerClass:cell forCellReuseIdentifier:cellID];
        }
    }
}

/**
 注册headerViewCell
 */
- (void)registerHeaderCell:(WWQTableViewConfig *)config {
    NSArray *array = config.tableViewHeaderViewArray;
    for (NSInteger i = 0; i < array.count; i++) {
        id headerView = array[i];
        //生成cellid
        NSString *headerID = wwq_tableView_header_cellID(i);
        if ([headerView isKindOfClass:[UINib class]]) {
            [self registerNib:headerView forHeaderFooterViewReuseIdentifier:headerID];
        } else {
            [self registerClass:headerView forHeaderFooterViewReuseIdentifier:headerID];
        }
    }
}

//获取indexPath对应的cell索引
- (NSUInteger)wwq_typeForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger type = 0;
    if (self.wwq_config.tableViewCellArray != nil) {
        id dataInfo = [self.wwq_viewModel rowDataAtIndexPath:indexPath];
        //先取tableView的全局配置
        if (self.wwq_config.cellTypeBlock) {
            type =  self.wwq_config.cellTypeBlock(indexPath,dataInfo);
        }
        //如果section里面配置过，则以section配置为主
        id<WWQSectionModelDataSource> sectionData =  [self.wwq_viewModel sectionDataAtSection:indexPath.section];
        if ([sectionData respondsToSelector:@selector(cellTypeBlock)]) {
            WWQCellTypeBlock cellTypeBlock = [sectionData cellTypeBlock];
            if (cellTypeBlock) {
                type =  cellTypeBlock(indexPath,dataInfo);
            }
        }
        //但是你不能超过cell的种类
        if (type >= self.wwq_config.tableViewCellArray.count) {//如果得到的type大于数组的长度 则默认等于0位置的type
            type = 0;
        }
    }
    return type;
}

@end


#pragma mark ----------------编辑能力------------
@implementation UITableView (SNEditable)

/**
 修改设置多行编辑
 
 @param editing 是否编辑
 @param animated 是否有动画
 */
- (void)sn_setMultiLineEditing:(BOOL)editing animated:(BOOL)animated {
    if (!editing) {
        NSArray *array = [self indexPathsForSelectedRows];
        if (self.wwq_config.multiLineDeleteAction) {
            self.wwq_config.multiLineDeleteAction(array);
        }
    }
    [self setEditing:editing animated:animated];
}

@end
