//
//  GraphQLEngine.m
//  Pods
//
//  Created by Tommy Lillehagen on 03/04/2017.
//  Copyright © 2017 Tommy Lillehagen. All rights reserved.
//

#import "GQLEngine.h"
#import "TimerJS.h"

@implementation GraphQLEngine

@synthesize context;

+(instancetype) engineWithSchema:(NSString*)schema
                 andErrorHandler:(void(^)(NSString* error)) errorHandler
{
    GraphQLEngine *engine = [[GraphQLEngine alloc] init];
    engine.context = [[JSContext alloc] init];
    engine.context.exceptionHandler = ^(JSContext *context, JSValue *exception)
    {
        errorHandler([exception toString]);
    };
    [TimerJS registerInto:engine.context];
    [engine initializeEngine];
    [engine buildSchema:schema];
    return engine;
}

+(NSBundle*) getResourcesBundle
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:@"Scripts" withExtension:@"bundle"];
    return [NSBundle bundleWithURL:url];
}

-(void) initializeEngine {
    // Initialize GraphQL engine
    NSBundle *bundle = [GraphQLEngine getResourcesBundle];
    NSString *scriptPath = [bundle pathForResource:@"/engine" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:scriptPath
                                                 encoding:NSUTF8StringEncoding
                                                    error:nil];
    [self.context evaluateScript:script];
}

-(void) buildSchema:(NSString*)schema {
    // Generate schema structure
    self.context[@"schema"] = schema;
    [self.context evaluateScript:@"engine.buildSchema(schema);"];
}

-(void) executeQuery:(NSString*)query
            withRoot:(NSObject*)root
         andCallback:(void(^)(NSString* error, NSString* result)) callback
{
    [self executeQuery:query
              withRoot:root
          andVariables:nil
      andOperationName:nil
           andCallback:callback];
}

-(void) executeQuery:(NSString*)query
            withRoot:(NSObject*)root
        andVariables:(NSDictionary*)variables
         andCallback:(void(^)(NSString* error, NSString* result)) callback
{
    [self executeQuery:query
              withRoot:root
          andVariables:variables
      andOperationName:nil
           andCallback:callback];
}

-(void) executeQuery:(NSString*)query
            withRoot:(NSObject*)root
        andVariables:(NSDictionary*)variables
    andOperationName:(NSString*)operationName
         andCallback:(void(^)(NSString* error, NSString* result)) callback
{
    // TODO thread-safety
    self.context[@"q"] = query;
    self.context[@"v"] = variables;
    self.context[@"o"] = operationName;
    self.context[@"r"] = root;
    self.context[@"c"] = ^(JSValue* error, JSValue *result)
    {
        if (![error isNull]) {
            callback([error toString], nil);
        } else {
            callback(nil, [result toString]);
        }
    };
    [self.context evaluateScript:@"engine.executeQuery(q, v, o, r, c);"];
}

@end
