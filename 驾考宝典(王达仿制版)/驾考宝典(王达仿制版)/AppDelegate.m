//
//  AppDelegate.m
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/2.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
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
}
#pragma mark - Core Data stack

@synthesize managedObjectModel = _managedObjectModel;
@synthesize manageObjectContext = _manageObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


-(NSURL * )applicationDocumentsDirectory
{
        //返回Docments路径
    NSLog(@"%@",[[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask ]lastObject]);
    
    return [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask ]lastObject];
    
    
}


-(NSManagedObjectModel *)managedObjectModel
{//被管理对象模型
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
        
    }
        //添加core data 模型
    NSURL * modelURL = [[NSBundle mainBundle]URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    return _managedObjectModel;
    
    
    
}

-(NSPersistentStoreCoordinator *) persistentStoreCoordinator
{//协调器
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
        
        
    }
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
        //存储 文件名
    NSURL * storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreData1.sqlite"];
    NSError * error = nil;
    NSString * failureReason = @"创建或加载存储数据失败";
    
        //用指定的类型，在给定的位置，加入一个持久化存储协调器
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"初始化应用存储失败";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        
        error = [NSError errorWithDomain:@"你的错误" code:9999 userInfo:dict];
        
        NSLog(@"未知错误 %@, %@",error,[error userInfo]);
        
        
        
        
        
    }
    
    return _persistentStoreCoordinator;
    
    
    
}




-(NSManagedObjectContext *) manageObjectContext
{//被管理对象上下文
    
    if (_manageObjectContext != nil) {
        return _manageObjectContext;
        
    }
    
    NSPersistentStoreCoordinator * coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
        
    }
    
    _manageObjectContext = [[NSManagedObjectContext alloc]init];
    
    [_manageObjectContext setPersistentStoreCoordinator:coordinator];
    
    return _manageObjectContext;
    
    
    
}


#pragma mark - Core Data Saving support


-(void) saveContext
{//存储
    NSManagedObjectContext * managedObjectContext = self.manageObjectContext;
    if (managedObjectContext != nil) {
        NSError * error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"未知错误 %@,%@",error,[error userInfo]);
            abort();
            
            
        }
        
    }
    
}


@end
