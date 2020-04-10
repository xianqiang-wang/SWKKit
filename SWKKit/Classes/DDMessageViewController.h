//
//  DDMessageViewController.h
//  AFNetworking
//
//  Created by wang on 2020/4/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDMessageViewController : UIViewController
- (void)beforeMoveMessageViewOnScreen;
- (void)moveMessageViewOnScreen;
- (void)moveMessageViewOnScreenComplete;
- (void)beforeMoveMessageViewOffScreen;
- (void)moveMessageViewOffScreen;
- (void)moveMessageViewOffScreenComplete;

- (void)clearShadows;
- (void)drawShadows;
@end

NS_ASSUME_NONNULL_END
