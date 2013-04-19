//
//  HTTPClient.m
//  ACLTaxis
//
//  Created by Mac's Roustan on 26/04/12.
//  Copyright (c) 2012 InTech S.A. All rights reserved.
//

#import "HTTPClient.h"

#pragma mark
#pragma mark NSDictionary Additional Methods
#pragma mark

@interface NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
+(NSDictionary*)dictionaryWithContentsOfData:(NSData*)data;
-(NSData*)toJSON;
@end

@implementation NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: urlAddress] ];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+(NSDictionary*)dictionaryWithContentsOfData:(NSData*)data
{
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}


-(NSData*)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;    
}
@end





#pragma mark
#pragma mark HTTPClient Implementation
#pragma mark


@implementation HTTPClient
@synthesize idUser;
@synthesize serverURL;
@synthesize serverProtocol;
@synthesize isTopProjectOnly;
@synthesize activePathForTopView;
@synthesize apnToken;
@synthesize loadingHUD;

static HTTPClient *sharedInstance = nil;

#pragma mark - HTTP Request Connection Test Methods

-(BOOL)testInternetConnectivity {
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    
    return reach.isReachable;
}

-(BOOL)testServerConnectivity {
    Reachability *reach = [Reachability reachabilityWithHostname:serverURL];
    
    return reach.isReachable;
}

#pragma mark - HTTP Request Sender Method

-(BOOL)sendHttpRequestToURL:(NSString *)url withMethod:(NSString *)method params:(NSDictionary *)params delegate:(id)delegate sendingCookie:(BOOL)sendingCookie{    
    // init params string    
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    NSString *paramsString = [NSString stringWithFormat:@"lang=%@", language];
    
    // check if we have parameters to build params string
    if ( [params count] > 0 )
    {
        // We get all the keys provided in the params NSDictionary in a NSArray :
        NSArray *keysArray = [NSArray arrayWithArray:[params allKeys]];
        
        // We create the string corresponding to the parameters by appending as much params that there is in the NSDictionary (i.e. in keysArray)
        for(int i = 0; i < [keysArray count]; i ++){
            // for each entry, we get the key and value and create a NSString with it.
            NSString *key = [keysArray objectAtIndex:i];
            NSString *value = [params valueForKey:key];
            
            /*
            // the first parameters initiate the string at something like "username=admin"
            if ( i == 0 ) {
                paramsString = [NSString stringWithFormat:@"%@=%@", key, value];
            }
            // while the others append something like "&password=admin" at the end
            else {*/
            
            paramsString = [paramsString stringByAppendingFormat:@"&%@=%@", key, value];
            
        }   
    }

    NSLog(@"Parameters : %@", paramsString);
    
    // Setting the URL with the default hostname + method URL + params data
    
    NSMutableURLRequest *request;    
    // Set the Method
    NSString *httpMethod = @"POST";
    
    if ([[method uppercaseString] isEqualToString:@"GET"]) {
        httpMethod = @"GET";
        NSString *urlPath = [NSString stringWithFormat:serverProtocol, serverURL, url];
        NSString *completeURL = [NSString stringWithFormat:@"%@?%@", urlPath, paramsString];
        completeURL = [completeURL stringByReplacingPercentEscapesUsingEncoding:NSStringEncodingConversionAllowLossy];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:completeURL]];
    }
    else {
        paramsString = [paramsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:serverProtocol, serverURL, url]]];
        [request setHTTPBody:[paramsString dataUsingEncoding:NSStringEncodingConversionAllowLossy]]; // Encoding into sendable NSData
    }
    
    [request setHTTPMethod:httpMethod];
    
    
    HTTPCookies *httpCookies = [HTTPCookies sharedInstance];
    
    if ( sendingCookie &&
        [httpCookies existsCookieWithName:COOKIENAME] )
    {
        NSString *playSession = [NSString stringWithFormat:@"%@=%@", COOKIENAME, [httpCookies getValueForName:COOKIENAME]];
        NSDictionary *headerDict = [NSDictionary dictionaryWithObject:playSession forKey:@"Cookie"];
        
        [request setAllHTTPHeaderFields:headerDict];
    }
    
    // Creating connection and sending
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:delegate];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    if(connection){
        return YES;
    }
    else {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        return NO;
    }
}

-(BOOL)sendHttpRequestToURL:(NSString *)url withMethod:(NSString *)method data:(NSData *)data delegate:(id)delegate sendingCookie:(BOOL)sendingCookie {
    // Set the Method
    NSString *httpMethod = @"POST";
    if ([[method uppercaseString] isEqualToString:@"GET"]) {
        httpMethod = @"GET";
    }
    
    // Setting the URL with the default hostname + method URL + params data
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:serverProtocol, serverURL, url]]];
    [request setHTTPMethod:httpMethod];
    [request setHTTPBody:data]; // Encoding into sendable NSData
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    HTTPCookies *httpCookies = [HTTPCookies sharedInstance];
    
    if ( sendingCookie &&
        [httpCookies existsCookieWithName:COOKIENAME] )
    {
        NSString *playSession = [NSString stringWithFormat:@"%@=%@", COOKIENAME, [httpCookies getValueForName:COOKIENAME]];
        NSDictionary *headerDict = [NSDictionary dictionaryWithObject:playSession forKey:@"Cookie"];
        
        [request setAllHTTPHeaderFields:headerDict];
    }
    
    // Creating connection and sending
    
    NSLog(@"%@",request);
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:delegate];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    if(connection){
        return YES;
    }
    else {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        return NO; 
    }
    
}

#pragma mark - To JSON Converter
-(NSData *) convertDictionaryToJSON:(NSDictionary *)dictionary {
    return [dictionary toJSON];
    
}

-(NSData *) convertArrayToJSON:(NSArray *)array {
    NSDictionary *dictionary =[NSDictionary dictionaryWithObject:array forKey:@"preferences"];
    return [dictionary toJSON];
    
}

#pragma mark - HTTP Response Handler (From JSON converter)

-(NSDictionary *) handleResponseDataFromJSON:(NSData *)data {
    NSDictionary *dictFromData = [NSDictionary dictionaryWithContentsOfData:data];
    
    return dictFromData;
}

-(BOOL) handleResponseWithStatusCode:(int)statusCode andURLPath:(NSString *)path {
    NSLog(@"Received Response to request : \"%@\" with Status code : %i", path, statusCode);
    
    return YES;
}

#pragma mark - Loading HUD handling methods

-(void) presentLoadingHudWithTitle:(NSString *)title message:(NSString *)message image:(UIImage *)image andDelegate:(id)delegate {
    
    loadingHUD = [[MBProgressHUD alloc] initWithView:delegate];
    [delegate addSubview:loadingHUD];
    
    if (image) {
        loadingHUD.customView = [[UIImageView alloc] initWithImage:image];
    }
    
    loadingHUD.mode = MBProgressHUDModeCustomView;
    [loadingHUD setLabelText:title];
    [loadingHUD setDetailsLabelText:message];
    
    [loadingHUD show:YES];
    
    [loadingHUD hide:YES afterDelay:8];
    
    [loadingHUD addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissLoadingHud)]];
}

-(void) presentSimpleLoadingHudWithTitle:(NSString *)title andDelegate:(id)delegate
{
    loadingHUD = [[MBProgressHUD alloc] initWithView:delegate];
    [delegate addSubview:loadingHUD];
    
    loadingHUD.mode = MBProgressHUDModeIndeterminate;
    [loadingHUD setLabelText:title];
    
    [loadingHUD show:YES];
}

-(void) dismissLoadingHud {
    [loadingHUD hide:YES];
}


#pragma mark - SINGLETON STRUCTURE HANDLING


// Get the shared instance and create it if necessary.
+ (HTTPClient*)sharedInstance {
    
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
        
    return sharedInstance;
}

-(id) init {
    self = [super init];
    if (self) {
        serverURL = @"192.168.4.136:9000";
        serverProtocol = @"http://%@/%@";
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
