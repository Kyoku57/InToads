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

@interface CoreDataManager : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (id)sharedInstance;
-(void)storeData;

- (Parameters *) createOrUpdateParametersWithValue:(NSString *)value forKey:(NSString *)key;
- (Parameters *)  getParametersForKey:(NSString *)key;
- (Parameters *) setParameter:(Parameters *)param forKey:(NSString *)key andValue:(NSString *)value;


- (Profile *) createOrUpdateProfileWithName:(NSString *)name city:(City *)city forId:(NSNumber *)profileId isDefault:(BOOL)isDefault;
-(Profile *) updateMobilePhone:(NSString *)mobilePhone forProfileId:(NSNumber *) profileId;
-(Profile *) updateProfileIsHost:(BOOL)isHost forProfileId:(NSNumber *) profileId;
-(Profile *) updateHomeAddress:(NSString *)address forProfileId:(NSNumber *) profileId;
-(Profile *) updateHomeLocation:(CLLocation *)location forProfileId:(NSNumber *) profileId;
-(Profile *) updateCityLocation:(CLLocation *)location forProfileId:(NSNumber *) profileId;
- (Profile *) getProfileForId:(NSNumber *)profileId;
- (NSArray *) getAllProfiles;
- (Profile *) getDefaultProfile;
- (Profile *) setProfile:(Profile *)profile forId:(NSNumber *)profileId profileName:(NSString *)name andCity:(City *)city isDefault:(BOOL)isDefault;

- (Cars *) createOrUpdateCarWithAddress:(NSString *)address addressId:(NSNumber *)addressId isAvailable:(BOOL)isAvailable nextAvailabilityIn:(NSNumber *)nextAvailability latitude:(NSNumber *)latitude andLongitude:(NSNumber *)longitude;
- (Cars *) getCarForAddressId:(NSNumber *)addressId;
- (Cars *) setCar:(Cars *)car forAddressId:(NSNumber *)addressId address:(NSString *)address isAvailable:(BOOL)isAvailable nextAvailabilityIn:(NSNumber *)nextAvailability latitude:(NSNumber *)latitude andLongitude:(NSNumber *)longitude;

- (City *) createOrUpdateCityWithName:(NSString *)cityName andLocation:(CLLocation *)cityCenter forId:(NSNumber *)cityId;
- (City *)  getCityForId:(NSNumber *)cityId;
- (City *) setCity:(City *)city withName:(NSString *)cityName andLocation:(CLLocation *)cityCenter forId:(NSNumber *)cityId;

- (Search *) createOrUpdateSearchWithAddress:(NSString *)address location:(CLLocation *)location startDate:(NSDate *)startDate endDate:(NSDate *)endDate andType:(NSString *)type;
- (Search *) createSearchWithAddress:(NSString *)address location:(CLLocation *)location startDate:(NSDate *)startDate endDate:(NSDate *)endDate andType:(NSString *)type;
- (Search *) getLastNonTimedOutSearch;
- (NSArray *) getAllSearches;
- (Search *) getLastSearch;
- (Search *) getSearchForAddress:(NSString *)address;
- (Search *) setSearch:(Search *)search address:(NSString *)address location:(CLLocation *)location startDate:(NSDate *)startDate endDate:(NSDate *)endDate andType:(NSString *)type;

@end
