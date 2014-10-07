//
//  customCell.m
//  myStonyGram
//
//  Created by Rahul Sarna on 05/07/13.
//  Copyright (c) 2013 Rahul Sarna. All rights reserved.
//

#import "customCell.h"
#import <Social/Social.h>
#import "ShowCommentsViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation customCell


- (IBAction)shareButton:(id)sender {
   
    NSArray *activityItems;
    
    if (_photo.image != nil) {
        activityItems = @[_cellLabel.text, _photo.image];
    } else {
        activityItems = @[_cellLabel.text];
    }
    
    UIActivityViewController *activityController = [[[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil]autorelease];
    
            [((UIViewController *)[self.superview nextResponder]) presentViewController:activityController animated:YES completion:Nil];
    
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)awakeFromNib{
    
    
    self.feedContainer.backgroundColor = [UIColor whiteColor];
    
    
    UIColor* mainColor = [UIColor colorWithRed:100.0/255 green:35.0/255 blue:87.0/255 alpha:1.0f];
    UIColor* countColor = [UIColor colorWithRed:116.0/255 green:99.0/255 blue:113.0/255 alpha:1.0f];
    UIColor* neutralColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldFontName = @"Avenir-Black";
    
    self.usernameLabel.textColor =  mainColor;
    self.usernameLabel.font =  [UIFont fontWithName:boldFontName size:14.0f];
    
    self.cellLabel.textColor =  neutralColor;
    self.cellLabel.font =  [UIFont fontWithName:fontName size:20.0f];
    
    self.dateLabel.textColor = neutralColor;
    self.dateLabel.font =  [UIFont fontWithName:fontName size:10.0f];
    
    self.commentCount.textColor = countColor;
    self.commentCount.font =  [UIFont fontWithName:boldFontName size:11.0f];
    
    self.feedContainer.layer.cornerRadius = 3.0f;
    self.feedContainer.clipsToBounds = YES;
    
    self.photo.contentMode = UIViewContentModeScaleAspectFill;
    self.photo.clipsToBounds = YES;
    
    self.socialContainer.backgroundColor = [UIColor colorWithRed:220.0/255 green:214.0/255 blue:219.0/255 alpha:1.0f];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  
}

@end
