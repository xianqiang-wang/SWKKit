//
//  DDWindowManager.m
//  AFNetworking
//
//  Created by wang on 2020/4/2.
//

#import "DDWindowManager.h"

@interface DDWindowManager ()
@property (nonatomic, strong) DDWindowUIController *windowUIController;
@end

@implementation DDWindowManager
+ (instancetype)manager{
    static DDWindowManager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[self alloc] init];
        manager.windowUIController = [[DDWindowUIController alloc] init];
    });
    return manager;
}

- (void)showMessage:(DDMessage *)message
{
    [self.windowUIController showInAppMessage:message];
}

@end
