#import <Foundation/Foundation.h>
#import "RTNMyCamera.h"
#import "myapp-Swift.h"


@implementation RTNMyCamera
RCT_EXPORT_MODULE()

//MyCamera *myCamera = [[MyCamera alloc] init];
NSString *localId;

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
(const facebook::react::ObjCTurboModule::InitParams &)params
{
  return std::make_shared<facebook::react::NativeMyCameraSpecJSI>(params);
}

- (void)takePhoto {
  //    [myCamera takePhotoFromCamera];
  dispatch_async(dispatch_get_main_queue(), ^{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    UIViewController *root = RCTPresentedViewController();
    [root presentViewController:picker animated:YES completion:nil];
    
    //    [self presentViewController:picker animated:YES completion:nil];
  });
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
  [picker dismissViewControllerAnimated:YES completion:NULL];
  UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
  PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
  
  if (status == PHAuthorizationStatusAuthorized) {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
      localId = [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
      [EventEmitter.shared sendEventWithName:@"onMyEvent" body:localId];
      NSLog(@"%@", localId);
    }];
  } else {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
      if (status == PHAuthorizationStatusAuthorized) {
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
          localId = [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
          [EventEmitter.shared sendEventWithName:@"onMyEvent" body:localId];
          NSLog(@"%@", localId);
        }];
        
        
      }
      else {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
          [PHAssetChangeRequest creationRequestForAssetFromImage:[info valueForKey:UIImagePickerControllerOriginalImage]];
        } completionHandler:^(BOOL success, NSError *error) {
          if (success) {
            NSLog(@"Success");
          }
          else {
            NSLog(@"write error : %@",error);
          }
        }];
      }
    }];
  }
  
}

@end
