//
//  MapsPageViewController.m
//  BorisSpark
//
//  Created by Gellert on 1/30/2014.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "MapsPageViewController.h"
#import "ViewController.h"

@interface MapsPageViewController ()

@end

@implementation MapsPageViewController

@synthesize MapsBackButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)MapsBackButtonPressed:(id)sender {
    //[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    [self.navigationController popToViewController:[self.navigationController topViewController] animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ViewController *controller = (ViewController *)segue.destinationViewController;
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
