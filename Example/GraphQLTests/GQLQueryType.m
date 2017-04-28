//
//  GQLQuery.m
//  GraphQL
//
//  Created by Tommy Lillehagen on 03/04/2017.
//  Copyright © 2017 tlil87. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GQLQueryType.h"
#import "GQLCarType.h"
#import "GQLMotorbikeType.h"

GraphQLTypeImplementation(Query)

-(NSString*) hello
{
    return @"Hello world";
}

-(NSArray*) vehicles
{
    GQLCarType *v1 = [[GQLCarType alloc] init];
    GQLMotorbikeType *v2 = [[GQLMotorbikeType alloc] init];
    return [NSArray arrayWithObjects: v1, v2, nil];
}
    
GraphQLTypeImplementationEnd
