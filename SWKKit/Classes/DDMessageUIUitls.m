//
//  DDMessageUIUitls.m
//  AFNetworking
//
//  Created by wang on 2020/4/2.
//

#import "DDMessageUIUitls.h"

@implementation DDMessageUIUitls
+ (UIInterfaceOrientation)getInterfaceOrientation
{
  if (@available(iOS 13.0, *)) {
    if ([UIApplication sharedApplication].windows.firstObject.windowScene == nil) {
      return UIInterfaceOrientationPortrait;
    } else {
      return [UIApplication sharedApplication].windows.firstObject.windowScene.interfaceOrientation;
    }
  } else {
    return [UIApplication sharedApplication].statusBarOrientation;
  }
}

+ (CGSize)getStatusBarSize
{
  if (@available(iOS 13.0, *)) {
    if ([UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager == nil) {
      return CGSizeZero;
    } else {
      return [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size;
    }
  } else {
    return [UIApplication sharedApplication].statusBarFrame.size;
  }
}
@end
