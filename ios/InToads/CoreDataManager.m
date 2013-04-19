//
//  CoreDataManager.m
//  CiteeCar
//
//  Created by Max Roustan on 08/11/12.
//  Copyright (c) 2012 Citee Car. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager
@synthesize managedObjectContext;

static CoreDataManager *sharedInstance = nil;

#pragma mark - SINGLETON STRUCTURE HANDLING

// Get the shared instance and create it if necessary.
+ (CoreDataManager*)sharedInstance
{
    if ( sharedInstance == nil )
    {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

-(id) init
{
    self = [super init];
    if ( self )
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        managedObjectContext = appDelegate.managedObjectContext;
    }
    return self;
}

// We don't want to allocate a new instance, so return the current one.
+ (id)allocWithZone:(NSZone*)zone
{
    return [self sharedInstance];
}

// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark - Manage Storage
-(void)storeData
{
    // save in DB
    NSError *error;
    
    if ( ![managedObjectContext save:&error] )
    {
        NSLog(@"ERROR store object:%@",[error localizedDescription]);
    }
}

#pragma mark - Team objects access and save methods in the database

-(Team *)createOrUpdateTeamWithName:(NSString *)name forId:(NSString *)teamId
{
    // check if we have an entry in the DB
    Team *team = [self getTeamForId:teamId];
    
    if ( team != nil )
    {
        // Entry already exists, update it.
        return [self setTeam:team forId:teamId andName:name];
    }
    else
    {
        // create new ride
        team = (Team *)[NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:managedObjectContext];
                
        return [self setTeam:team forId:teamId andName:name];
    }
}

-(Team *)getTeamForId:(NSString *)teamId
{
    // create predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(teamId=%@)", teamId];
    
    // get parameter for this key
    Team *team = (Team *)[CoreDataHelper searchObjectForEntity:@"Team" withPredicate:predicate andContext:managedObjectContext];
    
    return team;
}

-(Team *)setTeam:(Team *)team forId:(NSString *)teamId andName:(NSString *)name
{
    [team setTeamId:teamId];
    [team setName:name];
    
    return team;
}

- (NSArray *) getAllTeams
{
    NSArray *teams = [CoreDataHelper getObjectsForEntity:@"Team" withSortKey:@"teamId" andSortAscending:YES andContext:managedObjectContext];
    
    return teams;
}

#pragma mark - Riders objects access and save methods in the database

-(Rider *)createOrUpdateRiderWithName:(NSString *)name forId:(NSString *)riderId andTeamId:(NSString *)teamId
{
    // check if we have an entry in the DB
    Rider *rider = [self getRiderForId:riderId];
    
    if ( rider != nil )
    {
        // Entry already exists, update it.
        return [self setRider:rider forTeamId:teamId forId:riderId andName:name];
    }
    else
    {
        // create new ride
        rider = (Rider *)[NSEntityDescription insertNewObjectForEntityForName:@"Rider" inManagedObjectContext:managedObjectContext];
        
        return [self setRider:rider forTeamId:teamId forId:riderId andName:name];
    }
}

-(Rider *)getRiderForId:(NSString *)riderId
{
    // create predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(riderId=%@)", riderId];
    
    // get parameter for this key
    Rider *rider = (Rider *)[CoreDataHelper searchObjectForEntity:@"Rider" withPredicate:predicate andContext:managedObjectContext];
    
    return rider;
}

-(Rider *)setRider:(Rider *)rider forTeamId:(NSString *)teamId forId:(NSString *)riderId andName:(NSString *)name
{
    [rider setRiderId:riderId];
    [rider setName:name];
    
    Team *team = [self getTeamForId:teamId];
    [team addRiderObject:rider];
    
    return rider;
}

- (NSArray *) getAllRidersForTeamId:(NSString *)teamId
{
    Team *team = [self getTeamForId:teamId];
    NSMutableArray *riders = [NSMutableArray new];
    
    for (NSObject *object in team.rider) {
        [riders addObject:object];
    }
    
    return riders;
}

@end
