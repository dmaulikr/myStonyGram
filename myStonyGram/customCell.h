//
//  customCell.h
//  myStonyGram
//
//  Created by Rahul Sarna on 05/07/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "Photo.h"


@interface customCell : UITableViewCell <UIActionSheetDelegate,UITableViewDelegate>{
    SLComposeViewController *mySLComposerSheet;

}
@property (retain, nonatomic) IBOutlet UIImageView *photo;
@property (retain, nonatomic) IBOutlet UILabel *cellLabel;
@property (retain, nonatomic) IBOutlet UIButton *shareButton;
@property (retain, nonatomic) IBOutlet UIButton *commentButton;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UILabel *commentCount;
@property (retain, nonatomic) IBOutlet UILabel *usernameLabel;
@property (retain, nonatomic) IBOutlet UIImageView *usernamePhoto;
@property (retain, nonatomic) IBOutlet UIView *feedContainer;
@property (retain, nonatomic) IBOutlet UIView *socialContainer;

@property (retain, nonatomic) NSManagedObjectContext *context;
@property (retain, nonatomic) Photo *myPhoto;
@end
