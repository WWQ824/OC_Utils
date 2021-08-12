//
//  UITableView+Private.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import "UITableView+Private.h"
#import <objc/runtime.h>
#import "UITableView+WWQExtension.h"
#import "WWQImpTableViewDelegate.h"
#import "WWQImpTableViewDataSource.h"


static NSString *const _cellID = @"tableViewCellID";

static NSString *const _headerViewID = @"tableViewHeaderID";

NSString *wwq_tableView_cellID(NSUInteger type) {
    return [_cellID stringByAppendingFormat:@"_%@", @(type)];
}

NSString *wwq_tableView_header_cellID(NSUInteger type) {
    return [_headerViewID stringByAppendingFormat:@"_%@", @(type)];
}


@implementation UITableView (Private)


- (void)wwq_dynamic:(id)delegate {
    [self wwq_dynamicDelegate:delegate];
    [self wwq_dynamicDataSource:delegate];
}

- (void)wwq_dynamicDelegate:(id)delegate {
    [self impDelegate:delegate];
    self.delegate = delegate;
}

- (void)wwq_dynamicDataSource:(id)dataSource {
    [self impDataSource:dataSource];
    self.dataSource = dataSource;
}

- (void)impDataSource:(id)dataSource {
    if (dataSource == nil) {
        return;
    }
    //因调用频率较低固可以用此种简单的加锁方式
    SEL selectors[] = {
        @selector(tableView:cellForRowAtIndexPath:),
        @selector(numberOfSectionsInTableView:),
        @selector(tableView:numberOfRowsInSection:),
        @selector(tableView:titleForHeaderInSection:),
        /***************************************************/
        @selector(sectionIndexTitlesForTableView:),
        /*************************edit**************************/
        @selector(tableView:canEditRowAtIndexPath:),
        @selector(tableView:commitEditingStyle:forRowAtIndexPath:),
        @selector(tableView:canMoveRowAtIndexPath:)
    };
    WWQ_TABLEVIEW_ADDMETHOD(selectors,sizeof(selectors)/sizeof(SEL), [dataSource class],[WWQImpTableViewDataSource class]);
}

- (void)impDelegate:(id)delegate {
    if (delegate == nil) {
        return;
    }
    SEL selectors[] = {
        @selector(tableView:heightForRowAtIndexPath:),
        @selector(tableView:willDisplayCell:forRowAtIndexPath:),
        @selector(tableView:didSelectRowAtIndexPath:),
        
        @selector(tableView:viewForHeaderInSection:),
        @selector(tableView:willDisplayHeaderView:forSection:),
        @selector(tableView:heightForHeaderInSection:),
        /*************************edit**************************/
        @selector(tableView:editingStyleForRowAtIndexPath:),
        @selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:),
    };
    //如果你设置了rowHeight，则不需要我们来处理heightForRowAtIndexPath，当然你需要在setDelegate之前设置rowHeight，否则我们当做没看到
    if (self.rowHeight > 0) {
        selectors[0] = NULL;
    }
    WWQ_TABLEVIEW_ADDMETHOD(selectors,sizeof(selectors)/sizeof(SEL), [delegate class],[WWQImpTableViewDelegate class]);
}

void WWQ_TABLEVIEW_ADDMETHOD(SEL *selectors,int count, Class toClass, Class impClass){
    Class kClass = [toClass class];
    Class dClass = impClass;
    for (NSUInteger index = 0; index < count; index++) {
        SEL originalSelector = selectors[index];
        if (originalSelector == NULL) {
            continue;
        }
        IMP originalImp = class_getMethodImplementation(kClass, originalSelector);
        IMP realImp = class_getMethodImplementation(dClass, originalSelector);
        if (originalImp != realImp) {
            Method method = class_getInstanceMethod(dClass, originalSelector);
            const char *type =  method_getTypeEncoding(method);
            //如果有方法了 add会失败的，add失败说明由你来处理喽
            class_addMethod(kClass, originalSelector, realImp,type);
        }
        
    }
}



@end
