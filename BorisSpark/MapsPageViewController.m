//
//  MapsPageViewController.m
//  BorisSpark
//
//  Created by Gellert on 1/30/2014.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "MapsPageViewController.h"
#import "GlassViewController.h"
#import "ExhibitTableViewController.h"
#import "SWRevealViewController.h"

@interface MapsPageViewController ()

@end

@implementation MapsPageViewController

@synthesize MapsBackButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
	// Do any additional setup after loading the view, typically from a nib.
    // Change button color

    


    
}

- (IBAction)MapsBackButtonPressed:(id)sender {
    //[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    [self.navigationController popToViewController:[self.navigationController topViewController] animated:YES];
}

- (IBAction)EarthPressed:(id)sender {
    ExhibitTableViewController *tView = [[ExhibitTableViewController alloc] init];
    tView.galleryName = @"Earth and Sky";
    [self.navigationController pushViewController:tView animated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
