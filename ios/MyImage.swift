import UIKit
import Photos

@objcMembers class MyImage: UIView {
  
  var imageView: UIImageView!
  
  var url: String? {
    didSet{
      
        if let url = url {
          debugPrint("Swift url \(url)")
          if url != ""  {
            getPhotoInLibrary(localId: url)
          }
        }
      
    }
    willSet(myNewValue) {
      print("Called before setting the new value")
    }
  }
 //Called before setting the new value
  func getPhotoInLibrary(localId: String) {
    debugPrint("Local1 \(localId)")
    let result = PHAsset.fetchAssets(withLocalIdentifiers: [localId], options: nil)
    debugPrint("Local2 \(localId)")
    guard let asset = result.firstObject else {
      return
    }
    debugPrint("Local3 \(localId)")
    
    PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: PHImageRequestOptions()) {  image, _ in
      self.imageView.image = image
    }
  }
  
  init(frame: CGRect,url: String) {
    self.url = url
     //Called before setting the new value error
    super.init(frame: frame)
    imageView = UIImageView()
    addSubview(imageView)
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
    imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
