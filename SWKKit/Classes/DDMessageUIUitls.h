//
//  DDMessageUIUitls.h
//  AFNetworking
//
//  Created by wang on 2020/4/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDMessageUIUitls : NSObject
+ (NSString *)getLocalizedString:(NSString *)key inAppboyBundle:(NSBundle *)appboyBundle table:(NSString *)table;
+ (BOOL)objectIsValidAndNotEmpty:(id)object;
+ (Class)getSDWebImageProxyClass;
+ (Class)getModalFeedViewControllerClass;
+ (BOOL)isNotchedPhone;
+ (UIImage *)getImageWithName:(NSString *)name
                         type:(NSString *)type
               inAppboyBundle:(NSBundle *)appboyBundle;
+ (UIInterfaceOrientation)getInterfaceOrientation;
+ (CGSize)getStatusBarSize;




+ (BOOL)URL:(NSURL *)url shouldOpenInWebView:(BOOL)openUrlInWebView;
+ (void)openURLWithSystem:(NSURL *)url;
+ (UIViewController *)topmostViewControllerWithRootViewController:(UIViewController *)viewController;
+ (void)displayModalWebViewWithURL:(NSURL *)url
             topmostViewController:(UIViewController *)topmostViewController;
+ (NSURL *)getEncodedURIFromString:(NSString *)uriString;

@end

NS_ASSUME_NONNULL_END
