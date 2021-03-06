//
//  AppDelegate.h
//  InToads
//
//  Created by Max Roustan on 10/04/13.
//  Copyright (c) 2013 InTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
