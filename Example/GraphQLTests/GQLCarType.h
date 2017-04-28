//
//  GQLCarType.h
//  GraphQL
//
//  Created by Tommy Lillehagen on 03/04/2017.
//  Copyright © 2017 tlil87. All rights reserved.
//

#ifndef GQLCarType_h
#define GQLCarType_h

#import <GraphQL/GQLEngine.h>

GraphQLType(Car)

-(int) numberOfSeats;
-(int) numberOfWheels;
-(int) numberOfDoors;

GraphQLTypeEnd(Car)

#endif /* GQLCarType_h */
