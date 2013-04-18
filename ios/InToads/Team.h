//
//  Team.h
//  InToads
//
//  Created by Max Roustan on 18/04/13.
//  Copyright (c) 2013 InTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Team : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *rider;
@end

@interface Team (CoreDataGeneratedAccessors)

- (void)addRiderObject:(NSManagedObject *)value;
- (void)removeRiderObject:(NSManagedObject *)value;
- (void)addRider:(NSSet *)values;
- (void)removeRider:(NSSet *)values;

@end
