//
//  GraphQLEngine.h
//  Pods
//
//  Created by Tommy Lillehagen on 03/04/2017.
//  Copyright © 2017 Tommy Lillehagen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@import JavaScriptCore;

#define FileReference(bundle, file) \
    [bundle pathForResource:file ofType:@"graphql"]

#define SchemaReference(bundle, file) \
    [NSString \
        stringWithContentsOfFile:FileReference(bundle, file) \
        encoding:NSUTF8StringEncoding \
        error:nil]

#define MainBundle [NSBundle mainBundle]
#define Bundle [NSBundle bundleForClass:[self class]]

#define GraphQLType(type) \
    @protocol GQL##type##TypeExport <JSExport> \
    -(NSString*) __typename; \

#define GraphQLTypeEnd(type) \
    @end \
    @interface GQL##type##Type : NSObject <GQL##type##TypeExport> \
    @end

#define GraphQLTypeImplementation(type) \
    @implementation GQL##type##Type \
    -(NSString*) __typename \
    { \
        return @"" # type ""; \
    }

#define GraphQLTypeImplementationEnd \
    @end

@interface GraphQLEngine : NSObject

@property JSContext *context;

+(instancetype) engineWithSchema:(NSString*)schema
                 andErrorHandler:(void(^)(NSString* error)) errorHandler;

-(void) executeQuery:(NSString*)query
            withRoot:(NSObject*)root
         andCallback:(void(^)(NSString* error, NSString* result)) callback;

-(void) executeQuery:(NSString*)query
            withRoot:(NSObject*)root
        andVariables:(NSDictionary*)variables
         andCallback:(void(^)(NSString* error, NSString* result)) callback;

-(void) executeQuery:(NSString*)query
            withRoot:(NSObject*)root
        andVariables:(NSDictionary*)variables
    andOperationName:(NSString*)operationName
         andCallback:(void(^)(NSString* error, NSString* result)) callback;

@end
