//
//  DDMessageSlideupController.m
//  AFNetworking
//
//  Created by wang on 2020/4/3.
//

#import "DDMessageSlideupController.h"
#import "DDMessageHeader.h"

@interface DDMessageSlideupController ()

@end

@implementation DDMessageSlideupController

- (void)beforeMoveMessageViewOnScreen
{
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(DDSLIDUPMESSAGE_W));
        make.height.equalTo(@(DDSLIDUPMESSAGE_H));
        make.centerX.equalTo(self.view.superview);
        make.top.equalTo(self.view.superview).offset(-DDSLIDUPMESSAGE_H);
        
    }];
    [self.view.superview layoutIfNeeded];
}

- (void)moveMessageViewOnScreen
{
    [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.superview).offset([DDMessageUIUitls getStatusBarSize].height);
    }];
    [self.view.superview layoutIfNeeded];
}

- (void)beforeMoveMessageViewOffScreen
{
    [self clearShadows];
}

- (void)moveMessageViewOffScreen
{
    [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.superview).offset(-DDSLIDUPMESSAGE_H);
    }];
    [self.view.superview layoutIfNeeded];
}

- (void)moveMessageViewOnScreenComplete
{
    [self drawShadows];
}
- (void)moveMessageViewOffScreenComplete
{
}


@end
