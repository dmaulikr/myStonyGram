//
//  SignUpViewController.h
//  myStonyGram
//
//  Created by Rahul Sarna on 25/08/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Users.h"

@interface SignUpViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *username;
@property (retain, nonatomic) IBOutlet UITextField *password;

@property (retain, nonatomic) NSManagedObjectContext *context;

@end
