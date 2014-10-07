//
//  StonyGramTableViewController.h
//  myStonyGram
//
//  Created by Rahul Sarna on 05/07/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SavePhotoViewController.h"
#import "Photo.h"
#import "AssetsLibrary/ALAssetsLibrary.h"

@interface StonyGramTableViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>

@property (nonatomic, retain) NSMutableArray *pictureListData;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *photoFRC;
@property (nonatomic, retain) NSString *username;

@property (nonatomic, retain) Photo *photo;

- (void)readDataForTable;

@end