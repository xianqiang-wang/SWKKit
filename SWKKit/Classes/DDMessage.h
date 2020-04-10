//
//  DDMessage.h
//  AFNetworking
//
//  Created by wang on 2020/4/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DDMessageOrientation) {
  DDMessageOrientationAny,
  DDMessageOrientationPortrait,
  DDMessageOrientationLandscape
};


typedef NS_ENUM(NSInteger, DDMessageClickActionType) {
  DDMessageDisplayNewsFeed,
  DDMessageRedirectToURI,
  DDMessageNoneClickAction
};

typedef NS_ENUM(NSInteger, DDMessageDismissType) {
  DDMessageDismissAutomatically,
  DDMessageDismissManually
};

@interface DDMessage : NSObject

@property (nonatomic, assign) DDMessageOrientation orientation;
@property (nonatomic, assign) DDMessageClickActionType messageClickActionType;
@property (nonatomic, assign) DDMessageDismissType messageDismissType;

@property (nonatomic, strong) NSURL *uri;
@property (nonatomic, strong) NSURL *openUrlInWebView;
@property (nonatomic, assign) BOOL animateIn;
@property (nonatomic, assign) BOOL animateOut;

@property (nonatomic, assign) NSTimeInterval duration;

- (void)logMessageImpression;


@end

NS_ASSUME_NONNULL_END
