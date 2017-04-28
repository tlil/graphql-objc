//
//  GQLCarType.m
//  GraphQL
//
//  Created by Tommy Lillehagen on 03/04/2017.
//  Copyright © 2017 tlil87. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GQLCarType.h"

GraphQLTypeImplementation(Car)

-(int) numberOfSeats
{
    return 5;
}

-(int) numberOfWheels
{
    return 4;
}

-(int) numberOfDoors
{
    return 4;
}
    
GraphQLTypeImplementationEnd
