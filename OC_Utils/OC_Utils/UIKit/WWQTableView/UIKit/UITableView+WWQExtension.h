//
//  UITableView+WWQExtension.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import "WWQTableViewConfig.h"
#import <UIKit/UIKit.h>
#import "WWQViewModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface UITableView (WWQExtension)
/**
 委托类
 */
@property (nonatomic, weak) id<UITableViewDelegate> wwq_delegate;

/**
 数据源
 */
@property (nonatomic, weak) id<UITableViewDataSource> wwq_dataSource;


/**
 数据源
 */
@property (nonatomic, strong) WWQViewModel *wwq_viewModel;

/**
 配置
 */
@property (nonatomic, strong) WWQTableViewConfig *wwq_config;

/**
 根据indexPath获取type
 */
- (NSUInteger)wwq_typeForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface UITableView (WWQEditable)

/**
 修改设置多行编辑

 @param editing 是否编辑
 @param animated 是否有动画
 */
- (void)wwq_setMultiLineEditing:(BOOL)editing animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
