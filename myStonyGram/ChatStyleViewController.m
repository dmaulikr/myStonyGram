//
//  ChatStyleViewController.m
//  myStonyGram
//
//  Created by Rahul Sarna on 09/07/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import "ChatStyleViewController.h"

@interface ChatStyleViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation ChatStyleViewController

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        CGRect frame = self.view.bounds;
        frame.size.height = frame.size.height - 44;
        _tableView.frame = frame;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(UIToolbar *)toolbar
{
    if (!_toolbar) {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,self.tableView.frame.size.height,self.view.frame.size.width, 44)];
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0,0,_toolbar.frame.size.width,-20)];
        self.textField.delegate = self;
        UIBarButtonItem *textFieldItem = [[UIBarButtonItem alloc] initWithCustomView:self.textField];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                       target:nil
                                                                                       action:nil];
        // You'll need to add a button to send you text
        _toolbar.items = [NSArray arrayWithObjects:flexibleSpace, textFieldItem, flexibleSpace, nil];
    }
    return _toolbar;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.toolbar];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideOrShow:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideOrShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
}


- (void)keyboardWillHideOrShow:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardFrameForToolbar = [self.toolbar.superview convertRect:keyboardFrame fromView:nil];
    CGRect keyboardFrameForTableView = [self.tableView.superview convertRect:keyboardFrame fromView:nil];
    
    CGRect newToolbarFrame = self.toolbar.frame;
    newToolbarFrame.origin.y = keyboardFrameForToolbar.origin.y - newToolbarFrame.size.height;
    
    CGRect newTableViewFrame = self.tableView.frame;
    newTableViewFrame.size.height = keyboardFrameForTableView.origin.y - newToolbarFrame.size.height;
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | curve
                     animations:^{self.toolbar.frame = newToolbarFrame;
                         self.tableView.frame =newTableViewFrame;}
                     completion:nil];  
}

@end