//
//  Users+Create.m
//  myStonyGram
//
//  Created by Rahul Sarna on 25/08/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import "Users+Create.h"

@implementation Users (Create)

+ (Users *)userWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context
{
    Users *user = nil;
    
    if (name.length) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Users"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"username"
                                                                  ascending:YES
                                                                   selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"username = %@", name];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            user = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:context];
            user.username = name;
        } else {
            
            NSLog(@"Last Object");
            user = [matches lastObject];
        }
    }
    
    return user;
}

+ (Users *)userWithName:(NSString *)name andPassword: (NSString *)password inManagedObjectContext:(NSManagedObjectContext *)context
{
    Users *user = nil;
    
    if (name.length) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Users"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"username"
                                                                  ascending:YES
                                                                   selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"username = %@", name];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            
            NSLog(@"Username already taken");
            
        } else if (![matches count]) {
            user = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:context];
            user.username = name;
            user.username = password;
            
            NSLog(@"New User Created");
        } else {
            
            NSLog(@"Last Object");
            user = [matches lastObject];
        }
    }
    
    return user;
}

@end
