//
//  StonyGramViewController.m
//  myStonyGram
//
//  Created by Rahul Sarna on 04/07/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import "StonyGramViewController.h"
#import "CommentGramViewController.h"
//#import "StonyGramCell.h"

@interface StonyGramViewController () <UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UIBarButtonItem *takePhoto;
//@property (nonatomic) StonyGramCell *myCell;
@property (retain, nonatomic) IBOutlet UITableView *myPictureTable;

@end

@implementation StonyGramViewController

@synthesize takePhoto,myPictureTable;
/*
 -(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CommentGramViewController *cdvc = (CommentGramViewController *) segue.destinationViewController;
}
 

-(StonyGramCell *)myCell
{
    if(!_myCell)
        _myCell = [[StonyGramCell alloc] init];
    
    return _myCell;
    
    [_myCell autorelease];
}
*/


- (IBAction)takePhoto:(UIBarButtonItem *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
   
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:nil
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Take Photo", @"Choose Existing", nil];
        actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle: @"Cancel"];
        
        [actionSheet showInView:self.view];
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
[picker release];

}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    if (buttonIndex == 0) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if (buttonIndex == 1) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else
        return;
    
    [self presentViewController:picker animated:YES completion:NULL];
    [actionSheet release];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

	//UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    //TABLE LOAD
    self.myPictureTable.dataSource = self;
    self.myPictureTable.delegate = self;
    
    TitleLabel = [[NSArray alloc] initWithObjects:@"My",@"Name",@"is",@"AutoKrat", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [takePhoto release];
    [myPictureTable release];
    [super dealloc];
}
@end
