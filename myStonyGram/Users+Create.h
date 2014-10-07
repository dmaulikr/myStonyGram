//
//  Users+Create.h
//  myStonyGram
//
//  Created by Rahul Sarna on 25/08/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import "Users.h"

@interface Users (Create)

+ (Users *)userWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;

+ (Users *)userWithName:(NSString *)name andPassword: (NSString *)password inManagedObjectContext:(NSManagedObjectContext *)context;

@end
