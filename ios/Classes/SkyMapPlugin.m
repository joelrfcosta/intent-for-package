#import "IntentForPackagePlugin.h"

@implementation FLTIntentForPackagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel =
      [FlutterMethodChannel methodChannelWithName:@"plugins.sadcoat.com/intent_for_package"
                                  binaryMessenger:[registrar messenger]];
  FLTIntentForPackagePlugin* instance = [[FLTIntentForPackagePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  result(FlutterMethodNotImplemented);
}

@end
