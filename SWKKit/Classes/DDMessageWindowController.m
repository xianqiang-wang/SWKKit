//
//  DDMessageWindowController.m
//  AFNetworking
//
//  Created by wang on 2020/4/2.
//

#import "DDMessageWindowController.h"
#import "DDMessageHeader.h"

@interface DDMessageWindowController ()

@end


@implementation DDMessageWindowController

- (instancetype)initWithInAppMessage:(DDMessage *)message
          inAppMessageViewController:(DDMessageViewController *)messageVC
                inAppMessageDelegate:(id<DDMessageUIDelegate>)delegate
{
    if (self = [super init]) {
        _message = message;
        _UIDelegate = (id<DDMessageUIDelegate>)delegate;
        _messageVC = messageVC;
        _window = [[DDMessageWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.catchClicksOutsideInAppMessage = NO;
        _window.backgroundColor = [UIColor clearColor];
        // Make sure the slideup is over the status bar when it slides from the top.
        _window.windowLevel = UIWindowLevelStatusBar + 1.0f;
        _window.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
        _messageIsTapped = NO;
        _clickedButtonId = -1;
        return self;
    } else {
        return nil;
    }
}

#pragma mark - Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:self.messageVC];
    [self.messageVC didMoveToParentViewController:self];
    self.view.backgroundColor = [UIColor clearColor];
    
    //  if ([self.message isKindOfClass:[ABKInAppMessageSlideup class]]) {
    //
    //    // Note: this gestureRecognizer won't catch taps which occur during the animation.
    //    UITapGestureRecognizer *inAppSlideupTapGesture = [[UITapGestureRecognizer alloc]
    //                                                      initWithTarget:self
    //                                                              action:@selector(inAppMessageTapped:)];
    //    [self.inAppMessageViewController.view addGestureRecognizer:inAppSlideupTapGesture];
    //    UIPanGestureRecognizer *inAppSlideupPanGesture = [[UIPanGestureRecognizer alloc]
    //                                                      initWithTarget:self
    //                                                              action:@selector(inAppSlideupWasPanned:)];
    //    [self.inAppMessageViewController.view addGestureRecognizer:inAppSlideupPanGesture];
    //    // We want to detect the pan gesture first, so we only recognize a tap when the pan recognizer fails.
    //    [inAppSlideupTapGesture requireGestureRecognizerToFail:inAppSlideupPanGesture];
    //  } else if ([self.inAppMessage isKindOfClass:[ABKInAppMessageImmersive class]]) {
    //    if (![ABKUIUtils objectIsValidAndNotEmpty:((ABKInAppMessageImmersive *)self.inAppMessage).buttons]) {
    //      UITapGestureRecognizer *inAppImmersiveInsideTapGesture = [[UITapGestureRecognizer alloc]
    //                                                                initWithTarget:self
    //                                                                        action:@selector(inAppMessageTapped:)];
    //      [self.inAppMessageViewController.view addGestureRecognizer:inAppImmersiveInsideTapGesture];
    //    }
    //
    //    if ([self.inAppMessage isKindOfClass:[ABKInAppMessageModal class]]) {
    //      self.inAppMessageWindow.catchClicksOutsideInAppMessage = YES;
    //    }
    //  }
    [self.view addSubview:self.messageVC.view];
}

- (BOOL)prefersStatusBarHidden {
    if ([DDWindowManager manager].forceHideStatusBar) {
        // Config override is passed from appboyOptions
        return [self.messageVC prefersStatusBarHidden];
    }
    return [UIApplication sharedApplication].statusBarHidden;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.supportedOrientationMask;
}

- (BOOL)shouldAutorotate {
    if ([UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPad &&
        self.message.orientation != DDMessageOrientationAny &&
        !self.window.hidden) {
        return NO;
    } else {
        return YES;
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    if (self.preferredOrientation != UIInterfaceOrientationUnknown) {
        return self.preferredOrientation;
    }
    return [DDMessageUIUitls getInterfaceOrientation];
}

#pragma mark - Gesture Recognizers

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return ![touch.view isKindOfClass:[DDMessageView class]];
}

//- (void)inAppSlideupWasPanned:(UIPanGestureRecognizer *)panGestureRecognizer {
//  ABKInAppMessageSlideupViewController *slideupVC = (ABKInAppMessageSlideupViewController *)self.inAppMessageViewController;
//
//  switch (panGestureRecognizer.state) {
//    case UIGestureRecognizerStateBegan: {
//      self.slideupConstraintMaxValue = slideupVC.slideConstraint.constant;
//      self.inAppMessagePreviousPanPosition = [panGestureRecognizer locationInView:self.inAppMessageViewController.view];
//      break;
//    }
//
//    case UIGestureRecognizerStateChanged: {
//      CGPoint position = [panGestureRecognizer locationInView:self.inAppMessageViewController.view];
//      CGFloat direction = ((ABKInAppMessageSlideup *)self.inAppMessage).inAppMessageSlideupAnchor
//                          == ABKInAppMessageSlideupFromBottom ? 1.0f : -1.0f;
//      CGFloat diffY = (position.y - self.inAppMessagePreviousPanPosition.y) * direction;
//
//      if (diffY > 0) {
//        // The in-ap message is moved toward the near edge of the screen. The user is attempting to
//        // dismiss the in-app message.
//        slideupVC.slideConstraint.constant -= diffY * 2.0f;
//      } else {
//        // The in-app message is moved away from the near edge of the screen. The user is NOT attempting
//        // to dismiss the in-app message.
//        CGFloat moveY = -diffY * 0.3f;
//        if (slideupVC.slideConstraint.constant + moveY <= self.slideupConstraintMaxValue) {
//          slideupVC.slideConstraint.constant += moveY;
//        } else {
//          slideupVC.slideConstraint.constant = self.slideupConstraintMaxValue;
//        }
//      }
//      self.inAppMessagePreviousPanPosition = position;
//      break;
//    }
//
//    case UIGestureRecognizerStateEnded:
//    case UIGestureRecognizerStateCancelled: {
//      // The panning is finished. If the in-app messaged moved more than 25% of the distance towards the
//      // edge, dismiss the in-app message.
//      if ((self.slideupConstraintMaxValue - slideupVC.slideConstraint.constant) >
//          self.slideupConstraintMaxValue / 4) {
//        [self invalidateSlideAwayTimer];
//
//        if ([self.inAppMessageUIDelegate respondsToSelector:@selector(onInAppMessageDismissed:)]) {
//          [self.inAppMessageUIDelegate onInAppMessageDismissed:self.inAppMessage];
//        }
//
//        CGFloat velocity = [panGestureRecognizer velocityInView:self.inAppMessageViewController.view].y;
//        velocity = fabs(velocity) > MinimumInAppMessageDismissVelocity ?
//                   velocity : MinimumInAppMessageDismissVelocity;
//        NSTimeInterval animationDuration = slideupVC.slideConstraint.constant / velocity;
//        [self.inAppMessageViewController beforeMoveMessageViewOffScreen];
//        [UIView animateWithDuration:animationDuration
//                              delay:0
//                            options:UIViewAnimationOptionBeginFromCurrentState
//                         animations:^{
//                           [self.inAppMessageViewController moveMessageViewOffScreen];
//                         }
//                         completion:^(BOOL finished){
//                           if (finished) {
//                             [self hideInAppMessageWindow];
//                           }
//                         }];
//      } else {
//        // The in-app message hasn't moved enough to be dismissed. Move it back to the original position.
//        slideupVC.slideConstraint.constant = self.slideupConstraintMaxValue;
//        [UIView animateWithDuration:0.2f animations:^{
//          [self.view layoutIfNeeded];
//        }];
//      }
//      break;
//    }
//
//    default:
//      break;
//  }
//}

- (void)inAppMessageTapped:(id)sender {
    [self invalidateSlideAwayTimer];
    self.messageIsTapped = YES;
    
    if (![self delegateHandlesInAppMessageClick]) {
        [self inAppMessageClickedWithActionType:self.message.messageClickActionType
                                            URL:self.message.uri
                               openURLInWebView:self.message.openUrlInWebView];
    }
}

#pragma mark - Timer

- (void)invalidateSlideAwayTimer {
    if (self.slideAwayTimer != nil) {
        [self.slideAwayTimer invalidate];
        self.slideAwayTimer = nil;
    }
}

- (void)inAppMessageTimerFired:(NSTimer *)timer {
    if ([self.UIDelegate respondsToSelector:@selector(messageDismissed:)]) {
        [self.UIDelegate messageDismissed:self.message];
    }
    [self hideInAppMessageViewWithAnimation:self.message.animateOut];
}

#pragma mark - Keyboard

//- (void)keyboardWasShown {
//  if (![self.inAppMessageViewController isKindOfClass:[ABKInAppMessageHTMLViewController class]]
//      && !self.inAppMessageWindow.hidden) {
//    // If the keyboard is shown while an in-app message is on the screen, we hide the in-app message
//    [self hideInAppMessageWindow];
//  }
//}

#pragma mark - Display and Hide In-app Message

- (void)displayInAppMessageViewWithAnimation:(BOOL)withAnimation {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.appWindow = [UIApplication sharedApplication].keyWindow;
        // Here we try to catch the edge case where an alert view is being shown when the in-app message is
        // displayed, so the alert view is dismissed and that can cause a crash
        if (self.appWindow.windowLevel != UIWindowLevelNormal) {
            self.appWindow = [UIApplication sharedApplication].windows[0];
        }
        // Set the root view controller after the inAppMessagewindow becomes the key window so it gets the
        // correct window size during and after rotation.
        [self.window makeKeyWindow];
        self.window.rootViewController = self;
        self.window.hidden = NO;
        
        if (self.message.messageDismissType == DDMessageDismissAutomatically) {
            self.slideAwayTimer = [NSTimer scheduledTimerWithTimeInterval:self.message.duration + messageAnimationDuration
                                                                   target:self
                                                                 selector:@selector(inAppMessageTimerFired:)
                                                                 userInfo:nil repeats:NO];
        }
        [self.view layoutIfNeeded];
        [self.messageVC beforeMoveMessageViewOnScreen];
        if (withAnimation) {
            [UIView animateWithDuration:messageAnimationDuration
                                  delay:0
                                options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                [self.messageVC moveMessageViewOnScreen];
            }
                             completion:^(BOOL finished){
                [self.messageVC moveMessageViewOnScreenComplete];
                [self.message logMessageImpression];
            }];
        } else {
            [self.messageVC moveMessageViewOnScreen];
            [self.message logMessageImpression];
        }
    });
}

- (void)hideInAppMessageViewWithAnimation:(BOOL)withAnimation {
    [self hideInAppMessageViewWithAnimation:withAnimation completionHandler:nil];
}

- (void)hideInAppMessageViewWithAnimation:(BOOL)withAnimation
                        completionHandler:(void (^ __nullable)(void))completionHandler {
    [self.slideAwayTimer invalidate];
    self.slideAwayTimer = nil;
    [self.view layoutIfNeeded];
    [self.messageVC beforeMoveMessageViewOffScreen];
    if (withAnimation) {
        [UIView animateWithDuration:messageAnimationDuration
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
            [self.messageVC moveMessageViewOffScreen];
        }
                         completion:^(BOOL finished){
            if (completionHandler) {
                completionHandler();
            }
            [self hideInAppMessageWindow];
        }];
    } else {
        [self.messageVC moveMessageViewOffScreen];
        [self hideInAppMessageWindow];
    }
}

- (void)hideInAppMessageWindow {
    [self.slideAwayTimer invalidate];
    self.slideAwayTimer = nil;
    [self.window resignKeyWindow];
    self.window.hidden = YES;
    if (self.appWindow == nil || ![self.appWindow isKindOfClass:[UIWindow class]]) {
        self.appWindow = [UIApplication sharedApplication].windows[0];
    }
    [self.appWindow makeKeyAndVisible];
    self.window = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:DDNotificationMessageWindowDismissed
                                                        object:self
                                                      userInfo:nil];
    if (self.clickedButtonId >= 0) {
        //    [(ABKInAppMessageImmersive *)self.inAppMessage logInAppMessageClickedWithButtonID:self.clickedButtonId];
    } else if (self.messageIsTapped) {
        //    [self.message logInAppMessageClicked];
    }
    //  else if ([ABKUIUtils objectIsValidAndNotEmpty:self.clickedHTMLButtonId]) {
    //    [(ABKInAppMessageHTML *)self.inAppMessage logInAppMessageHTMLClickWithButtonID:self.clickedHTMLButtonId];
    //  }
}

#pragma mark - In-app Message and Button Clicks

- (BOOL)delegateHandlesInAppMessageClick {
    if ([self.UIDelegate respondsToSelector:@selector(messageClicked:)]) {
        if ([self.UIDelegate messageClicked:self.message]) {
            return YES;
        }
    }
    return NO;
}

- (void)inAppMessageClickedWithActionType:(DDMessageClickActionType)actionType
                                      URL:(NSURL *)url
                         openURLInWebView:(BOOL)openUrlInWebView {
    [self invalidateSlideAwayTimer];
    switch (actionType) {
        case DDMessageNoneClickAction:
            break;
        case DDMessageDisplayNewsFeed:
            [self displayModalFeedView];
            break;
        case DDMessageRedirectToURI:
//            if ([ABKUIUtils objectIsValidAndNotEmpty:url]) {
//                [self handleInAppMessageURL:url inWebView:openUrlInWebView];
//            }
            break;
    }
    [self hideInAppMessageViewWithAnimation:self.message.animateOut];
}

#pragma mark - Display News Feed
- (void)displayModalFeedView {
    Class ModalFeedViewControllerClass = [DDMessageUIUitls getModalFeedViewControllerClass];
    if (ModalFeedViewControllerClass != nil) {
        UIViewController *keyWindowTopmostViewController =
        [DDMessageUIUitls topmostViewControllerWithRootViewController:self.appWindow.rootViewController];
        [keyWindowTopmostViewController presentViewController:[[ModalFeedViewControllerClass alloc] init]
                                                     animated:YES
                                                   completion:nil];
    }
}

#pragma mark - URL Handling

- (void)handleInAppMessageURL:(NSURL *)url inWebView:(BOOL)openUrlInWebView {
//    if (![self delegateHandlesInAppMessageURL:url]) {
//        [self openInAppMessageURL:url inWebView:openUrlInWebView];
//    }
}

- (BOOL)delegateHandlesInAppMessageURL:(NSURL *)url {
//    return [DDMessageUIUitls URLDelegate:[Appboy sharedInstance].appboyUrlDelegate
//                           handlesURL:url
//                          fromChannel:ABKInAppMessageChannel
//                           withExtras:self.inAppMessage.extras];
    return YES;
}

- (void)openInAppMessageURL:(NSURL *)url inWebView:(BOOL)openUrlInWebView {
    if ([DDMessageUIUitls URL:url shouldOpenInWebView:openUrlInWebView]) {
        UIViewController *keyWindowTopmostViewController =
        [DDMessageUIUitls topmostViewControllerWithRootViewController:self.appWindow.rootViewController];
        [DDMessageUIUitls displayModalWebViewWithURL:url topmostViewController:keyWindowTopmostViewController];
    } else {
        [DDMessageUIUitls openURLWithSystem:url];
    }
}

@end
