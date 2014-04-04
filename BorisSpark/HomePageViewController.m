//
//  ViewController.m
//  BorisSpark
//
//  Created by Gellert on 1/29/2014.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "HomePageViewController.h"
#import "MapsPageViewController.h"
#import "Model.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    //[self.navigationController setNavigationBarHidden:NO];
    
    Model * sharedModel = [Model sharedModel];
    [sharedModel setController:self.navigationController];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ViewMapPressed:(id)sender {

}

- (BOOL)prefersStatusBarHidden {
    return YES;
}



@end
