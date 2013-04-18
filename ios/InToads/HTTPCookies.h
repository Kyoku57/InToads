//
//  HTTPCookies.h
//  ACLTaxis
//
//  Created by Mac's Roustan on 26/04/12.
//  Copyright (c) 2012 InTech S.A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPCookies : NSObject

@property(strong, nonatomic) NSMutableDictionary *cookies;

+ (id)sharedInstance;

-(NSString *) getValueForName:(NSString *)cookieName;
-(BOOL) existsCookieWithName:(NSString *)cookieName;
-(BOOL) deleteCookieForName:(NSString *)cookieName;
-(void) updateCookiesInStorage;

@end
