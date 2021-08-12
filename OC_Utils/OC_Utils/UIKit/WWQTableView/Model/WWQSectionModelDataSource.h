//
//  WWQSectionModelDataSource.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 cell type

 @param indexPath 行数信息
 @param dataInfo 行数据
 @return 行数据对应cell索引
 */
typedef NSInteger (^WWQCellTypeBlock)(NSIndexPath *indexPath, id dataInfo) ;

/**
 didSelectRowAtIndexPath

 @param indexPath 行数信息
 @param dataInfo 行数据
 */
typedef void (^WWQDidSelectCellBlock)(UITableView *tableView, NSIndexPath *indexPath, id dataInfo) ;


@protocol WWQSectionModelDataSource <NSObject>

@required
- (NSArray *)itemArray;

@optional
- (NSString *)title;

@optional

/**
  数据源对应的cell索引
 */
@property(nonatomic, copy) WWQCellTypeBlock cellTypeBlock;

/**
  didSelectRowAtIndexPath
 */
@property(nonatomic, copy) WWQDidSelectCellBlock didSelectCellBlock;


@end
