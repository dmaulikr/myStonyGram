//
//  LoginViewController.h
//  myStonyGram
//
//  Created by Rahul Sarna on 08/07/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) IBOutlet UIButton *loginButton;

@property (nonatomic, retain) IBOutlet UILabel * titleLabel;

@property (nonatomic, retain) IBOutlet UIImageView * headerImageView;

@property (nonatomic, retain) IBOutlet UIView * infoView;

@property (nonatomic, retain) IBOutlet UILabel * infoLabel;

@property (nonatomic, retain) IBOutlet UIView * overlayView;


@end
