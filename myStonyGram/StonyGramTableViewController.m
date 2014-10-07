//
//  StonyGramTableViewController.m
//  myStonyGram
//
//  Created by Rahul Sarna on 05/07/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import "StonyGramTableViewController.h"
#import "customCell.h"
#import "SavePhotoViewController.h"
#import "CoreDataHelper.h"
#import "Photo.h"
#import "ShowCommentsViewController.h"
#import "StonyGramAppDelegate.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

//typedef void (^ALAssetsLibraryAssetForURLResultBlock)(ALAsset *asset);
//typedef void (^ALAssetsLibraryAccessFailureBlock)(NSError *error);

@interface StonyGramTableViewController () <UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>{
}

@property (nonatomic,retain) NSString *date;

@end

@implementation StonyGramTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.title = _username; //@"Feed";
    
    NSString* boldFontName = @"GillSans-Bold";
    
    [self styleNavigationBarWithFontName:boldFontName];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:242.0/255 green:235.0/255 blue:241.0/255 alpha:1.0];
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.pictureListData = [[NSMutableArray alloc] init];
        
}

//  When the view reappears, read new data for table

- (void)viewWillAppear:(BOOL)animated
{    
    //  Repopulate the array with new table data
    [self readDataForTable];
    
    //Count
    NSLog(@"Picture list data count %lu",(unsigned long)_pictureListData.count);
}

//  Grab data for table - this will be used whenever the list appears or reappears after an add/edit

- (void)readDataForTable
{
    //  Grab the data
    
    _pictureListData = [CoreDataHelper getObjectsForEntity:@"Photo" withSortKey:@"photoDate" andSortAscending:NO andContext:_managedObjectContext];
    

    //  Force table refresh
    [self.tableView reloadData];
}


//Prepare for Segue Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        
   if([[segue identifier] isEqualToString:@"AddPicture"]){
        SavePhotoViewController *pld = (SavePhotoViewController *)segue.destinationViewController;
        
        //  Pass the managed object context to the destination view controller
        pld.managedObjectContext = self.managedObjectContext;
        pld.username = _username;

    }
    else if([[segue identifier] isEqualToString:@"CommentSegue"]){
        ShowCommentsViewController *pld = (ShowCommentsViewController *)segue.destinationViewController;
        
        //  Pass the managed object context to the destination view controller
        pld.managedObjectContext = self.managedObjectContext;
                                
        NSLog(@"uniq ->> %@", _date);
        
        pld.date = _date;
    }
    
}
 

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_pictureListData count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    customCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
     if (!cell) {
        cell = (customCell *)[[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);
//    dispatch_async(queue, ^{
    //Fetching Data
        _pictureListData = [CoreDataHelper getObjectsForEntity:@"Photo" withSortKey:@"photoDate" andSortAscending:NO andContext:_managedObjectContext];
    
        Photo *currentCell = [_pictureListData objectAtIndex:indexPath.row];
    
            //Photo Label
            cell.cellLabel.text = currentCell.myLabel;
    
            //For Date Format
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
            [dateFormatter setDateFormat: @"EEE, MMMM dd yyyy hh:mm:ss a"];
    
            cell.dateLabel.text = [dateFormatter stringFromDate:currentCell.photoDate];
    
            NSLog(@"uniq -- %@",currentCell.uniqueID);
    
            _date = [[NSString alloc] initWithString: currentCell.uniqueID];
    
            [dateFormatter release];
    
            cell.photo.contentMode = UIViewContentModeScaleAspectFit;
    
            cell.usernamePhoto.image = [UIImage imageNamed:@"images-1.jpeg"];
    
            cell.usernameLabel.text = currentCell.photographer.username;
    
    
                NSLog(@"cell->-> %@",currentCell.location);
            
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
        ALAssetsLibraryAssetForURLResultBlock resultsBlock = ^(ALAsset *asset){
        
        ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
        
            CGImageRef cgImage = [assetRepresentation fullScreenImage]; //CGImageWithOptions:nil];
        
            cell.photo.image = [UIImage imageWithCGImage:cgImage];
        };
    
        ALAssetsLibraryAccessFailureBlock failure = ^(NSError *error)
        {
            NSLog(@"Cannot get Image: %@",error.localizedFailureReason);
        };
    
    
            [library assetForURL:[NSURL URLWithString:currentCell.location] resultBlock:resultsBlock failureBlock:failure];
    
        [library release];
    
    self.photo = currentCell;
        
//        dispatch_sync(dispatch_get_main_queue(), ^{
    
    [cell.commentButton setTitle:[NSString stringWithFormat:@"%d",currentCell.photoComments.count] forState:UIControlStateNormal];
    
    cell.commentButton.userInteractionEnabled = YES;
    
    cell.context = self.managedObjectContext;
    
//            });
//    });
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _pictureListData = [CoreDataHelper getObjectsForEntity:@"Photo" withSortKey:@"photoDate" andSortAscending:NO andContext:_managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //  Get a reference to the table item in our data array
        Photo *itemToDelete = [self.pictureListData objectAtIndex:indexPath.row];
        
        //  Delete the item in Core Data
        [self.managedObjectContext deleteObject:itemToDelete];
        
        //  Remove the item from our array
        [_pictureListData removeObjectAtIndex:indexPath.row];
        
        //  Commit the deletion in core data
        NSError *error;
        if (![self.managedObjectContext save:&error])
            NSLog(@"Failed to delete picture item with error: %@", [error domain]);
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (IBAction)logoutButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];

}

-(void)styleNavigationBarWithFontName:(NSString*)navigationTitleFont{
    
    
    CGSize size = CGSizeMake(320, 44);
    UIColor* color = [UIColor colorWithRed:50.0/255 green:102.0/255 blue:147.0/255 alpha:1.0f];
    
    UIGraphicsBeginImageContext(size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGRect fillRect = CGRectMake(0,0,size.width,size.height);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextFillRect(currentContext, fillRect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UINavigationBar* navAppearance = [UINavigationBar appearance];
    
    [navAppearance setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    [navAppearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIColor whiteColor], UITextAttributeTextColor,
                                           [UIFont fontWithName:navigationTitleFont size:18.0f], UITextAttributeFont, [NSValue valueWithCGSize:CGSizeMake(0.0, 0.0)], UITextAttributeTextShadowOffset,
                                           nil]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 
@end
