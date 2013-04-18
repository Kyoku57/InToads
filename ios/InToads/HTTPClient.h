//
//  HTTPClient.h
//  ACLTaxis
//
//  Created by Mac's Roustan on 26/04/12.
//  Copyright (c) 2012 InTech S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPCookies.h"
#import "Reachability.h"
#import "Consts.h"

@interface HTTPClient : NSObject

@property (nonatomic) BOOL isTopProjectOnly;
@property (strong, nonatomic) NSString *activePathForTopView;

@property (strong, nonatomic) NSString *idUser;
@property (strong, nonatomic) NSString *apnToken;

@property(strong, nonatomic) NSString *serverURL;
@property(strong, nonatomic) NSString *serverProtocol;

+ (id)sharedInstance;

-(BOOL) testInternetConnectivity;
-(BOOL) testServerConnectivity;

-(BOOL)sendHttpRequestToURL:(NSString *)url withMethod:(NSString *)method params:(NSDictionary *)params delegate:(id)delegate sendingCookie:(BOOL)sendingCookie;

-(BOOL)sendHttpRequestToURL:(NSString *)url withMethod:(NSString *)method data:(NSData *)data delegate:(id)delegate sendingCookie:(BOOL)sendingCookie;

-(NSDictionary *) handleResponseDataFromJSON:(NSData *)data;

-(BOOL) handleResponseWithStatusCode:(int)statusCode andURLPath:(NSString *)path;

-(NSData *) convertDictionaryToJSON:(NSDictionary *)dictionary;
-(NSData *) convertArrayToJSON:(NSArray *)array;
@end
