//
//  ShowCommentsViewController.h
//  myStonyGram
//
//  Created by Rahul Sarna on 09/07/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comments.h"
#import "CoreDataHelper.h"
#import "UIInputToolbar.h"
#import "Photo.h"
#import "CoreDataTableViewController.h"
#import "AMBubbleTableViewController.h"
@interface ShowCommentsViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate> {
    

}

@property (nonatomic, retain) Photo *currentPhotoComment;
@property (nonatomic, retain) Comments *currentComment;
@property (nonatomic, retain) NSMutableSet *commentListData;
@property (nonatomic, retain) NSMutableArray *pictureListData;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *username;

- (void)readDataForTable;

@end
