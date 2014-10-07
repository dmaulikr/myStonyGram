//
//  Users.h
//  myStonyGram
//
//  Created by Rahul Sarna on 31/07/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Users : NSManagedObject

@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *photoTaken;
@end

@interface Users (CoreDataGeneratedAccessors)

- (void)addPhotoTakenObject:(Photo *)value;
- (void)removePhotoTakenObject:(Photo *)value;
- (void)addPhotoTaken:(NSSet *)values;
- (void)removePhotoTaken:(NSSet *)values;

@end
