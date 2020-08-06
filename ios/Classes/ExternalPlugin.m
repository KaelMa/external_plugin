#import "ExternalPlugin.h"
#if __has_include(<external_plugin/external_plugin-Swift.h>)
#import <external_plugin/external_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "external_plugin-Swift.h"
#endif

@implementation ExternalPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftExternalPlugin registerWithRegistrar:registrar];
}
@end
