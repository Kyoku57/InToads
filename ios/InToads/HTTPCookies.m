//
//  HTTPCookies.m
//  ACLTaxis
//
//  Created by Mac's Roustan on 26/04/12.
//  Copyright (c) 2012 InTech S.A. All rights reserved.
//

#import "HTTPCookies.h"

@implementation HTTPCookies
@synthesize cookies;


static HTTPCookies *sharedInstance = nil;

-(NSString *) getValueForName:(NSString *)cookieName {
    return [cookies valueForKey:cookieName];
}

-(BOOL)existsCookieWithName:(NSString *)cookieName{

    return([self getValueForName:cookieName]!=NULL);
}

/**
 * Delete cookie in the list and in the cookies in storage
 * @param cookieName The name of the cookie to delete
 * @return YES if the delete was done else NO
 */
-(BOOL)deleteCookieForName:(NSString *)cookieName
{
    // check if we have the cookie in the dictionnary
    if ( [self existsCookieWithName:cookieName] )
    {
        BOOL isDeleted = NO;
        
        // remove in NSHTTPCookieStorage
        NSArray *cookiesInStorage = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
        for ( NSHTTPCookie *cookieToDelete in cookiesInStorage )
        {
            if ( [cookieToDelete.name isEqualToString:cookieName] )
            {
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookieToDelete];
                isDeleted = YES;
                break;
            }
        }
        
        if ( isDeleted )
        {
            // remove in dictionnary
            [cookies removeObjectForKey:cookieName];
            
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    return NO;
}

/**
 * Update cookies list
 */
-(void)updateCookiesInStorage
{
    // get cookies in storage and set there in array
    NSArray *cookiesInStorage = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    //NSLog(@"Cookies in storage : %@", cookiesInStorage); 
    
    // init cookies list 
    cookies = [NSMutableDictionary new];
    
    // set all cookies in the list
    for( NSHTTPCookie *cookie in cookiesInStorage )
    {
        [cookies setValue:cookie.value forKey:cookie.name];
    }
    
    // log cookies list
    NSLog(@"Cookies : %@", cookies); 
}

//--------------------------------- SINGLETON STRUCTURE HANDLING --------------------------


// Get the shared instance and create it if necessary.
+ (HTTPCookies*)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];

        //[NSTimer scheduledTimerWithTimeInterval:5 target:sharedInstance selector:@selector(maybePerformEventsSync) userInfo:nil repeats:YES];
    }

    return sharedInstance;
}

-(id) init {
    self = [super init];
    if (self) {
        [self updateCookiesInStorage];
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
