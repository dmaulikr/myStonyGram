//
//  SignUpViewController.m
//  myStonyGram
//
//  Created by Rahul Sarna on 25/08/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import "SignUpViewController.h"
#import "Users+Create.h"
#import "CoreDataHelper.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)signUp:(id)sender {
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(username == %@ && password == %@)", [_username text], [_password text]];
    
    
    if ([CoreDataHelper countForEntity:@"Users" withPredicate:pred andContext:_context] >= 1){
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"User Already Exist"
                                                              message:@"Try New Username"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        [myAlertView release];

    }
    else{
    Users *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:_context];
    
    newUser.username = _username.text;
    newUser.password = _password.text;
    
    NSError *error;
    if (![self.context save:&error])
        NSLog(@"Failed to add default user with error: %@", [error domain]);



        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (IBAction)goBack:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_username release];
    [_password release];
    [super dealloc];
}
@end
