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
    _sidebarButton.tintColor = [UIColor whiteColor];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(rightRevealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    GlassViewController *controller = (GlassViewController *)segue.destinationViewController;
    if([segue.identifier isEqualToString:@"earthSegue"]){
        [controller setSelectedGallery:@"Earth and Sky"];
    }
    else if ([segue.identifier isEqualToString:@"energySegue"]){
        [controller setSelectedGallery:@"Energy and Innovation"];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
