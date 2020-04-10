//
//  DDWindowManager.h
//  AFNetworking
//
//  Created by wang on 2020/4/2.
//

#import <Foundation/Foundation.h>
#import "DDWindowUIController.h"
#import "DDMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDWindowManager : NSObject
@property (nonatomic, assign) BOOL forceHideStatusBar;
+ (instancetype)manager;

- (void)showMessage:(DDMessage *)message;
@end

NS_ASSUME_NONNULL_END
