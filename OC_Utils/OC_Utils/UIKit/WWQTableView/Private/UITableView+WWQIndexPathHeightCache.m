//
//  UITableView+WWQIndexPathHeightCache.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import "UITableView+WWQIndexPathHeightCache.h"
#import <objc/runtime.h>


typedef NSMutableArray<NSMutableArray<NSNumber *> *> WWQIndexPathHeightsBySection;

@interface WWQIndexPathHeightCache ()

@property (nonatomic, strong) WWQIndexPathHeightsBySection *heightsBySectionForPortrait;
@property (nonatomic, strong) WWQIndexPathHeightsBySection *heightsBySectionForLandscape;

@end


@implementation WWQIndexPathHeightCache


- (instancetype)init {
    self = [super init];
    if (self) {
        _heightsBySectionForPortrait = [NSMutableArray array];
        _heightsBySectionForLandscape = [NSMutableArray array];
    }
    return self;
}

- (WWQIndexPathHeightsBySection *)heightsBySectionForCurrentOrientation {
    return UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation) ? self.heightsBySectionForPortrait: self.heightsBySectionForLandscape;
}

- (void)enumerateAllOrientationsUsingBlock:(void (^)(WWQIndexPathHeightsBySection *heightsBySection))block {
    block(self.heightsBySectionForPortrait);
    block(self.heightsBySectionForLandscape);
}

- (BOOL)existsHeightAtIndexPath:(NSIndexPath *)indexPath {
    [self buildCachesAtIndexPathsIfNeeded:@[indexPath]];
    NSNumber *number = self.heightsBySectionForCurrentOrientation[indexPath.section][indexPath.row];
    return ![number isEqualToNumber:@-1];
}

- (void)cacheHeight:(CGFloat)height byIndexPath:(NSIndexPath *)indexPath {
    self.automaticallyInvalidateEnabled = YES;
    [self buildCachesAtIndexPathsIfNeeded:@[indexPath]];
    self.heightsBySectionForCurrentOrientation[indexPath.section][indexPath.row] = @(height);
}

- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath {
    [self buildCachesAtIndexPathsIfNeeded:@[indexPath]];
    NSNumber *number = self.heightsBySectionForCurrentOrientation[indexPath.section][indexPath.row];
#if CGFLOAT_IS_DOUBLE
    return number.doubleValue;
#else
    return number.floatValue;
#endif
}

- (void)invalidateHeightAtIndexPath:(NSIndexPath *)indexPath {
    [self buildCachesAtIndexPathsIfNeeded:@[indexPath]];
    [self enumerateAllOrientationsUsingBlock:^(WWQIndexPathHeightsBySection *heightsBySection) {
        heightsBySection[indexPath.section][indexPath.row] = @-1;
    }];
}

- (void)invalidateAllHeightCache {
    [self enumerateAllOrientationsUsingBlock:^(WWQIndexPathHeightsBySection *heightsBySection) {
        [heightsBySection removeAllObjects];
    }];
}

- (void)buildCachesAtIndexPathsIfNeeded:(NSArray *)indexPaths {
    // Build every section array or row array which is smaller than given index path.
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
        [self buildSectionsIfNeeded:indexPath.section];
        [self buildRowsIfNeeded:indexPath.row inExistSection:indexPath.section];
    }];
}

- (void)buildSectionsIfNeeded:(NSInteger)targetSection {
    [self enumerateAllOrientationsUsingBlock:^(WWQIndexPathHeightsBySection *heightsBySection) {
        for (NSInteger section = 0; section <= targetSection; ++section) {
            if (section >= heightsBySection.count) {
                heightsBySection[section] = [NSMutableArray array];
            }
        }
    }];
}

- (void)buildRowsIfNeeded:(NSInteger)targetRow inExistSection:(NSInteger)section {
    [self enumerateAllOrientationsUsingBlock:^(WWQIndexPathHeightsBySection *heightsBySection) {
        NSMutableArray<NSNumber *> *heightsByRow = heightsBySection[section];
        for (NSInteger row = 0; row <= targetRow; ++row) {
            if (row >= heightsByRow.count) {
                heightsByRow[row] = @-1;
            }
        }
    }];
}

@end

@implementation UITableView (WWQIndexPathHeightCache)

- (WWQIndexPathHeightCache *)indexPathHeightCache {
    WWQIndexPathHeightCache *cache = objc_getAssociatedObject(self, _cmd);
    if (!cache) {
        cache = [WWQIndexPathHeightCache new];
        objc_setAssociatedObject(self, _cmd, cache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cache;
}

@end

// We just forward primary call, in crash report, top most method in stack maybe FD's,
// but it's really not our bug, you should check whether your table view's data source and
// displaying cells are not matched when reloading.
static void __WWQ_TEMPLATE_LAYOUT_CELL_PRIMARY_CALL_IF_CRASH_NOT_OUR_BUG__(void (^callout)(void)) {
    callout();
}
#define WWQPrimaryCall(...) do {__WWQ_TEMPLATE_LAYOUT_CELL_PRIMARY_CALL_IF_CRASH_NOT_OUR_BUG__(^{__VA_ARGS__});} while(0)

@implementation UITableView (WWQIndexPathHeightCacheInvalidation)

- (void)reloadDataWithoutInvalidateIndexPathHeightCache {
    WWQPrimaryCall([self wwq_reloadData];);
}

+ (void)load {
    // All methods that trigger height cache's invalidation
    SEL selectors[] = {
        @selector(reloadData),
        @selector(insertSections:withRowAnimation:),
        @selector(deleteSections:withRowAnimation:),
        @selector(reloadSections:withRowAnimation:),
        @selector(moveSection:toSection:),
        @selector(insertRowsAtIndexPaths:withRowAnimation:),
        @selector(deleteRowsAtIndexPaths:withRowAnimation:),
        @selector(reloadRowsAtIndexPaths:withRowAnimation:),
        @selector(moveRowAtIndexPath:toIndexPath:)
    };
    
    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"wwq_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)wwq_reloadData {
    if (self.indexPathHeightCache.automaticallyInvalidateEnabled) {
        [self.indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WWQIndexPathHeightsBySection *heightsBySection) {
            [heightsBySection removeAllObjects];
        }];
    }
    WWQPrimaryCall([self wwq_reloadData];);
}

- (void)wwq_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.indexPathHeightCache.automaticallyInvalidateEnabled) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL *stop) {
            [self.indexPathHeightCache buildSectionsIfNeeded:section];
            [self.indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WWQIndexPathHeightsBySection *heightsBySection) {
                [heightsBySection insertObject:[NSMutableArray array] atIndex:section];
            }];
        }];
    }
    WWQPrimaryCall([self wwq_insertSections:sections withRowAnimation:animation];);
}

- (void)wwq_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.indexPathHeightCache.automaticallyInvalidateEnabled) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL *stop) {
            [self.indexPathHeightCache buildSectionsIfNeeded:section];
            [self.indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WWQIndexPathHeightsBySection *heightsBySection) {
                [heightsBySection removeObjectAtIndex:section];
            }];
        }];
    }
    WWQPrimaryCall([self wwq_deleteSections:sections withRowAnimation:animation];);
}

- (void)wwq_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.indexPathHeightCache.automaticallyInvalidateEnabled) {
        [sections enumerateIndexesUsingBlock: ^(NSUInteger section, BOOL *stop) {
            [self.indexPathHeightCache buildSectionsIfNeeded:section];
            [self.indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WWQIndexPathHeightsBySection *heightsBySection) {
                [heightsBySection[section] removeAllObjects];
            }];

        }];
    }
    WWQPrimaryCall([self wwq_reloadSections:sections withRowAnimation:animation];);
}

- (void)wwq_moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    if (self.indexPathHeightCache.automaticallyInvalidateEnabled) {
        [self.indexPathHeightCache buildSectionsIfNeeded:section];
        [self.indexPathHeightCache buildSectionsIfNeeded:newSection];
        [self.indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WWQIndexPathHeightsBySection *heightsBySection) {
            [heightsBySection exchangeObjectAtIndex:section withObjectAtIndex:newSection];
        }];
    }
    WWQPrimaryCall([self wwq_moveSection:section toSection:newSection];);
}

- (void)wwq_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.indexPathHeightCache.automaticallyInvalidateEnabled) {
        [self.indexPathHeightCache buildCachesAtIndexPathsIfNeeded:indexPaths];
        [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
            [self.indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WWQIndexPathHeightsBySection *heightsBySection) {
                [heightsBySection[indexPath.section] insertObject:@-1 atIndex:indexPath.row];
            }];
        }];
    }
    WWQPrimaryCall([self wwq_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];);
}

- (void)wwq_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.indexPathHeightCache.automaticallyInvalidateEnabled) {
        [self.indexPathHeightCache buildCachesAtIndexPathsIfNeeded:indexPaths];
        
        NSMutableDictionary<NSNumber *, NSMutableIndexSet *> *mutableIndexSetsToRemove = [NSMutableDictionary dictionary];
        [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
            NSMutableIndexSet *mutableIndexSet = mutableIndexSetsToRemove[@(indexPath.section)];
            if (!mutableIndexSet) {
                mutableIndexSet = [NSMutableIndexSet indexSet];
                mutableIndexSetsToRemove[@(indexPath.section)] = mutableIndexSet;
            }
            [mutableIndexSet addIndex:indexPath.row];
        }];
        
        [mutableIndexSetsToRemove enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSIndexSet *indexSet, BOOL *stop) {
            [self.indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WWQIndexPathHeightsBySection *heightsBySection) {
                [heightsBySection[key.integerValue] removeObjectsAtIndexes:indexSet];
            }];
        }];
    }
    WWQPrimaryCall([self wwq_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];);
}

- (void)wwq_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.indexPathHeightCache.automaticallyInvalidateEnabled) {
        [self.indexPathHeightCache buildCachesAtIndexPathsIfNeeded:indexPaths];
        [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
            [self.indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WWQIndexPathHeightsBySection *heightsBySection) {
                heightsBySection[indexPath.section][indexPath.row] = @-1;
            }];
        }];
    }
    WWQPrimaryCall([self wwq_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];);
}

- (void)wwq_moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (self.indexPathHeightCache.automaticallyInvalidateEnabled) {
        [self.indexPathHeightCache buildCachesAtIndexPathsIfNeeded:@[sourceIndexPath, destinationIndexPath]];
        [self.indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WWQIndexPathHeightsBySection *heightsBySection) {
            NSMutableArray<NSNumber *> *sourceRows = heightsBySection[sourceIndexPath.section];
            NSMutableArray<NSNumber *> *destinationRows = heightsBySection[destinationIndexPath.section];
            NSNumber *sourceValue = sourceRows[sourceIndexPath.row];
            NSNumber *destinationValue = destinationRows[destinationIndexPath.row];
            sourceRows[sourceIndexPath.row] = destinationValue;
            destinationRows[destinationIndexPath.row] = sourceValue;
        }];
    }
    WWQPrimaryCall([self wwq_moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];);
}



@end
