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

#pragma mark - Parameters objects access and save methods in the database

- (Parameters *) createOrUpdateParametersWithValue:(NSString *)value forKey:(NSString *)key
{
    // check if we have an entry in the DB
    Parameters *param = [self getParametersForKey:key];
    
    if ( param != nil )
    {
        // Entry already exists, update it.
        return [self setParameter:param forKey:key andValue:value];
    }
    else
    {
        // create new ride
        param = (Parameters *)[NSEntityDescription insertNewObjectForEntityForName:@"Parameters" inManagedObjectContext:managedObjectContext];
                
        return [self setParameter:param forKey:key andValue:value];
    }
}

- (Parameters *)  getParametersForKey:(NSString *)key
{
    // create predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(key=%@)", key];
    
    // get parameter for this key
    Parameters *param = (Parameters *)[CoreDataHelper searchObjectForEntity:@"Parameters" withPredicate:predicate andContext:managedObjectContext];
    
    return param;
}

- (Parameters *) setParameter:(Parameters *)param forKey:(NSString *)key andValue:(NSString *)value {
    [param setKey:key];
    [param setValue:value];
    
    return param;
}

#pragma mark - City objects access and save methods in the database

- (City *) createOrUpdateCityWithName:(NSString *)cityName andLocation:(CLLocation *)cityCenter forId:(NSNumber *)cityId
{
    // check if we have an entry in the DB
    City *city = [self getCityForId:cityId];
    
    if ( city != nil )
    {
        // Entry already exists, update it.
        return [self setCity:city withName:cityName andLocation:cityCenter forId:cityId];
    }
    else
    {
        // create new ride
        city = (City *)[NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:managedObjectContext];
        
        return [self setCity:city withName:cityName andLocation:cityCenter forId:cityId];
    }
}

- (City *)  getCityForId:(NSNumber *)cityId
{
    // create predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(cityId=%@)", cityId];
    
    // get parameter for this key
    City *city = (City *)[CoreDataHelper searchObjectForEntity:@"City" withPredicate:predicate andContext:managedObjectContext];
    
    return city;
}

- (City *) setCity:(City *)city withName:(NSString *)cityName andLocation:(CLLocation *)cityCenter forId:(NSNumber *)cityId {
    [city setCityId:cityId];
    [city setCityName:cityName];
    [city setCityLatitude:[NSNumber numberWithDouble:cityCenter.coordinate.latitude]];
    [city setCityLongitude:[NSNumber numberWithDouble:cityCenter.coordinate.longitude]];

    return city;
}

#pragma mark - Profiles objects access and save methods in the database

-(Profile *)createOrUpdateProfileWithName:(NSString *)name city:(City *)city forId:(NSNumber *)profileId isDefault:(BOOL)isDefault
{
    // check if we have an entry in the DB
    Profile *profile = [self getProfileForId:profileId];
    
    if ( profile != nil )
    {
        // Entry already exists, update it.
        return [self setProfile:profile forId:profileId profileName:name andCity:city isDefault:isDefault];
    }
    else
    {
        // create new ride
        profile = (Profile *)[NSEntityDescription insertNewObjectForEntityForName:@"Profile" inManagedObjectContext:managedObjectContext];
        
        return [self setProfile:profile forId:profileId profileName:name andCity:city isDefault:isDefault];
    }
}

-(Profile *) updateMobilePhone:(NSString *)mobilePhone forProfileId:(NSNumber *) profileId
{
    Profile *profile = [self getProfileForId:profileId];
    [profile setMobilePhone:mobilePhone];
    
    return profile;
}

-(Profile *) updateProfileIsHost:(BOOL)isHost forProfileId:(NSNumber *) profileId
{
    Profile *profile = [self getProfileForId:profileId];
    [profile setIsHost:[NSNumber numberWithBool:isHost]];
    
    return profile;
}

-(Profile *) updateHomeAddress:(NSString *)address forProfileId:(NSNumber *) profileId
{
    Profile *profile = [self getProfileForId:profileId];
    [profile setHomeAddress:address];
    
    return profile;
}

-(Profile *) updateHomeLocation:(CLLocation *)location forProfileId:(NSNumber *) profileId
{
    Profile *profile = [self getProfileForId:profileId];
    if(location != nil)
    {
        [profile setHomeLatitude:[NSNumber numberWithDouble:location.coordinate.latitude]];
        [profile setHomeLongitude:[NSNumber numberWithDouble:location.coordinate.longitude]];
    }
    
    return profile;
}

-(Profile *) updateCityLocation:(CLLocation *)location forProfileId:(NSNumber *) profileId
{
    Profile *profile = [self getProfileForId:profileId];
    if(location != nil)
    {
        [profile.city setCityLatitude:[NSNumber numberWithDouble:location.coordinate.latitude]];
        [profile.city setCityLongitude:[NSNumber numberWithDouble:location.coordinate.longitude]];
    }
    
    return profile;
}

-(Profile *)getProfileForId:(NSNumber *)profileId
{
    // create predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(profileId=%@)", profileId];
    
    // get parameter for this key
    Profile *profile = (Profile *)[CoreDataHelper searchObjectForEntity:@"Profile" withPredicate:predicate andContext:managedObjectContext];
    
    return profile;
}

-(NSArray *) getAllProfiles
{
    // get parameter for this key
    NSArray *profiles = [CoreDataHelper getObjectsForEntity:@"Profile" withSortKey:@"profileId" andSortAscending:YES andContext:managedObjectContext];
    
    return profiles;
}

- (Profile *)getDefaultProfile
{
    // create predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(isDefaultProfile=%@)", [NSNumber numberWithBool:YES]];
    
    // get parameter for this key
    Profile *defaultProfile = (Profile *)[CoreDataHelper searchObjectForEntity:@"Profile" withPredicate:predicate andContext:managedObjectContext];
    
    return defaultProfile;
}


-(Profile *)setProfile:(Profile *)profile forId:(NSNumber *)profileId profileName:(NSString *)name andCity:(City *)city isDefault:(BOOL)isDefault
{
    [profile setProfileId:profileId];
    [profile setName:name];
    [profile setCity:city];
    
    /* We remove the old default city when the user change it.
     */
    Profile *oldDefaultProfile = [self getDefaultProfile];

    [oldDefaultProfile setIsDefaultProfile:[NSNumber numberWithBool:NO]];
    
    [profile setIsDefaultProfile:[NSNumber numberWithBool:isDefault]];
        
    return profile;
}

#pragma mark - Cars (or Stations) objects access and save methods in the database

- (Cars *) createOrUpdateCarWithAddress:(NSString *)address addressId:(NSNumber *)addressId isAvailable:(BOOL)isAvailable nextAvailabilityIn:(NSNumber *)nextAvailability latitude:(NSNumber *)latitude andLongitude:(NSNumber *)longitude
{
    // check if we have an entry in the DB
    Cars *car = [self getCarForAddressId:addressId];
    
    if ( car != nil )
    {
        // Entry already exists, update it.
        return [self setCar:car forAddressId:addressId address:address isAvailable:isAvailable nextAvailabilityIn:nextAvailability latitude:latitude andLongitude:longitude];
    }
    else
    {
        // create new ride
        car = (Cars *)[NSEntityDescription insertNewObjectForEntityForName:@"Cars" inManagedObjectContext:managedObjectContext];
        
        return [self setCar:car forAddressId:addressId address:address isAvailable:isAvailable nextAvailabilityIn:nextAvailability latitude:latitude andLongitude:longitude];
    }

}

- (Cars *) getCarForAddressId:(NSNumber *)addressId
{
    // create predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(addressId=%@)", addressId];
    
    // get parameter for this key
    Cars *car = (Cars *)[CoreDataHelper searchObjectForEntity:@"Cars" withPredicate:predicate andContext:managedObjectContext];
    
    return car;
}

- (Cars *) setCar:(Cars *)car forAddressId:(NSNumber *)addressId address:(NSString *)address isAvailable:(BOOL)isAvailable nextAvailabilityIn:(NSNumber *)nextAvailability latitude:(NSNumber *)latitude andLongitude:(NSNumber *)longitude
{
    [car setAddress:address];
    [car setAddressId:addressId];
    [car setAvailable:[NSNumber numberWithBool:isAvailable]];
    [car setNextAvailabilityIn:nextAvailability];
    [car setLatitude:latitude];
    [car setLongitude:longitude];
    
    return car;
}

#pragma mark - Search history handling methods

- (Search *) createOrUpdateSearchWithAddress:(NSString *)address location:(CLLocation *)location startDate:(NSDate *)startDate endDate:(NSDate *)endDate andType:(NSString *)type
{
    // check if we have an entry in the DB
    Search *search = [self getSearchForAddress:address];
    
    if ( search != nil )
    {
        // Entry already exists, update it.
        return [self setSearch:search address:address location:location startDate:startDate endDate:endDate andType:type];
    }
    else
    {
        // create new ride
        search = (Search *)[NSEntityDescription insertNewObjectForEntityForName:@"Search" inManagedObjectContext:managedObjectContext];
        
        return [self setSearch:search address:address location:location startDate:startDate endDate:endDate andType:type];
    }
}

- (Search *) createSearchWithAddress:(NSString *)address location:(CLLocation *)location startDate:(NSDate *)startDate endDate:(NSDate *)endDate andType:(NSString *)type
{
    // create new ride
    Search *search = (Search *)[NSEntityDescription insertNewObjectForEntityForName:@"Search" inManagedObjectContext:managedObjectContext];
    
    return [self setSearch:search address:address location:location startDate:startDate endDate:endDate andType:type];
}


- (Search *) getLastNonTimedOutSearch
{
    NSDate *maxDateBeforeIgnore = [NSDate dateWithTimeInterval:(NOW_DATE_DELAY_MINUTES*60) sinceDate:[NSDate new]];
    
    // create predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(lastUpdated>%@)", maxDateBeforeIgnore];
    
    // get parameter for this key
    NSArray *arrayOfLastSearches = [CoreDataHelper searchObjectsForEntity:@"Search" withPredicate:predicate andSortKey:@"lastUpdated" andSortAscending:NO andContext:managedObjectContext];
    
    
    Search *search = nil;
    
    if ([arrayOfLastSearches count] > 0) {
        search = (Search *) [arrayOfLastSearches objectAtIndex:0];
    }
    
    return search;
}

- (NSArray *) getAllSearches
{
    NSArray *searches = [CoreDataHelper getObjectsForEntity:@"Search" withSortKey:@"searchId" andSortAscending:YES andContext:managedObjectContext];
    
    return searches;
}

- (Search *) getLastSearch
{
    NSArray *searches = [CoreDataHelper getObjectsForEntity:@"Search" withSortKey:@"lastUpdated" andSortAscending:NO andContext:managedObjectContext];

    if([searches count] > 0)
    {
        Search *lastSearch = (Search *)[searches objectAtIndex:0];

        NSLog(@"Last updated : %@", lastSearch.lastUpdated);
        return lastSearch;
    }
    else
        return nil;
}

- (Search *)  getSearchForAddress:(NSString *)address
{
    // create predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(address=%@)", address];
    
    // get parameter for this key
    Search *search = (Search *)[CoreDataHelper searchObjectForEntity:@"Search" withPredicate:predicate andContext:managedObjectContext];
    
    return search;
}

- (Search *) setSearch:(Search *)search address:(NSString *)address location:(CLLocation *)location startDate:(NSDate *)startDate endDate:(NSDate *)endDate andType:(NSString *)type
{
    [search setAddress:address];
    [search setStartDate:startDate];
    [search setEndDate:endDate];
    [search setLastUpdated:[NSDate new]];
    [search setType:type];
    [search setLatitude:[NSNumber numberWithDouble:location.coordinate.latitude]];
    [search setLongitude:[NSNumber numberWithDouble:location.coordinate.longitude]];
    
    return search;
}

@end
