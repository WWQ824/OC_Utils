//
//  WWQImpTableViewDataSource.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import "WWQImpTableViewDataSource.h"
#import "UITableView+WWQExtension.h"
#import "WWQViewModel.h"
#import "UITableViewCell+WWQExtension.h"
#import "UITableView+Private.h"


@implementation WWQImpTableViewDataSource

#pragma mark - UITableView DataSource
//分组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [tableView.wwq_viewModel numberOfSections];
}

//每组中有几条数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //自定义
    return [tableView.wwq_viewModel numberOfRowsInSection:section];
}

//加入右侧索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //自定义
    return tableView.wwq_viewModel.sectionIndexTitles;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //分析取得数据
    id dataInfo = [tableView.wwq_viewModel rowDataAtIndexPath:indexPath];
    UITableViewCell *cell = nil;
    //NSLog(@"渲染第%d块，第%d行",indexPath.section,indexPath.row);
    //生成cellid
    NSUInteger type = [tableView wwq_typeForRowAtIndexPath:indexPath];
    NSString *cellID = wwq_tableView_cellID(type);
    cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    //取不到，你竟然没有配置该类型的cell，不过我保你不奔溃
    if (cell == nil) {
        //给个默认的class
        cell = [[UITableViewCell alloc] initWithStyle:tableView.wwq_config.tableViewCellStyle reuseIdentifier:cellID];
    }
    NSAssert([cell isKindOfClass:[UITableViewCell class]], @"cell必须是UITableViewCell的子类");
    //下面都是我苦心为你提供的，方便你在cell里面使用，反正你看着用
    cell.wwq_indexPath = indexPath;
    cell.wwq_delegate = tableView.delegate;
    cell.wwq_tableView = tableView;
    
    //虽然废弃的方法，但是你不要，我要，我用着舒心就可以，
    //但是你还可以在dataInfo里面指定accessoryType样式哦 ,偷偷告诉你key只要是SNCellKeyAccessoryType就可以了
    if (tableView.delegate && [tableView.delegate respondsToSelector:@selector(tableView:accessoryTypeForRowWithIndexPath:)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        cell.accessoryType = [tableView.delegate tableView:tableView accessoryTypeForRowWithIndexPath:indexPath];
#pragma clang diagnostic pop
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id<WWQSectionModelDataSource> sectionInfo = [tableView.wwq_viewModel sectionDataAtSection:section];
    if ([sectionInfo respondsToSelector:@selector(title)]) {
        return sectionInfo.title;
    }
    return nil;
}

#pragma mark ------------------edit------------------

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    //依然你最大，你来决定是否能编辑
    if (tableView.wwq_config.canEditable) {
        return tableView.wwq_config.canEditable(indexPath);
    }
    return tableView.wwq_config.editable;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (tableView.wwq_config.singleLineDeleteAction) {
            tableView.wwq_config.singleLineDeleteAction(indexPath);
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


@end
