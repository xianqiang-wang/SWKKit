//
//  DDMessageWindowController.h
//  AFNetworking
//
//  Created by wang on 2020/4/2.
//

#import <UIKit/UIKit.h>
#import "DDMessageUIDelegate.h"
#import "DDMessageViewController.h"
#import "DDMessage.h"
#import "DDMessageWindow.h"


NS_ASSUME_NONNULL_BEGIN

@interface DDMessageWindowController : UIViewController
/*!
 * 显示message 的 window
 */
@property (nonatomic, strong) DDMessageWindow *window;
/*!
 * 隐藏弹窗的定时器
 */
@property (nullable) NSTimer *slideAwayTimer;

/*!
 * 显示message
 */
@property DDMessage *message;

/*!
 * UIDelegate
 */
@property (weak, nullable) id<DDMessageUIDelegate> UIDelegate;

/*!
 * 显示message 的vc
 */
@property DDMessageViewController *messageVC;

/*!
 * Properties used to properly place the slideup  messages with pan gestures.
 */
@property CGFloat slideupConstraintMaxValue;
@property CGPoint messagePreviousPanPosition;

/*!
 * The orientation mask that the  message supports.
 * The default value is UIInterfaceOrientationMaskAll
 */
@property UIInterfaceOrientationMask supportedOrientationMask;

/*!
 * The preferred orientation for  message display.
 * The default is unknown, which means the orientation would be set as Status Bar current orientation.
 */
@property UIInterfaceOrientation preferredOrientation;

/*!
 * The UIWindow of the host app.
 */
@property (weak, nonatomic, nullable) UIWindow *appWindow;

/*!
 * The variable that shows if the device is being rotated.
 */
@property BOOL isInRotation;

/*!
 * The variable that shows if the  message has been clicked.
 */
@property BOOL messageIsTapped;

/*!
 * The ID of a button that has been clicked.
 */
@property NSInteger clickedButtonId;


- (instancetype)initWithInAppMessage:(DDMessage *)message
          inAppMessageViewController:(DDMessageViewController *)messageVC
                inAppMessageDelegate:(id<DDMessageUIDelegate>)delegate;
/*!
 * @discussion This method is called when the keyboard is shown when an  message is being displayed.
 *
 * For customization, please use a subclass or category to override this method.
 */
- (void)keyboardWasShown;

/*!
 * @discussion This method is called to display the  message.
 *
 * For customization, please use a subclass or category to override this method.
 */
- (void)displayInAppMessageViewWithAnimation:(BOOL)withAnimation;

/*!
 * @discussion These methods are called to hide the  message.
 *
 * For customization, please use a subclass or category to override one of these methods.
 */
- (void)hideInAppMessageViewWithAnimation:(BOOL)withAnimation;
- (void)hideInAppMessageViewWithAnimation:(BOOL)withAnimation
                        completionHandler:(void (^ __nullable)(void))completionHandler;


@end

NS_ASSUME_NONNULL_END
