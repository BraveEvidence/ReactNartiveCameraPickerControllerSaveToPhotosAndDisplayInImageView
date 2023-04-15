#import <React/RCTLog.h>
#import <React/RCTUIManager.h>
#import <React/RCTViewManager.h>

@interface RTNMyImageManager : RCTViewManager
@end

@implementation RTNMyImageManager

RCT_EXPORT_MODULE(RTNMyImage)

RCT_EXPORT_VIEW_PROPERTY(imageUrl, NSString)

@end
