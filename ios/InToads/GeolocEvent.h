//
//  GeolocEvent.h
//  InToads
//
//  Created by Max Roustan on 18/04/13.
//  Copyright (c) 2013 InTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GeolocEvent : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSNumber * altitude;

@end
