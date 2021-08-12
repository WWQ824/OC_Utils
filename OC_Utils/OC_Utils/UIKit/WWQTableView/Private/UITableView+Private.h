//
//  UITableView+Private.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

extern NSString *wwq_tableView_cellID(NSUInteger type);
extern NSString *wwq_tableView_header_cellID(NSUInteger type);


@interface UITableView (Private)


/**
  动态实现delegate和source
 */
- (void)wwq_dynamic:(id)delegate;

/**
 动态实现delegate

 @param delegate 委托
 */
- (void)wwq_dynamicDelegate:(id)delegate;

/**
 动态实现datasource

 @param dataSource 数据源
 */
- (void)wwq_dynamicDataSource:(id)dataSource;



@end

NS_ASSUME_NONNULL_END
