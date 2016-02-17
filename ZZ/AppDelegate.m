//
//  AppDelegate.m
//  ZZ
//
//  Created by cheng yin on 15/12/23.
//  Copyright © 2015年 cheng yin. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "SearchViewController.h"
#import "MyViewController.h"
#import "YCLeftViewController.h"
#import "YCRootViewController.h"
#import "ShareView.h"
#import "UMSocial.h"
//#import "WXApi.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialShakeService.h"
#import "UMSocialScreenShoter.h"
//统计
//#import <Bugly/CrashReporter.h>
#import "MobClick.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setAll];
    
    [self.window setRootViewController:[self getRootVC]];
    
    return YES;
}


/**
 *  回调函数
 *
 *  @param application       <#application description#>
 *  @param url               <#url description#>
 *  @param sourceApplication <#sourceApplication description#>
 *  @param annotation        <#annotation description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    } else {
        
    }
    return result;
}

-(void)setAll
{
    //监听截屏事件
    ShareView *aaa = [[ShareView alloc] initWithFrame:CGRectMake(SCRENW-70, SCRENH-TABBAR-140, 60, 60) AboveWindow:self.window];
    [self.window addSubview:aaa];
    [self.window bringSubviewToFront:aaa];
        
    //设置友盟appkey
    [UMSocialData setAppKey:YOUMENGAPK];
    
    //不添加不会显示微信分享图标
    [UMSocialWechatHandler setWXAppId:WEIXINAPK appSecret:WEIXINSECRET url:nil];
    //不添加不会显示QQ分享图标
    [UMSocialQQHandler setQQWithAppId:QQAPPID appKey:QQAPPKEY url:@"http://www.umeng.com/social"];
    
    //友盟统计
    [MobClick startWithAppkey:YOUMENGAPK reportPolicy:BATCH channelId:nil];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    
    
    
    
//    [self shareScreenShot];
}

/**
 *  摇一摇截屏分享
 */
//-(void)shareScreenShot
//{
//    //可以设置响应摇一摇阈值，数值越低越灵敏，默认是0.8
//    [UMSocialShakeService setShakeThreshold:1.5];
//
//    [UMSocialShakeService setShakeToShareWithTypes:@[UMShareToSina,UMShareToWechatSession]
//                                         shareText:@"摇一摇截屏分享测试"
//                                      screenShoter:[UMSocialScreenShoterDefault screenShoter]
//                                  inViewController:[YCTool getCurrentVC]
//                                          delegate:nil];
//}

-(YCRootViewController*)getRootVC
{
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.hidesBottomBarWhenPushed = YES;
    UINavigationController *homeNAV = [[UINavigationController alloc] initWithRootViewController:homeVC];
    [self setNav:homeNAV image:@"home" selectedImage:@"home2" title:@"首页"];
    
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    UINavigationController *searchNAV = [[UINavigationController alloc] initWithRootViewController:searchVC];
    [self setNav:searchNAV image:@"xiangji" selectedImage:@"xiangji2" title:@"发现"];
    
    MyViewController *myVC = [[MyViewController alloc] init];
    UINavigationController *myNAV = [[UINavigationController alloc] initWithRootViewController:myVC];
    [self setNav:myNAV image:@"my" selectedImage:@"my2" title:@"我的"];
    
    
    
    UITabBarController *tabbarVC = [[UITabBarController alloc] init];
    tabbarVC.viewControllers = [NSMutableArray arrayWithObjects:homeNAV,searchNAV,myNAV, nil];
    tabbarVC.hidesBottomBarWhenPushed = YES;
    
    YCLeftViewController *leftVC = [[YCLeftViewController alloc] init];
    
    YCRootViewController *rootVC = [[YCRootViewController alloc] init];
    rootVC.hidesBottomBarWhenPushed = YES;
    rootVC.leftViewController = leftVC;
    rootVC.rootViewController = tabbarVC;
    
    rootVC.leftViewShowWidth=SCRENW/3*2;
    rootVC.needSwipeShowMenu=true;//默认开启的可滑动展示
    
    return rootVC;
}

- (void)setNav:(UINavigationController*)nav image:(NSString*)image selectedImage:(NSString*)selectedImage title:(NSString*)title
{
    nav.tabBarItem.image = [UIImage imageNamed:image];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.title = title;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "yc.ZZ" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ZZ" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ZZ.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
