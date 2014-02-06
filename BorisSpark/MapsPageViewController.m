//
//  MapsPageViewController.m
//  BorisSpark
//
//  Created by Gellert on 1/30/2014.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "MapsPageViewController.h"

@interface MapsPageViewController ()

@end

@implementation MapsPageViewController

@synthesize MapsBackButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"In Maps view controller");
    MapsBackButton = (UIButton*) self.editButtonItem;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)MapsBackButtonPressed:(id)sender {
    NSLog(@"maps back button pressed");
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}
@end
