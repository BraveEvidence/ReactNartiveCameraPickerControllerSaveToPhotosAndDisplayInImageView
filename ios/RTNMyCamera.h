#import <RTNMyCameraSpec/RTNMyCameraSpec.h>
#import <React/React-Core-umbrella.h>
#import <Photos/Photos.h>
#import "EventEmitter.h"

NS_ASSUME_NONNULL_BEGIN

@interface RTNMyCamera : NSObject <NativeMyCameraSpec,UINavigationControllerDelegate,UIImagePickerControllerDelegate> 

@end

NS_ASSUME_NONNULL_END
