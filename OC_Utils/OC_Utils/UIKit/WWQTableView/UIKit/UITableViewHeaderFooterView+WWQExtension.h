//
//  UITableViewHeaderFooterView+WWQExtension.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewHeaderFooterView (WWQExtension)


/**
 框架调用此方法计算高度
 */
- (CGFloat)wwq_tableView:(UITableView *)tableView sectionInfo:(id)sectionInfo;

/**
 view需要实现的方法
 框架调用此方法渲染
 */
- (void)wwq_render:(id)sectionInfo;


@end

NS_ASSUME_NONNULL_END
