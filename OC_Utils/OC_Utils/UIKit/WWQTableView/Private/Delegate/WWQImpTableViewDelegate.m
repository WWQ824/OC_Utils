//
//  WWQImpTableViewDelegate.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import "WWQImpTableViewDelegate.h"
#import "UITableViewCell+WWQExtension.h"
#import "WWQViewModel.h"
#import <objc/runtime.h>
#import "UITableView+Private.h"
#import "UITableView+WWQExtension.h"
#import "UITableView+WWQIndexPathHeightCache.h"
#import "UITableViewHeaderFooterView+WWQExtension.h"


@implementation WWQImpTableViewDelegate


+ (void)deselect:(UITableView *)tableView{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    id dataInfo = [tableView.wwq_viewModel rowDataAtIndexPath:indexPath];
    if (tableView.wwq_config.willLoadCellBlock) {
        tableView.wwq_config.willLoadCellBlock(cell,indexPath,dataInfo);
    }
    //我来帮你处理数据
    [cell wwq_render:dataInfo];
    //给你一次自己处理的机会
    if (tableView.wwq_config.didLoadCellBlock) {
        tableView.wwq_config.didLoadCellBlock(cell,indexPath,dataInfo);
    }
}

//选中cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击过去就会帮你取消点击后的效果
    if (tableView.wwq_config.clearSelectionDelay) {
        [WWQImpTableViewDelegate performSelector:@selector(deselect:) withObject:tableView afterDelay:0.5f];
    }
    WWQDidSelectCellBlock selectBlock = tableView.wwq_config.didSelectCellBlock;
    id sectionInfo = [tableView.wwq_viewModel sectionDataAtSection:indexPath.section];
    if ([sectionInfo conformsToProtocol:@protocol(WWQSectionModelDataSource)]) {
        id<WWQSectionModelDataSource> model = sectionInfo;
        if([model respondsToSelector:@selector(didSelectCellBlock)]){
            WWQDidSelectCellBlock block = [model didSelectCellBlock];
            if (block) {
                selectBlock = block;
            }
        }
    }
    if (selectBlock != nil) {
        id dataInfo = [tableView.wwq_viewModel rowDataAtIndexPath:indexPath];
        selectBlock(tableView,indexPath,dataInfo);
    }
}

//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //我是来判断是否缓存了高度
    //缓存用的是UITableView+UITableView+FDIndexPathHeightCache,
    //当然感谢作者帮我们做了这个，不然还要自己写缓存 /(ㄒoㄒ)/~~
    if (tableView.wwq_config.supportHeightCache && [tableView.indexPathHeightCache existsHeightAtIndexPath:indexPath]) {
        return [tableView.indexPathHeightCache heightForIndexPath:indexPath];
    }
    id dataInfo = [tableView.wwq_viewModel rowDataAtIndexPath:indexPath];
    //NSLog(@"计算第%d块，第%d行行高",indexPath.section,indexPath.row);
    //自己计算高度
    CGFloat height = 44.0f;
    if (tableView.wwq_config.cellHeightBlock) {
        height = tableView.wwq_config.cellHeightBlock(indexPath,dataInfo);
    } else {
        //将计算高度的方法交给cell来处理，cell来做，毕竟cell的高度cell来做不是应该的吗？ 顺便也瘦了vc的身，
        UITableViewCell *cell = nil;
        //SNLog(@"渲染第%d块，第%d行",indexPath.section,indexPath.row);
        //生成cellid
        NSUInteger type = [tableView wwq_typeForRowAtIndexPath:indexPath];
        NSString *cellID = wwq_tableView_cellID(type);
        cell = [WWQImpTableViewDelegate tableView:tableView templateCellForReuseIdentifier:cellID delegate:tableView.delegate];
        if (cell != nil) {
            cell.wwq_indexPath = indexPath;
            //给cell的dataInfo赋值,并计算高度
            height =  [cell wwq_tableView:tableView cellInfo:dataInfo];
        }
    }
    if (tableView.wwq_config.supportHeightCache) {
        [tableView.indexPathHeightCache cacheHeight:height byIndexPath:indexPath];
    }
    return height;
}


//header view
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    id<WWQSectionModelDataSource> sectionInfo = [tableView.wwq_viewModel sectionDataAtSection:section];
    CGFloat height = 0.0001;
    //iOS 14 0.0001去除分隔线的方法失效了，应该是改了这个bug
    if (@available(iOS 14, *)) {
        height = 0;
    }
    if ([sectionInfo respondsToSelector:@selector(title)]) {
        NSString *title = [sectionInfo title];
        if (title.length > 0) {
            height = 44.0f;
        }
    }
    
    NSInteger type = -1;
    if (tableView.wwq_config.headerTypeBlock) {
        type = tableView.wwq_config.headerTypeBlock(section,sectionInfo);
    }
    if (type >= 0) {
        NSString *headerID = wwq_tableView_header_cellID(type);
        UITableViewHeaderFooterView *headerView = [WWQImpTableViewDelegate tableView:tableView templateHeaderViewForReuseIdentifier:headerID delegate:tableView.delegate];
        height = [headerView wwq_tableView:tableView sectionInfo:sectionInfo];
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id sectionInfo = [tableView.wwq_viewModel sectionDataAtSection:section];
    NSInteger type = -1;
    if (tableView.wwq_config.headerTypeBlock) {
        type = tableView.wwq_config.headerTypeBlock(section,sectionInfo);
    }
    if (type >= 0) {
        NSString *headerID = wwq_tableView_header_cellID(type);
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
        return headerView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UITableViewHeaderFooterView *)view forSection:(NSInteger)section {
    id sectionInfo = [tableView.wwq_viewModel sectionDataAtSection:section];
    [view wwq_render:sectionInfo];
}


//根据identifier获取临时tableviewcell用于临时计算
+ (__kindof UITableViewCell *)tableView:(UITableView *)tableView
         templateCellForReuseIdentifier:(NSString *)identifier
                               delegate:(id)delegate {
    NSAssert(identifier.length > 0, @"identifier:%@ is empty", identifier);
    
    NSMutableDictionary<NSString *, UITableViewCell *> *templateCellsByIdentifiers = objc_getAssociatedObject(delegate, _cmd);
    if (!templateCellsByIdentifiers) {
        templateCellsByIdentifiers = @{}.mutableCopy;
        objc_setAssociatedObject(delegate, _cmd, templateCellsByIdentifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    UITableViewCell *templateCell = templateCellsByIdentifiers[identifier];
    [templateCell prepareForReuse];//放回重用池
    if (!templateCell) {
        templateCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (templateCell) {
            templateCellsByIdentifiers[identifier] = templateCell;
        }
    }
    return templateCell;
}


//根据identifier获取临时tableviewcell用于临时计算
+ (__kindof UITableViewHeaderFooterView *)tableView:(UITableView *)tableView
         templateHeaderViewForReuseIdentifier:(NSString *)identifier
                               delegate:(id)delegate {
    NSAssert(identifier.length > 0, @"identifier:%@ is empty", identifier);
    
    NSMutableDictionary<NSString *, UITableViewHeaderFooterView *> *templateHeaderViewByIdentifiers = objc_getAssociatedObject(delegate, _cmd);
    if (!templateHeaderViewByIdentifiers) {
        templateHeaderViewByIdentifiers = @{}.mutableCopy;
        objc_setAssociatedObject(delegate, _cmd, templateHeaderViewByIdentifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    UITableViewHeaderFooterView *templateHeaderView = templateHeaderViewByIdentifiers[identifier];
    [templateHeaderView prepareForReuse];//放回重用池
    if (!templateHeaderView) {
        templateHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        if (templateHeaderView) {
            templateHeaderViewByIdentifiers[identifier] = templateHeaderView;
        }
    }
    return templateHeaderView;
}


#pragma mark ------------------edit------------------
//编缉按扭样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    //设置删除多行
    if (tableView.wwq_config.multiLineDeleteAction != nil) {
        return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    //那个删除的text你不高兴可以自己来设置
    if (tableView.wwq_config.deleteConfirmationButtonTitle != nil) {
        return tableView.wwq_config.deleteConfirmationButtonTitle;
    }
    return @"删除";
}


@end
