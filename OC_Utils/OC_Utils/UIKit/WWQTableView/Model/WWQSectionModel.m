//
//  WWQSectionModel.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import "WWQSectionModel.h"

@implementation WWQSectionModel {
    
    //存储其他额外数据
    NSMutableDictionary *_otherInfo;
    //操作数据
    WWQCellTypeBlock _typeBlock;
    WWQDidSelectCellBlock _didSelectBlock;
}


- (instancetype)init {
    if (self = [super init]) {
        _otherInfo = [NSMutableDictionary dictionary];
        _dataArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark  ------ 添加行数据 ------
- (void)addRowData:(id)rowData {
    if ([_dataArray isKindOfClass:[NSMutableArray class]]) {
        [(NSMutableArray*)_dataArray addObject:rowData];
    }
}

- (void)addRowDatasFromArray:(NSArray *)rowDatas {
    if ([_dataArray isKindOfClass:[NSMutableArray class]]) {
        [(NSMutableArray*)_dataArray addObjectsFromArray:rowDatas];
    }
}

- (void)removeAllRowData {
    if ([_dataArray isKindOfClass:[NSMutableArray class]]) {
        [(NSMutableArray *)_dataArray removeAllObjects];
    }
}

#pragma mark ------ 可以添加额外的数据 ------
- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key {
    [_otherInfo setValue:value forKey:key];
}

- (id)valueForUndefinedKey:(NSString *)key {
    return [_otherInfo valueForKey:key];
}

#pragma mark  ------ 需要实现的方法 ------
- (NSArray *)itemArray {
    return _dataArray;
}

// 数据源对应的cell索引
- (WWQCellTypeBlock)cellTypeBlock {
    return _typeBlock;
}

- (void)setCellTypeBlock:(WWQCellTypeBlock)cellTypeBlock {
    _typeBlock = cellTypeBlock;
}

// didSelectRowAtIndexPath
- (WWQDidSelectCellBlock)didSelectCellBlock {
    return _didSelectBlock;
}

- (void)setDidSelectCellBlock:(WWQDidSelectCellBlock)didSelectCellBlock {
    _didSelectBlock = didSelectCellBlock;
}


@end

#pragma mark  ----------------rowData-----------

@implementation WWQRowModel {
    //存储其他额外数据
    NSMutableDictionary *_otherInfo;
}

- (instancetype)init {
    if (self = [super init]) {
        _otherInfo = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark 可以添加额外的数据
- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key {
    [_otherInfo setValue:value forKey:key];
}

- (id)valueForUndefinedKey:(NSString *)key {
    return [_otherInfo valueForKey:key];
}

@end
