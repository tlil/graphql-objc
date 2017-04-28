//
//  GQLQuery.h
//  GraphQL
//
//  Created by Tommy Lillehagen on 03/04/2017.
//  Copyright © 2017 tlil87. All rights reserved.
//

#ifndef GQLQuery_h
#define GQLQuery_h

#import <GraphQL/GQLEngine.h>

GraphQLType(Query)

-(NSString*) hello;

-(NSArray*) vehicles;

GraphQLTypeEnd(Query)

#endif /* GQLQuery_h */
