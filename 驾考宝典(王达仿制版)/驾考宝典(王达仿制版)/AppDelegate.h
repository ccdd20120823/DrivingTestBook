//
//  AppDelegate.h
//  驾考宝典(王达仿制版)
//
//  Created by wangda on 15/6/2.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

    //被管理对象上下文
@property (readonly,strong,nonatomic) NSManagedObjectContext * manageObjectContext;
    //被管理对象模型
@property(readonly,strong,nonatomic) NSManagedObjectModel * managedObjectModel;
    //持久化存储协调器
@property (readonly,strong,nonatomic) NSPersistentStoreCoordinator * persistentStoreCoordinator;


-(void) saveContext;
-(NSURL *) applicationDocumentsDirectory;

@end

