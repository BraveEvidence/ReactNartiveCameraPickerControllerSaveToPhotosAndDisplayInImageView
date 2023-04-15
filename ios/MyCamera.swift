//
//  MyCamera.swift
//  myapp
//
//  Created by  on 15/04/23.
//

import Foundation
import Photos
import React
 
@objcMembers class MyCamera: NSObject,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
  
  let presentedViewController = RCTPresentedViewController()
  let viewController = UIApplication.shared.windows.first?.rootViewController

  func takePhotoFromCamera() {
    DispatchQueue.main.async {
      debugPrint("1")
      let vc = UIImagePickerController()
      vc.sourceType = .camera
      vc.allowsEditing = true
      debugPrint("2")
      vc.delegate = self
      
      self.viewController?.present(vc, animated: true)
      debugPrint("3")
//      self.presentedViewController
    }
//    present(vc, animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    debugPrint("4")
    picker.dismiss(animated: true)
    debugPrint("5")
    guard let image = info[.editedImage] as? UIImage else {
      print("No image found")
      return
    }
    debugPrint("6")
    if PHPhotoLibrary.authorizationStatus() == .authorized {
        image.saveToPhotoLibrary(completion: { localId in
            if let localId = localId {
              debugPrint("7")
              EventEmitter.shared().sendEvent(withName: "onMyEvent", body: localId)
            }
           
        })
    }  else {
      debugPrint("8")
        PHPhotoLibrary.requestAuthorization({ (status) in
          if status == .authorized {
            debugPrint("9")
              image.saveToPhotoLibrary(completion: { localId in
                  if let localId = localId {
                    EventEmitter.shared().sendEvent(withName: "onMyEvent", body: localId)
                  }
                 
              })
          } else {
            debugPrint("11")
            debugPrint("Error getting permission")
          }
        })
      }
    
    // print out the image size as a test
    print(image.size)
  }
  
}

extension UIImage {
    func saveToPhotoLibrary(completion: @escaping (String?) -> Void) {
      var localeId: String?
      PHPhotoLibrary.shared().performChanges({
        let request = PHAssetChangeRequest.creationRequestForAsset(from: self)
        localeId = request.placeholderForCreatedAsset?.localIdentifier
      }) { (isSaved, error) in

        guard isSaved else {
          
          debugPrint(error?.localizedDescription)
          
          completion(nil)
          return
        }
        guard let localeId = localeId else {
          completion(nil)
          return
        }
        let fetchOptions = PHFetchOptions()
        
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let result = PHAsset.fetchAssets(withLocalIdentifiers: [localeId], options: fetchOptions)
        
        guard let asset = result.firstObject else {
          
          completion(nil)
          return
        }
        
        UIImage.getPHAssetURL(of: asset) { (phAssetUrl) in
          completion(localeId)
        }
      }
    }
    
    static func getPHAssetURL(of asset: PHAsset, completionHandler : @escaping ((_ responseURL : URL?) -> Void))
    {
      let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
      options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
        return true
      }
      asset.requestContentEditingInput(with: options, completionHandler: { (contentEditingInput, info) in
        completionHandler(contentEditingInput!.fullSizeImageURL)
      })
      
    }
}
