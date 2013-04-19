//
//  CoreDataManager.h
//  CiteeCar
//
//  Created by Max Roustan on 08/11/12.
//  Copyright (c) 2012 Citee Car. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataHelper.h"
#import "AppDelegate.h"
#import "GeolocEvent.h"
#import "Rider.h"
#import "Team.h"

@interface CoreDataManager : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (id)sharedInstance;
-(void)storeData;

- (Team *) createOrUpdateTeamWithName:(NSString *)name forId:(NSString *)teamId;
- (Team *) getTeamForId:(NSString *)teamId;
- (Team *) setTeam:(Team *)team forId:(NSString *)teamId andName:(NSString *)name;
- (NSArray *) getAllTeams;

- (Rider *) createOrUpdateRiderWithName:(NSString *)name forId:(NSString *)riderId andTeamId:(NSString *)teamId;
- (Rider *) getRiderForId:(NSString *)riderId;
- (Rider *) setRider:(Rider *)rider forTeamId:(NSString *)teamId forId:(NSString *)riderId andName:(NSString *)name;
- (NSArray *) getAllRidersForTeamId:(NSString *)teamId;

@end
