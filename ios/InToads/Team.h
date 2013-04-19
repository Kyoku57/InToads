//
//  Team.h
//  InToads
//
//  Created by Max Roustan on 18/04/13.
//  Copyright (c) 2013 InTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Rider;

@interface Team : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * teamId;
@property (nonatomic, retain) NSSet *rider;
@end

@interface Team (CoreDataGeneratedAccessors)

- (void)addRiderObject:(Rider *)value;
- (void)removeRiderObject:(Rider *)value;
- (void)addRider:(NSSet *)values;
- (void)removeRider:(NSSet *)values;

@end
