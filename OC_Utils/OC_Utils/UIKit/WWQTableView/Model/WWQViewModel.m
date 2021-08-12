//
//  WWQViewModel.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import "WWQViewModel.h"
#import "WWQSectionModel.h"

@implementation WWQViewModel {
    //存放二维数组
    NSMutableArray<id<WWQSectionModelDataSource>> *_allDataArray;
}

- (instancetype)init {
    if (self = [super init]) {
        _allDataArray = [NSMutableArray array];
    }
    return self;
}

//在第section的区域插入sectionData数据
- (void)insertSection:(NSUInteger)section sectionData:(id<WWQSectionModelDataSource>)sectionData {
    [_allDataArray insertObject:sectionData atIndex:section];
}

/**
 添加所有sections数据
 */
- (void)addAllSectionData:(NSArray<id<WWQSectionModelDataSource>> *)sections {
    [_allDataArray addObjectsFromArray:sections];
}

//增加sectionData 其rows数据需要自己指定
- (void)addSectionData:(id<WWQSectionModelDataSource>)sectionData {
    [_allDataArray addObject:sectionData];
}

//增加sectionData,将sectionData作为该块的第一个数据
- (void)addSectionDataWithArray:(NSArray *)array {
    WWQSectionModel *sectionInfo = [[WWQSectionModel alloc] init];
    [sectionInfo addRowDatasFromArray:array];
    [self addSectionData:sectionInfo];
}

//添加行数据
- (void)addRowData:(id)rowData section:(NSUInteger)section {
    id<WWQSectionModelDataSource> sectionData = [_allDataArray objectAtIndex:section];
    NSMutableArray *itemArray = [sectionData itemArray];
    NSAssert([itemArray isKindOfClass:[NSMutableArray class]], @"can not add from NSArray，please change to NSMutableArray");
    [itemArray addObject:rowData];
}

//移除块数据
- (void)removeSectionDataAtSection:(NSUInteger)section {
    if (_allDataArray.count > section) {
        [_allDataArray removeObjectAtIndex:section];
    }
}

- (void)removeSectionData:(id)sectionData {
    [_allDataArray removeObject:sectionData];
}

//移除行数据
- (void)removeRowDataAtIndexPath:(NSIndexPath *)indexPath {
    id<WWQSectionModelDataSource> sectionData = [_allDataArray objectAtIndex:indexPath.section];
    NSMutableArray *itemArray = [sectionData itemArray];
    NSAssert([itemArray isKindOfClass:[NSMutableArray class]], @"can not add from NSArray，please change to NSMutableArray");
    [itemArray removeObjectAtIndex:indexPath.row];
}

- (void)removeRowData:(id)rowData section:(NSUInteger)section {
    id<WWQSectionModelDataSource> sectionData = [_allDataArray objectAtIndex:section];
    NSMutableArray *itemArray = [sectionData itemArray];
    [itemArray removeObject:rowData];
}

/**
 移除所有行数据
 */
- (void)removeAllDatas {
    [_allDataArray removeAllObjects];
}

@end

@implementation WWQViewModel (getData)

#pragma mark --------------获取数据--------------------
- (NSUInteger)numberOfSections {
    return _allDataArray.count;
}

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section {
    id<WWQSectionModelDataSource> sectionData = _allDataArray[section];
    NSArray *itemArray = [sectionData itemArray];
    return itemArray.count;
}

//返回section的数据
- (id)sectionDataAtSection:(NSUInteger)section {
    return _allDataArray[section];
}

//返回对应位置的数据
- (id)rowDataAtIndexPath:(NSIndexPath *)indexPath {
    id<WWQSectionModelDataSource> sectionData = _allDataArray[indexPath.section];
    id dataInfo = nil;
    NSArray *itemArray = [sectionData itemArray];
    if (itemArray.count > indexPath.row) {
        dataInfo = itemArray[indexPath.row];
    }
    return dataInfo;
}

@end
