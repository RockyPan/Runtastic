//
//  RTAppDelegate.h
//  Runtastic
//
//  Created by PanKyle on 14-6-11.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel * managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator * persistentStoreCoordinator;

@property (readonly, strong, nonatomic) NSDictionary * TActivity;
@property (readonly, strong, nonatomic) NSDictionary * TLocation;
@property (readonly, strong, nonatomic) NSDictionary * TLoop;
@property (readonly, strong, nonatomic) NSDictionary * TLoopType;
@property (readonly, strong, nonatomic) NSDictionary * TActivityType;

- (void) saveContext;
- (NSURL *) applicationDocumentsDirectory;

@end
