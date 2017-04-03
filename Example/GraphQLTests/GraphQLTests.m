//
//  GraphQLTests.m
//  GraphQLTests
//
//  Created by Tommy Lillehagen on 03/04/2017.
//  Copyright © 2017 tlil87. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <GraphQL/GQLEngine.h>

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

- (void)testExample {
    XCTestExpectation *successExpectation =
    [self expectationWithDescription:@"Successful query"];
    [engine executeQuery:@"{ hello }"
                withRoot:nil
                andCallback:^(NSString* error, NSString* result)
    {
        [successExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            XCTFail("Query timed out");
        }
    }];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
