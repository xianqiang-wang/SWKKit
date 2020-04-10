//
//  DDWindowUIController.h
//  AFNetworking
//
//  Created by wang on 2020/4/2.
//

#import <UIKit/UIKit.h>
#import "DDMessageHeader.h"


NS_ASSUME_NONNULL_BEGIN

@interface DDWindowUIController : UIViewController
@property  (nonatomic, assign) UIInterfaceOrientationMask supportedOrientationMask;
@property  (nonatomic, assign) UIInterfaceOrientation preferredOrientation;
@property (nonatomic, assign) BOOL keyboardVisible;
@property (nonatomic, strong) DDMessageWindowController *windowController;
@property (nonatomic, weak) id<DDMessageUIDelegate> uiDelegate;

- (void)showInAppMessage:(DDMessage *)message;
@end

NS_ASSUME_NONNULL_END
