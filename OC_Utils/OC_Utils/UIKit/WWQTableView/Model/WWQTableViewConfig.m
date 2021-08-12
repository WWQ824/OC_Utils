//
//  WWQTableViewConfig.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import "WWQTableViewConfig.h"

@implementation WWQTableViewConfig


- (void)setSingleLineDeleteAction:(WWQSingleLineDeleteAction)singleLineDeleteAction {
    _singleLineDeleteAction = singleLineDeleteAction;
    if (singleLineDeleteAction != nil) {
        _editable = YES;
    } else {
        _editable = NO;
    }
}

- (void)setMultiLineDeleteAction:(WWQMultiLineDeleteAction)multiLineDeleteAction {
    _multiLineDeleteAction = multiLineDeleteAction;
    if (multiLineDeleteAction != nil) {
        _editable = YES;
    } else {
        _editable = NO;
    }
}

@end
