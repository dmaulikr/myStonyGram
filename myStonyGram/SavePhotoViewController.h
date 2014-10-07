//
//  SavePhotoViewController.h
//  myStonyGram
//
//  Created by Rahul Sarna on 06/07/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobileCoreServices/MobileCoreServices.h"
#import "QuartzCore/QuartzCore.h"
#import "StonyGramAppDelegate.h"
#import "Users+Create.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import "Photo.h"
#import "Users.h"

@interface SavePhotoViewController : UIViewController <UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate,NSFetchedResultsControllerDelegate>{
}


@property (nonatomic, retain) Photo *currentPicture;
@property (nonatomic, retain) Users *currentUser;
@property (nonatomic, retain) NSString *username;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (id) initWithCommentDetails:(Photo *) details ;

@end
