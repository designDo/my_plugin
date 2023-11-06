// Autogenerated from Pigeon (v13.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN


/// The codec used by MyAPI.
NSObject<FlutterMessageCodec> *MyAPIGetCodec(void);

///flutter pub run pigeon --input lib/my_api.dart
@protocol MyAPI
- (void)sumA:(NSInteger)a b:(NSInteger)b completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
@end

extern void SetUpMyAPI(id<FlutterBinaryMessenger> binaryMessenger, NSObject<MyAPI> *_Nullable api);

NS_ASSUME_NONNULL_END