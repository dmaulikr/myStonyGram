//
//  Photo+Create.m
//  myStonyGram
//
//  Created by Rahul Sarna on 25/08/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import "Photo+Create.h"

@implementation Photo (Create)

+ (Photo *) photoWithDate:(NSString *)date inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photo *photo = nil;
    
    if (date) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"uniqueID"
                                                                  ascending:YES
                                                                   selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"uniqueID = %@", date];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
          // Photo No Exist
        } else {
            
            NSLog(@"Last Object");
            photo = [matches lastObject];
        }
    }
    
    return photo;
}


@end
