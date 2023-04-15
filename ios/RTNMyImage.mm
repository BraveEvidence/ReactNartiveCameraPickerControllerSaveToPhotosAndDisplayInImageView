#import "RTNMyImage.h"

#import <react/renderer/components/RTNMyImageSpecs/ComponentDescriptors.h>
#import <react/renderer/components/RTNMyImageSpecs/EventEmitters.h>
#import <react/renderer/components/RTNMyImageSpecs/Props.h>
#import <react/renderer/components/RTNMyImageSpecs/RCTComponentViewHelpers.h>
#import "myapp-Swift.h"
#import "RCTFabric/React-RCTFabric-umbrella.h"
//#import "RCTFabricComponentsPlugins.h"


using namespace facebook::react;

@interface RTNMyImage () <RCTRTNMyImageViewProtocol>
@end

@implementation RTNMyImage {
  UIView *_view;
    MyImage *myImage;
//  UIImageView *_imageView;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<RTNMyImageComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const RTNMyImageProps>();
    _props = defaultProps;
    
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        myImage = [[MyImage alloc] initWithFrame:_view.bounds url:@""];
        [_view addSubview: myImage];
    
//    [_view addSubview:_imageView];
//
//    _imageView.translatesAutoresizingMaskIntoConstraints = false;
//    [NSLayoutConstraint activateConstraints:@[
//      [_imageView.leadingAnchor constraintEqualToAnchor:_view.leadingAnchor],
//      [_imageView.topAnchor constraintEqualToAnchor:_view.topAnchor],
//      [_imageView.trailingAnchor constraintEqualToAnchor:_view.trailingAnchor],
//      [_imageView.bottomAnchor constraintEqualToAnchor:_view.bottomAnchor],
//    ]];
    
    self.contentView = _view;
  }
  
  return self;
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &oldViewProps = *std::static_pointer_cast<RTNMyImageProps const>(_props);
  const auto &newViewProps = *std::static_pointer_cast<RTNMyImageProps const>(props);
  
  if (oldViewProps.imageUrl != newViewProps.imageUrl) {
        myImage.url = [[NSString alloc] initWithCString:newViewProps.imageUrl.c_str() encoding:NSASCIIStringEncoding];
//    NSLog(@"111111");
//    NSString *localId = [[NSString alloc] initWithCString:newViewProps.imageUrl.c_str() encoding:NSASCIIStringEncoding];
//    NSLog(@"2222222");
//    PHImageManager *manager = [PHImageManager defaultManager];
//    NSLog(@"3333333");
//    PHFetchResult<PHAsset *> *result = [PHAsset fetchAssetsWithLocalIdentifiers: @[localId] options:NULL];
//    NSLog(@"44444444");
//    [manager requestImageForAsset:result.firstObject targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:[[PHImageRequestOptions alloc] init] resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//      NSLog(@"55555555");
//      [self->_imageView setImage:result];
//    }];
  }
  
  [super updateProps:props oldProps:oldProps];
}

@end

Class<RCTComponentViewProtocol> RTNMyImageCls(void)
{
  return RTNMyImage.class;
}
