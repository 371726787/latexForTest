//
//  AppDelegate.m
//  TransferPlatform
//
//  Created by 陈测一 on 2021/9/14.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *rootVC = [[UINavigationController alloc]initWithRootViewController:[NSClassFromString(@"ViewController") new]];//Study
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
