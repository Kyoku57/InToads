//
//  HTTPRequests.m
//  Civis
//
//  Created by Mac's Roustan on 18/06/12.
//  Copyright (c) 2012 InTech. All rights reserved.
//

#import "HTTPRequests.h"

@implementation HTTPRequests

static HTTPRequests *sharedInstance = nil;

-(void)sendGetTeamsListRequestWithDelegate:(id)delegate
{
    [[HTTPClient sharedInstance] sendHttpRequestToURL:@"teams" withMethod:@"GET" params:[NSDictionary new] delegate:delegate sendingCookie:NO];
}

-(void) sendGetRidersListRequestForTeam:(NSString *)teamId WithDelegate:(id)delegate
{
    NSString *url = [NSString stringWithFormat:@"team/%@", teamId];
    [[HTTPClient sharedInstance] sendHttpRequestToURL:url withMethod:@"GET" params:[NSDictionary new] delegate:delegate sendingCookie:NO];

}


#pragma mark - SINGLETON STRUCTURE HANDLING


// Get the shared instance and create it if necessary.
+ (HTTPRequests*)sharedInstance {
    
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

-(id) init {
    self = [super init];
    if (self) {
    }
    return self;
    
}

// We don't want to allocate a new instance, so return the current one.
+ (id)allocWithZone:(NSZone*)zone {
    return [self sharedInstance];
}

// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
