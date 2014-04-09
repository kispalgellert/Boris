//
//  HomeViewController.h
//  BorisSpark
//
//  Created by Gellert on 2014-04-08.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
- (IBAction)viewGalleriesForExhibit:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *galleryView;
@property (weak, nonatomic) IBOutlet UILabel *galleryLabel;
@property (weak, nonatomic) IBOutlet UIView *container1;

@end
