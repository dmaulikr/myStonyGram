//
//  SavePhotoViewController.m
//  myStonyGram
//
//  Created by Rahul Sarna on 06/07/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import "SavePhotoViewController.h"



@interface SavePhotoViewController (){
    
    NSString *photoURL;
    BOOL defaultPhoto;
}


@property (retain, nonatomic) IBOutlet UIImageView *myPhoto;
@property (retain, nonatomic) IBOutlet UITextField *photoLabel;
@property (retain, nonatomic) IBOutlet UIButton *postButton;
@property (retain, nonatomic) UIImagePickerController *imagePicker;

- (IBAction)saveButton:(id)sender;

@end

@implementation SavePhotoViewController

- (id) initWithCommentDetails:(Photo *) details { // andManage:(NSManagedObjectContext *) context {
    
    if (self = [super init]) {
        
        _currentPicture = details;
        self.managedObjectContext = _currentPicture.managedObjectContext;
    }
    
    return self;
    
}

- (void) viewDidAppear:(BOOL)paramAnimated{ [super viewDidAppear:paramAnimated];
    [self.photoLabel becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // If we are editing an existing picture, then put the details from Core Data into the text fields for displaying
    if (_currentPicture)
    {
        [_photoLabel setText:[_currentPicture myLabel]];
        
        if ([_currentPicture location])
            [_myPhoto setImage:[UIImage imageWithContentsOfFile:[_currentPicture location]]];
        
        // [_myPhoto setImage:[UIImage imageWithData:[_currentPicture location]]];
    }
    else{
        self.myPhoto.image = [UIImage imageNamed:@"images.jpeg"];
        defaultPhoto = YES;
    }
    
    //photoLabel formatting UiTextField 
    NSString* fontName = @"Avenir-Book";
    
    self.photoLabel.backgroundColor = [UIColor whiteColor];
    self.photoLabel.placeholder = @"Write Something...";
    self.photoLabel.font = [UIFont fontWithName:fontName size:20.0f];
    self.photoLabel.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.7].CGColor;
    self.photoLabel.layer.borderWidth = 1.0f;
    
//    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 20)];
//    self.photoLabel.leftViewMode = UITextFieldViewModeAlways;
//    self.photoLabel.leftView = leftView;
//    
//    self.postButton.layer.cornerRadius = 3.0F;
//        
//    [leftView release];
    
}

// Take Photo From Camera or Choose Existing... (Used UIACtionSheet for implementation)

- (IBAction)takePhoto:(UIToolbar *)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Image from..." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Image Gallary", nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	actionSheet.alpha=0.90;
	actionSheet.tag = 1;
	[actionSheet showInView:self.view];
	[actionSheet release];
}

- (IBAction)clickImageForPhoto:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Image from..." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Image Gallary", nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	actionSheet.alpha=0.90;
	actionSheet.tag = 1;
	[actionSheet showInView:self.view];
	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (actionSheet.tag)
	{
		case 1:
			switch (buttonIndex)
		{
			case 0:
			{
                
// Took this code from an online source
#if TARGET_IPHONE_SIMULATOR
				
				UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Camera not available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				[alert release];
				
#elif TARGET_OS_IPHONE
				
				UIImagePickerController *picker = [[UIImagePickerController alloc] init];
				picker.sourceType = UIImagePickerControllerSourceTypeCamera;
				picker.delegate = self;
                picker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
                picker.allowsEditing = NO;

				[self presentViewController:picker animated:YES completion:NULL];
                
				[picker release];
				
#endif
			}
				break;
			case 1:
			{
				UIImagePickerController *picker = [[UIImagePickerController alloc] init];
				picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
				picker.delegate = self;
				[self presentViewController:picker animated:YES completion:NULL];
                
				[picker release];
			}
				break;
		}
			break;
			
		default:
			break;
	}
}

- (void) imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError
                       contextInfo:(void *)paramContextInfo{
    if (paramError == nil){
        NSLog(@"Image was saved successfully.");
    } else {
        NSLog(@"An error happened while saving the image.");
        
        NSLog(@"Error = %@", paramError); }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        _myPhoto.image = image;
        
        defaultPhoto = NO;
    }
    
    
   
    // TO SAVE PHOTO CLICKED FROM CAMERA IN CAMERA ROLL 
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        
       ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        
        [library writeImageToSavedPhotosAlbum:((UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage]).CGImage
                                     metadata:[info objectForKey:UIImagePickerControllerMediaMetadata]
                              completionBlock:^(NSURL *assetURL, NSError *error) {
                             
                                  NSLog(@"assetURL %@", assetURL);
                                  
                                  photoURL = [[NSString alloc] initWithString: [assetURL absoluteString]];
                                  
                                  [photoURL retain];
                                  
                          }];

        
        [library release];
              
}
    else if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        
    //photoURL = [[info objectForKey:UIImagePickerControllerReferenceURL] absoluteURL];

        photoURL = [[NSString alloc] initWithString: [info[UIImagePickerControllerReferenceURL] absoluteString]];

        [photoURL retain];
        
        NSLog(@"elseif->%@",photoURL);
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

// TO dismiss the keyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

// Save the image and the label entered

- (IBAction)saveButton:(id)sender {
    
    //Add New Object to Core Data
    if (!_currentPicture)
        self.currentPicture = (Photo *)[NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:_managedObjectContext];
    
    // For both new and existing pictures, fill in the details from the form
    [self.currentPicture setMyLabel:[_photoLabel text]];
    
    //set user
    Users *user = [Users userWithName:_username inManagedObjectContext:_managedObjectContext];
    
    NSLog(@"username: %@",user.username);
    
    [self.currentPicture setPhotographer:user];
    
    
    //Date
    
    NSDate *date = [NSDate date];
    
    [self.currentPicture setPhotoDate:date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"EEE, MMMM dd yyyy hh:mm:ss a"];
    
    self.currentPicture.uniqueID = [dateFormatter stringFromDate:date];
    
    NSLog(@"uniq save-- %@",self.currentPicture.uniqueID);

    
    [dateFormatter release];
    
    BOOL emptyLabel = YES;
    BOOL emptyPhoto = YES;
    
    if(![_photoLabel.text isEqualToString:@""]){
        emptyLabel = NO;
    }
    
    if(defaultPhoto == NO && ![_photoLabel.text isEqualToString:@""]){
        
        [self.currentPicture setLocation:photoURL];
        
        NSLog(@"log->%@",self.currentPicture.location);
        
        emptyPhoto = NO;
        
    }
    
    if(emptyLabel==NO&&emptyPhoto==NO){
        //  Automatically pop to previous view now we're done adding
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"No Photo/Label Error"
                                                              message:@"Put Image or Photo Label"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        [myAlertView release];
    }
    
    NSError *error = nil;
    
    if (![_managedObjectContext save:&error])
        NSLog(@"Failed to add new picture with error: %@", [error domain]);
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}
/*

// Raise the UITextField to not behind the keyboard
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationBeginsFromCurrentState:YES];
    
    self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 150.0), self.view.frame.size.width, self.view.frame.size.height);
    
   // _photoLabel.frame = CGRectMake(_photoLabel.frame.origin.x, (_photoLabel.frame.origin.y - 150.0), _photoLabel.frame.size.width, _photoLabel.frame.size.height);
	[UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationBeginsFromCurrentState:YES];
    
    self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y + 150.0), self.view.frame.size.width, self.view.frame.size.height);
    
    // _photoLabel.frame = CGRectMake(_photoLabel.frame.origin.x, (_photoLabel.frame.origin.y + 150.0), _photoLabel.frame.size.width, _photoLabel.frame.size.height);
	[UIView commitAnimations];
}

*/

// touch anywhere to dismiss keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[_photoLabel resignFirstResponder];
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [_myPhoto release];
    [_photoLabel release];
    [_postButton release];
    [super dealloc];
}

@end
