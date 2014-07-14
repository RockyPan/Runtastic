//
//  RTAppDelegate.m
//  Runtastic
//
//  Created by PanKyle on 14-6-11.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTAppDelegate.h"
#import <CoreData/CoreData.h>


@implementation RTAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize TActivity = _TActivity;
@synthesize TActivityType = _TActivityType;
@synthesize TLocation = _TLocation;
@synthesize TLoop = _TLoop;
@synthesize TLoopType = _TLoopType;

- (NSDictionary *) TActivity {
    if (nil == _TActivity) {
        _TActivity =
        @{@"name"       : @"Activity",
          @"ADateTime"  : @"dateTime",
          @"ADistance"  : @"distance",
          @"ADuration"  : @"duration",
          @"AHeartRate" : @"heartRate",
          @"ALog"       : @"log",
          @"AOrigin"    : @"origin",
          @"ATemperature" : @"temperature",
          @"RLocation"  : @"location",
          @"RLoops"     : @"loops",
          @"RActivityType" : @"activityType"
          };
    }
    return _TActivity;
}

- (NSManagedObjectContext *) managedObjectContext
{
    if (nil == _managedObjectContext) {
        NSPersistentStoreCoordinator * coordinator = [self persistentStoreCoordinator];
        if (nil != coordinator) {
            _managedObjectContext = [[NSManagedObjectContext alloc] init];
            [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        }
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *) managedObjectModel
{
    if (nil == _managedObjectModel) {
        NSURL * modelURL = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator
{
    if (nil == _persistentStoreCoordinator) {
        NSURL * storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"data.sqlite"];
        NSError * error = nil;
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                       configuration:nil
                                                                 URL:storeURL
                                                             options:nil
                                                               error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    return _persistentStoreCoordinator;
}

- (void) saveContext
{
    NSError * error = nil;
    NSManagedObjectContext * managedObjectContext = self.managedObjectContext;
    if (nil != managedObjectContext) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
