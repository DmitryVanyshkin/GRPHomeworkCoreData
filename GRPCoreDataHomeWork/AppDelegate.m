//
//  AppDelegate.m
//  GRPCoreDataHomeWork
//
//  Created by Дмитрий Ванюшкин on 26/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
    
    if ([NSUserDefaults.standardUserDefaults valueForKey:@"IsCoreDataLoaded"] == nil)
    {
        [NSUserDefaults.standardUserDefaults setBool:NO forKey:@"IsCoreDataLoaded"];
    }
    ViewController *vc = [ViewController new];
    
    UINavigationController *navVc = [[UINavigationController alloc]initWithRootViewController:vc];
    navVc.view.backgroundColor = UIColor.whiteColor;
    self.window.rootViewController = navVc;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  
}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
