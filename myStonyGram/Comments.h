//
//  Comments.h
//  myStonyGram
//
//  Created by Rahul Sarna on 31/07/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Comments : NSManagedObject

@property (nonatomic, retain) NSDate * commentDate;
@property (nonatomic, retain) NSString * myComment;
@property (nonatomic, retain) Photo *photoRelated;

@end
