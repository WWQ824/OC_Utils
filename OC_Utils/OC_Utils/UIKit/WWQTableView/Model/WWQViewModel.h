//
//  WWQViewModel.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import <Foundation/Foundation.h>

@protocol WWQSectionModelDataSource;

NS_ASSUME_NONNULL_BEGIN

@interface WWQViewModel : NSObject


/**
  tableView右边的IndexTitles数据源
 */
@property (nonatomic, copy) NSArray *sectionIndexTitles;

/**
 在第section的区域插入sectionData数据

 @param section 块数
 @param sectionData 块数据
 */
- (void)insertSection:(NSUInteger)section sectionData:(id<WWQSectionModelDataSource>)sectionData;

/**
  添加所有sections数据
 */
- (void)addAllSectionData:(NSArray<id<WWQSectionModelDataSource>> *)sections;

/**
 增加sectionData 其rows数据需要自己指定

 @param sectionData 块数据
 */
- (void)addSectionData:(id<WWQSectionModelDataSource>)sectionData;

/**
 增加sectionData,将sectionData作为该块的第一个数据

 @param array 第一块的数据组
 */
- (void)addSectionDataWithArray:(NSArray *)array;

/**
 添加行数据

 @param rowData 某一块的行数据数组
 @param section 块数据
 */
- (void)addRowData:(id)rowData section:(NSUInteger)section;

/**
 移除块数据

 @param section 块数
 */
- (void)removeSectionDataAtSection:(NSUInteger)section;
- (void)removeSectionData:(id)sectionData;

/**
 移除行数据

 @param indexPath 行数信息
 */
- (void)removeRowDataAtIndexPath:(NSIndexPath *)indexPath;
- (void)removeRowData:(id)rowData section:(NSUInteger)section;

/**
 移除所有行数据
 */
- (void)removeAllDatas;

@end


@interface WWQViewModel (getData)

#pragma mark ----------- 我是分隔线 ------------

/**
 返回section数量

 @return section数量
 */
- (NSUInteger)numberOfSections;

/**
 根据section返回rows

 @param section 块数
 @return 某一块对应的行数
 */
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;

/**
 返回section的数据

 @param section 块数
 @return 块数据
 */
- (id)sectionDataAtSection:(NSUInteger)section;

/**
 返回对应位置的数据

 @param indexPath 行数信息
 @return 行数据
 */
- (id)rowDataAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
