//
//  GraphQLTests.m
//  GraphQLTests
//
//  Created by Tommy Lillehagen on 03/04/2017.
//  Copyright © 2017 tlil87. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <GraphQL/GQLEngine.h>
#import "GQLQueryType.h"

@interface GraphQLTests : XCTestCase

@end

@implementation GraphQLTests

static GraphQLEngine* engine;

- (void)setUp {
    [super setUp];
    engine = [GraphQLEngine engineWithSchema:SchemaReference(Bundle, @"/Schema")
                             andErrorHandler:^(NSString *error) {
                                 NSLog(@"Error: %@", error);
                             }];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testValidQuery {
    XCTestExpectation *successExpectation =
    [self expectationWithDescription:@"Successful query"];
    
    GQLQueryType *root = [[GQLQueryType alloc] init];
    
    [engine executeQuery:@"{ hello }"
                withRoot:root
                andCallback:^(NSString* error, NSString* result)
    {
        if ([result isEqualToString:@"{\"data\":{\"hello\":\"Hello world\"}}"]) {
            [successExpectation fulfill];
        } else {
            XCTFail(@"Invalid response from query");
        }
    }];
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            XCTFail(@"Query timed out");
        }
    }];
}

- (void)testInvalidQuery {
    XCTestExpectation *successExpectation =
    [self expectationWithDescription:@"Successful query"];
    
    GQLQueryType *root = [[GQLQueryType alloc] init];
    
    [engine executeQuery:@"{ foo }"
                withRoot:root
             andCallback:^(NSString* error, NSString* result)
     {
         if ([result isEqualToString:@"{\"errors\":[{\"message\":\"Cannot query field \\\"foo\\\" on type \\\"Query\\\".\",\"locations\":[{\"line\":1,\"column\":3}]}]}"]) {
             [successExpectation fulfill];
         } else {
             XCTFail(@"Invalid response from query");
         }
     }];
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            XCTFail(@"Query timed out");
        }
    }];
}
    
- (void)testPolymorphicQuery {
    XCTestExpectation *successExpectation =
    [self expectationWithDescription:@"Successful query"];
    
    GQLQueryType *root = [[GQLQueryType alloc] init];
    
    [engine executeQuery:@"{ vehicles { __typename numberOfWheels ... on Car { numberOfDoors } } }"
                withRoot:root
             andCallback:^(NSString* error, NSString* result)
     {
         if ([result isEqualToString:@"{\"data\":{\"vehicles\":[{\"__typename\":\"Car\",\"numberOfWheels\":4,\"numberOfDoors\":4},{\"__typename\":\"Motorbike\",\"numberOfWheels\":2}]}}"]) {
             [successExpectation fulfill];
         } else {
             NSLog(@"Error: %@", result);
             XCTFail(@"Invalid response from query");
         }
     }];
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            XCTFail(@"Query timed out");
        }
    }];
}


@end
