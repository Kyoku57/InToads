//
//  Rider.h
//  InToads
//
//  Created by Max Roustan on 18/04/13.
//  Copyright (c) 2013 InTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Team;

@interface Rider : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Team *team;

@end
