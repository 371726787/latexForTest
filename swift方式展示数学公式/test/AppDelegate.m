//
//  AppDelegate.m
//  TransferPlatform
//
//  Created by chh on 2021/9/14.
//

#import "AppDelegate.h"


#import "test-Swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    UIViewController * con = [SwiftUIWrapper createHostingController];
    UINavigationController *rootVC = [[UINavigationController alloc]initWithRootViewController:con];
    self.window.rootViewController = rootVC;
    
    return YES;
}

@end
