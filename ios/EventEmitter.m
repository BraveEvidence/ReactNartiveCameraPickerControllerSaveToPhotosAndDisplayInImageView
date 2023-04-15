#import "EventEmitter.h"

// Events
static NSString* onMyEvent = @"onMyEvent";

// Variable to save the instance
static EventEmitter* eventEmitter = nil;

@implementation EventEmitter

/// Exposing "EventEmitter" name to RN
RCT_EXPORT_MODULE(EventEmitter);

// Called from RN
- (instancetype)init {
  if (self = [super init]) {
    eventEmitter = self;
  }
  return self;
}

+ (BOOL)requiresMainQueueSetup {
    return NO;
}

+ (instancetype)shared {
  return eventEmitter;
}

// List of supported events
- (NSArray<NSString *> *)supportedEvents {
  return @[onMyEvent];
}

@end
