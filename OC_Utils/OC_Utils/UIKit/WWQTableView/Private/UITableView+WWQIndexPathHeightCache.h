//
//  UITableView+WWQIndexPathHeightCache.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface WWQIndexPathHeightCache : NSObject

// Enable automatically if you're using index path driven height cache
@property (nonatomic, assign) BOOL automaticallyInvalidateEnabled;

// Height cache
- (BOOL)existsHeightAtIndexPath:(NSIndexPath *)indexPath;
- (void)cacheHeight:(CGFloat)height byIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath;
- (void)invalidateHeightAtIndexPath:(NSIndexPath *)indexPath;
- (void)invalidateAllHeightCache;

@end


@interface UITableView (WWQIndexPathHeightCache)


/// Height cache by index path. Generally, you don't need to use it directly.
@property (nonatomic, strong, readonly) WWQIndexPathHeightCache *indexPathHeightCache;

@end


@interface UITableView (WWQIndexPathHeightCacheInvalidation)
/// Call this method when you want to reload data but don't want to invalidate
/// all height cache by index path, for example, load more data at the bottom of
/// table view.
- (void)reloadDataWithoutInvalidateIndexPathHeightCache;


@end

NS_ASSUME_NONNULL_END
