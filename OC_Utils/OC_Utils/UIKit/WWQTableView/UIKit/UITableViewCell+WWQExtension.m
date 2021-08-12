//
//  UITableViewCell+WWQExtension.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import "UITableViewCell+WWQExtension.h"
#import "WWQTableView_marco_private.h"
#import "WWQSectionModel.h"


@implementation UITableViewCell (WWQExtension)


#pragma mark -----------------------------set方法----------------------------------

//indexPath
RETAIN_ASSOCIATION_METHOD(setSn_indexPath, sn_indexPath, NSIndexPath *)

//tableView
WEAK_ASSOCIATION_METHOD(setSn_tableView, sn_tableView, UITableView *)

//delegate
WEAK_ASSOCIATION_METHOD(setSn_delegate, sn_delegate, id)

#pragma mark ---------------------------------------------------------------------
- (CGFloat)wwq_tableView:(UITableView *)tableView cellInfo:(id)dataInfo {
    return 44.0f;
}

- (void)wwq_render:(id)dataInfo {
    if(dataInfo != nil){
        //渲染数据源
        if ([dataInfo isKindOfClass:[NSString class]]) {
            self.textLabel.text = dataInfo;
        } else if([dataInfo isKindOfClass:[WWQRowModel class]]) {
            
            WWQRowModel *rowData = dataInfo;
            // image
            id image = rowData.image;
            if ([image isKindOfClass:[NSString class]]) {
                self.imageView.image = [UIImage imageNamed:image];
            } else if([image isKindOfClass:[UIImage class]]) {
                self.imageView.image = image;
            } else {
                self.imageView.image = nil;
            }
            // title
            NSString *title = rowData.title;
            if (title.length > 0) {
                self.textLabel.text = title;
            } else {
                self.textLabel.text = nil;
            }
            // detail
            NSString *detail = rowData.detail;
            if (detail.length > 0) {
                self.detailTextLabel.text = detail;
            } else {
                self.detailTextLabel.text = nil;
            }
            //样式设置
            UIColor *titleColor = rowData.titleColor;
            UIFont *titleFont = rowData.titleFont;
            if (titleColor != nil) {
                self.textLabel.textColor = titleColor;
            }
            if (titleFont != nil) {
                self.textLabel.font = titleFont;
            }
            
            UIColor *detailColor = rowData.detailColor;
            UIFont *detailfont = rowData.detailFont;
            if (detailColor != nil) {
                self.detailTextLabel.textColor = detailColor;
            }
            if (detailfont != nil) {
                self.detailTextLabel.font = detailfont;
            }
            //accessoryType
            NSInteger type = rowData.accessoryType;
            if (type > 0) {
                self.accessoryType = type;
            }
            //accessortView
            UIView *view = rowData.accessoryView;
            self.accessoryView = view;
        }
    }
}



@end
