//
//  DDMessageViewController.m
//  AFNetworking
//
//  Created by wang on 2020/4/2.
//

#import "DDMessageViewController.h"
#import "DDMessageView.h"
#import "DDMessageHeader.h"

@interface DDMessageViewController ()
@property (nonatomic, strong) UILabel *messageHeaderLabel;
@property (nonatomic, strong) UIView *btnView;

@end

@implementation DDMessageViewController
- (void)loadView
{
    self.view = [[DDMessageView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithRed:0.941 green:0.957 blue:0.969 alpha:1];
    self.view.layer.cornerRadius = 6;
    self.view.layer.masksToBounds = NO;
}

- (void)drawShadows
{
    // Redraw the shadow when the layout is changed.
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds cornerRadius:6.0];
    self.view.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:1.0].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(0.5f, 0.5f);
    self.view.layer.shadowRadius = 6.0;
    self.view.layer.shadowPath = shadowPath.CGPath;
    
    // Make opacity of shadow match opacity of the In-App Message background
    CGFloat alpha = 0;
    [self.view.backgroundColor getRed:nil green:nil blue:nil alpha:&alpha];
    self.view.layer.shadowOpacity = 1;
}

- (void)clearShadows
{
    self.view.layer.shadowOpacity = 0;
}


- (void)beforeMoveMessageViewOnScreen
{
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
       make.width.equalTo(@(2.7));
       make.height.equalTo(@(3.3));
       make.center.equalTo(self.view.superview);
    }];
    [self.view.superview layoutIfNeeded];
}

- (void)moveMessageViewOnScreen
{
    [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
       make.width.equalTo(@(270));
       make.height.equalTo(@(330));
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
       make.width.equalTo(@(2.7));
       make.height.equalTo(@(3.3));
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
