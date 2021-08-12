//
//  WWQTableViewConfig.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import <Foundation/Foundation.h>
#import "WWQSectionModelDataSource.h"

NS_ASSUME_NONNULL_BEGIN


/**
 header type

 @param section 块数
 @param sectionInfo 块数据
 @return 数据对应的cell数组索引
 */
typedef NSInteger (^WWQHeaderTypeBlock)(NSUInteger section, id sectionInfo) ;

/**
 计算行高

 @param indexPath 行数信息
 @param dataInfo 行数据
 @return 行高
 */
typedef CGFloat (^WWQCellHeightBlock)(NSIndexPath *indexPath, id dataInfo) ;

/**
 cellForRowAtIndexPath  方法会调用该block

 @param cell cell
 @param indexPath 行数信息
 @param dataInfo 行数据
 */
typedef void (^WWQTableViewCellLoadBlock)(UITableViewCell *cell,NSIndexPath *indexPath, id dataInfo) ;

#pragma mark ----------编辑功能---------------


/**
 单选行删除block

 @param indexPath 行数信息
 */
typedef void(^WWQSingleLineDeleteAction) (NSIndexPath *indexPath);

/**
 多选行删除block

 @param indexPaths 行数信息
 */
typedef void(^WWQMultiLineDeleteAction) (NSArray *indexPaths);

/**
 是否能删除block

 @param indexPath 行数信息
 @return 行对应的编辑能力，YES：能编辑，NO：不能编辑
 */
typedef BOOL(^WWQCanEditable) (NSIndexPath *indexPath);



@interface WWQTableViewConfig : NSObject

/**
  cell的类名或xib组成的数组
 */
@property (nonatomic, strong) NSArray  *tableViewCellArray;

/**
  headerView的类名或xib组成的数组
 */
@property (nonatomic, strong) NSArray  *tableViewHeaderViewArray;

/**
  不传cell类型时，可通过设置cell的style来初始化cell
 */
@property (nonatomic, assign) UITableViewCellStyle tableViewCellStyle;

#pragma mark --------------- 对应事件 ---------------

/**
  didSelectRowAtIndexPath
 */
@property (nonatomic, copy) WWQDidSelectCellBlock didSelectCellBlock;

/**
  计算行高
 */
@property (nonatomic, copy) WWQCellHeightBlock cellHeightBlock;

/**
  数据源对应的header索引
 */
@property (nonatomic, copy) WWQHeaderTypeBlock headerTypeBlock;


/**
  数据源对应的cell索引
 */
@property (nonatomic, copy) WWQCellTypeBlock cellTypeBlock;


/**
 cellForRowAtIndexPath  方法会调用该block
 */
@property (nonatomic, copy) WWQTableViewCellLoadBlock didLoadCellBlock;

/**
 cellForRowAtIndexPath  方法会调用该block
 */
@property (nonatomic, copy) WWQTableViewCellLoadBlock willLoadCellBlock;

#pragma mark --------------- 其他功能 ---------------

/**
 是否支持高度缓存，在高度计算复杂、频繁等条件下 建议开启
 */
@property (nonatomic, assign) BOOL supportHeightCache;

/**
 延迟一会取消选中状态
 */
@property (nonatomic, assign) BOOL clearSelectionDelay;

#pragma mark --------------- 编辑 ---------------

/**
 是否处于编辑状态
 */
@property (nonatomic, assign, readonly) BOOL editable;

/**
  是否能编辑 block
 */
@property (nonatomic, assign) WWQCanEditable canEditable;

/**
  删除按钮的标题
 */
@property (nonatomic, strong) NSString *deleteConfirmationButtonTitle;

/**
  开启多行删除block
 */
@property(nonatomic, copy) WWQMultiLineDeleteAction multiLineDeleteAction;

/**
  开启单行删除block
 */
@property(nonatomic, copy) WWQSingleLineDeleteAction singleLineDeleteAction;



@end

NS_ASSUME_NONNULL_END
