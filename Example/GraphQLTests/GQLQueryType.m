//
//  GQLQuery.m
//  GraphQL
//
//  Created by Tommy Lillehagen on 03/04/2017.
//  Copyright © 2017 tlil87. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GQLQueryType.h"
#import "GQLCaptureCapabilityType.h"
#import "GQLTaggingCapabilityType.h"

GraphQLTypeImplementation(Query)

-(NSString*) hello
{
    return @"Hello world";
}

-(NSArray*) capabilities
{
    GQLCaptureCapabilityType *cap1 = [[GQLCaptureCapabilityType alloc] init];
    GQLTaggingCapabilityType *cap2 = [[GQLTaggingCapabilityType alloc] init];
    return [NSArray arrayWithObjects: cap1, cap2, nil];
}
    
GraphQLTypeImplementationEnd
