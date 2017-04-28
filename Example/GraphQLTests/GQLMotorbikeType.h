//
//  GQLMotorbikeType.h
//  GraphQL
//
//  Created by Tommy Lillehagen on 03/04/2017.
//  Copyright © 2017 tlil87. All rights reserved.
//

#ifndef GQLMotorbikeType_h
#define GQLMotorbikeType_h

#import <GraphQL/GQLEngine.h>

GraphQLType(Motorbike)

-(int) numberOfSeats;
-(int) numberOfWheels;

GraphQLTypeEnd(Motorbike)

#endif /* GQLMotorbikeType_h */
