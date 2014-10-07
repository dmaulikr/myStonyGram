//
//  Photo.h
//  myStonyGram
//
//  Created by Rahul Sarna on 31/07/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comments, Users;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * myLabel;
@property (nonatomic, retain) NSDate * photoDate;
@property (nonatomic, retain) NSString * uniqueID;
@property (nonatomic, retain) NSSet *photoComments;
@property (nonatomic, retain) Users *photographer;
@end

@interface Photo (CoreDataGeneratedAccessors)

- (void)addPhotoCommentsObject:(Comments *)value;
- (void)removePhotoCommentsObject:(Comments *)value;
- (void)addPhotoComments:(NSSet *)values;
- (void)removePhotoComments:(NSSet *)values;

@end
