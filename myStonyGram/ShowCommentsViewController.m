//
//  ShowCommentsViewController.m
//  myStonyGram
//
//  Created by Rahul Sarna on 09/07/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import "ShowCommentsViewController.h"
#import "Photo+Create.h"
#import "Users.h"

@interface ShowCommentsViewController ()

@end

@implementation ShowCommentsViewController


- (void)readDataForTable
{
    //  Grab the data
    
        
//    NSSet *comments = self.currentPhotoComment.photoComments;
//    
//    for (Comments *comment in comments){
//        [_commentListData addObject:comment];
//        NSLog(@"Comments = %d",_commentListData.count);
//    }
//    
//    _pictureListData = [NSMutableArray arrayWithArray:[self.currentPhotoComment.photoComments allObjects]];
//    
//    [_pictureListData retain];
    
    //  Force table refresh
//    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [super loadView];
        
//    _commentListData = [[[NSMutableSet alloc] init]autorelease];
//    
//    [_commentListData retain];
//        
//    _currentPhotoComment = [Photo photoWithDate:_date inManagedObjectContext:_managedObjectContext];
//    
//    if(_currentPhotoComment == nil)
//        NSLog(@"Nil Error");
    
//    [_currentPhotoComment retain];

//    [self readDataForTable];
    
    // setting up add button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTag)];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

   // [self readDataForTable];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	    
    //  Repopulate the array with new table data
    _currentPhotoComment.photoComments = _commentListData;
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Core data error %@, %@", error, [error userInfo]);
        abort();
    }
}

 
#pragma mark - Actions

- (void) addTag {
    
    UIAlertView *newTagAlert = [[UIAlertView alloc] initWithTitle:@"New tag" message:@"Insert new tag name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    
    newTagAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [newTagAlert show];
    
}


#pragma mark - Alert view delegate


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        NSLog(@"cancel");
        
    } else {
        
        
        NSString *tagName = [[alertView textFieldAtIndex:0] text];
        
        Comments *tag = [NSEntityDescription insertNewObjectForEntityForName:@"Comments"
                                                      inManagedObjectContext:self.managedObjectContext];
        tag.myComment = tagName;
        tag.commentDate = [NSDate date];
        
        if(!_currentPhotoComment)
            NSLog(@"Nil Error");
            
            tag.photoRelated = _currentPhotoComment;

        
        NSError *error = nil;
        if (![tag.managedObjectContext save:&error]) {
            NSLog(@"Core data error %@, %@", error, [error userInfo]);
            abort();
        }
        
        [_commentListData addObject:tag];
        
        NSSet *mySet = _commentListData;
        
        [_currentPhotoComment setPhotoComments: mySet];
        
        NSLog(@"Core Data COmment List-> %d",_currentPhotoComment.photoComments.count);
        
        [self readDataForTable];
        //[self.tableView reloadData];
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"comment list = %d",_commentListData.count);
    return _commentListData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:CellIdentifier]autorelease];
    }
    
    
    // Configure the cell...
        
    _pictureListData = [NSMutableArray arrayWithArray:[_commentListData allObjects]];
    
    NSLog(@"Comment Count %d", _pictureListData.count);
    
    
    Comments *comment = [_pictureListData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = comment.myComment;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"EEE, MMMM dd yyyy hh:mm:ss a"];
    
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"By %@ at %@",_currentPhotoComment.photographer.username,[dateFormatter stringFromDate:comment.commentDate]];
    
    [dateFormatter release];
    
    cell.userInteractionEnabled = NO;

    return cell;
}

-(void) dealloc{
    [super dealloc];

}

 

@end
