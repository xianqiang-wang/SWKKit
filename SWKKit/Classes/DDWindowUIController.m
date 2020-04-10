//
//  DDWindowUIController.m
//  AFNetworking
//
//  Created by wang on 2020/4/2.
//

#import "DDWindowUIController.h"
#import "DDMessageHeader.h"

@interface DDWindowUIController ()

@end

@implementation DDWindowUIController

- (instancetype)init {
  if (self = [super init]) {
    _supportedOrientationMask = UIInterfaceOrientationMaskAll;
    _preferredOrientation = UIInterfaceOrientationUnknown;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveKeyboardWasShownNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveKeyboardDidHideNotification:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(messageWindowDismissed:)
                                                 name:DDNotificationMessageWindowDismissed
                                               object:nil];
  }
  return self;
}

#pragma mark - Show and Hide In-app Message

- (void)showInAppMessage:(DDMessage *)message
{
  if ([UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPad) {
    // Check the device orientation before displaying the in-app message
    UIInterfaceOrientation statusBarOrientation = [DDMessageUIUitls getInterfaceOrientation];
    NSString *errorMessage = @"The in-app message %@ with %@ orientation shouldn't be displayed in %@, disregarding this in-app message.";
    if (message.orientation == DDMessageOrientationPortrait &&
        !UIInterfaceOrientationIsPortrait(statusBarOrientation)) {
      NSLog(errorMessage, message, @"portrait", @"landscape");
      return;
    }
    if (message.orientation == DDMessageOrientationLandscape &&
        !UIInterfaceOrientationIsLandscape(statusBarOrientation)) {
      NSLog(errorMessage, message, @"landscape", @"portrait");
      return;
    }
  }
  
//  if ([message isKindOfClass:[ABKInAppMessageImmersive class]]) {
//    ABKInAppMessageImmersive *immersiveInAppMessage = (ABKInAppMessageImmersive *)inAppMessage;
//    if (immersiveInAppMessage.imageStyle == ABKInAppMessageGraphic &&
//        ![ABKUIUtils objectIsValidAndNotEmpty:immersiveInAppMessage.imageURI]) {
//      NSLog(@"The in-app message has graphic image style but no image, discard this in-app message.");
//      return;
//    }
//    if ([immersiveInAppMessage isKindOfClass:[ABKInAppMessageFull class]] &&
//        ![ABKUIUtils objectIsValidAndNotEmpty:immersiveInAppMessage.imageURI]) {
//      NSLog(@"The in-app message is a full in-app message without an image, discard this in-app message.");
//      return;
//    }
//  }
//
//  if (inAppMessage.inAppMessageClickActionType == ABKInAppMessageNoneClickAction &&
//      [inAppMessage isKindOfClass:[ABKInAppMessageSlideup class]]) {
//    ((ABKInAppMessageSlideup *)inAppMessage).hideChevron = YES;
//  }
  
//  ABKInAppMessageViewController *inAppMessageViewController = nil;
//  if ([self.uiDelegate respondsToSelector:@selector(inAppMessageViewControllerWithInAppMessage:)]) {
//    inAppMessageViewController = [self.uiDelegate inAppMessageViewControllerWithInAppMessage:inAppMessage];
//  } else {
//    if ([inAppMessage isKindOfClass:[ABKInAppMessageSlideup class]]) {
//      inAppMessageViewController = [[ABKInAppMessageSlideupViewController alloc]
//                                    initWithInAppMessage:inAppMessage];
//    } else if ([inAppMessage isKindOfClass:[ABKInAppMessageModal class]]) {
//      inAppMessageViewController = [[ABKInAppMessageModalViewController alloc]
//                                    initWithInAppMessage:inAppMessage];
//    } else if ([inAppMessage isKindOfClass:[ABKInAppMessageFull class]]) {
//      inAppMessageViewController = [[ABKInAppMessageFullViewController alloc]
//                                    initWithInAppMessage:inAppMessage];
//    } else if ([inAppMessage isKindOfClass:[ABKInAppMessageHTMLFull class]]) {
//      inAppMessageViewController = [[ABKInAppMessageHTMLFullViewController alloc]
//                                    initWithInAppMessage:inAppMessage];
//    }
//  }
    
    DDMessageViewController *messageVC = [[DDMessageViewController alloc] init];
    DDMessageSlideupController *messageSLVC = [[DDMessageSlideupController alloc] init];

    if (messageSLVC) {
        DDMessageWindowController *windowController = [[DDMessageWindowController alloc]
                                                             initWithInAppMessage:message
                                                             inAppMessageViewController:messageSLVC
                                                             inAppMessageDelegate:self.uiDelegate];
        windowController.supportedOrientationMask = self.supportedOrientationMask;
        windowController.preferredOrientation = self.preferredOrientation;
        self.windowController = windowController;
        [self.windowController displayInAppMessageViewWithAnimation:message.animateIn];
    }
}


- (void)messageWindowDismissed:(NSNotification *)notification {
  self.windowController = nil;
}

#pragma mark - Keyboard

- (void)receiveKeyboardDidHideNotification:(NSNotification *)notification {
  self.keyboardVisible = NO;
}

- (void)receiveKeyboardWasShownNotification:(NSNotification *)notification {
  self.keyboardVisible = YES;
  [self.windowController keyboardWasShown];
}



#pragma mark - Dealloc

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
