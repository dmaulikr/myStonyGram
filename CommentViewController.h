//
//  CommentViewController.h
//  myStonyGram
//
//  Created by Rahul Sarna on 09/07/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIInputToolbar.h"
#import "CoreDataHelper.h"
#import "Comments.h"



@interface CommentViewController : UIViewController<UIInputToolbarDelegate> {
    
@private
    BOOL keyboardIsVisible;
}

@property (nonatomic, retain) UIInputToolbar *inputToolbar;

@property (nonatomic, retain) Comments *currentComment;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
