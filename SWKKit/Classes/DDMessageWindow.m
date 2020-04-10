//
//  DDMessageWindow.m
//  AFNetworking
//
//  Created by wang on 2020/4/2.
//

#import "DDMessageWindow.h"
#import "DDMessageView.h"

@implementation DDMessageWindow

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *hitTestResult = [super hitTest:point withEvent:event];
    UIView *testView = hitTestResult;
    if (self.catchClicksOutsideInAppMessage) {
        return hitTestResult;
    } else {
        while (testView != nil && ![testView isKindOfClass:[DDMessageView class]]) {
            testView = testView.superview;
        }
        if ([testView isKindOfClass:[DDMessageView class]]) {
            return hitTestResult;
        }
    }
    return nil;
}

@end
