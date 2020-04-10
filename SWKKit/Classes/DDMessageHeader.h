//
//  DDMessageHeader.h
//  Pods
//
//  Created by wang on 2020/4/2.
//
#import "DDMessageUIUitls.h"
#import "DDMessageWindow.h"
#import "DDMessageWindowController.h"
#import "DDMessageView.h"
#import "DDMessageViewController.h"
#import "DDMessage.h"
#import "DDMessageUIDelegate.h"
#import "DDWindowUIController.h"
#import "DDWindowManager.h"
#import "DDMessageSlideupController.h"
#import <Masonry/Masonry.h>
static double const messageAnimationDuration = 0.25;

static NSString * DDNotificationMessageWindowDismissed = @"DDNotificationMessageWindowDismissed";

#define DDWINDOW_W [UIScreen mainScreen].bounds.size.width
#define DDSLIDUPMESSAGE_W (DDWINDOW_W - 20)
#define DDSLIDUPMESSAGE_H (49)
