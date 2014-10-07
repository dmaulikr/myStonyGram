//
//  Photo+Create.h
//  myStonyGram
//
//  Created by Rahul Sarna on 25/08/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import "Photo.h"

@interface Photo (Create)

+ (Photo *) photoWithDate:(NSString *)date inManagedObjectContext:(NSManagedObjectContext *)context;

@end
