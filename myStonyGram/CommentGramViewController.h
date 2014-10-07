//
//  CommentGramViewController.h
//  myStonyGram
//
//  Created by Rahul Sarna on 04/07/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIInputToolbar.h"

@interface CommentGramViewController : UIViewController <UIInputToolbarDelegate> {
    
@private
    BOOL keyboardIsVisible;
}

@property (nonatomic, retain) UIInputToolbar *inputToolbar;

@property (retain, nonatomic) IBOutlet UITableView *commentTable;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@end
