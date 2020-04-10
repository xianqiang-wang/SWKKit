//
//  123.h
//  AFNetworking
//
//  Created by wang on 2020/4/2.
//

#import <Foundation/Foundation.h>
#import "DDMessage.h"
NS_ASSUME_NONNULL_BEGIN

@protocol DDMessageUIDelegate <NSObject>

- (void)messageDismissed:(DDMessage *)message;

- (BOOL)messageClicked:(DDMessage *)message;

@end

NS_ASSUME_NONNULL_END
