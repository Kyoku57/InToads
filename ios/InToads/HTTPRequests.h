//
//  HTTPRequests.h
//  Civis
//
//  Created by Mac's Roustan on 18/06/12.
//  Copyright (c) 2012 InTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPClient.h"
#import <CoreLocation/CoreLocation.h>

@interface HTTPRequests : NSObject

+ (id)sharedInstance;

-(void) sendGetTeamsListRequestWithDelegate:(id)delegate;
-(void) sendGetRidersListRequestForTeam:(NSString *)teamId WithDelegate:(id)delegate;


@end
