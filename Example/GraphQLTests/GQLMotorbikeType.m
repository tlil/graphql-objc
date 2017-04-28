//
//  GQLMotorbikeType.m
//  GraphQL
//
//  Created by Tommy Lillehagen on 03/04/2017.
//  Copyright © 2017 tlil87. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GQLMotorbikeType.h"

GraphQLTypeImplementation(Motorbike)

-(int) numberOfSeats
{
    return 1;
}

-(int) numberOfWheels
{
    return 2;
}

GraphQLTypeImplementationEnd
