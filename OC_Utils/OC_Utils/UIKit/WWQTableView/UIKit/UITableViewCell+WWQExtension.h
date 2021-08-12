//
//  UITableViewCell+WWQExtension.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (WWQExtension)


/**
 行数信息
 */
@property (nonatomic,strong) NSIndexPath *wwq_indexPath;

/**
 cell所在的tableview
 */
@property (nonatomic,weak) UITableView *wwq_tableView;

/**
 tableView的委托类
 */
@property (nonatomic,weak) id wwq_delegate;

/**
 cell需要实现的方法
 框架调用此方法渲染
 */
- (void)wwq_render:(id)dataInfo;

/**
 框架调用此方法计算高度
 */
- (CGFloat)wwq_tableView:(UITableView *)tableView cellInfo:(id)dataInfo;

@end

NS_ASSUME_NONNULL_END
