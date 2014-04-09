//
//  HomeViewController.m
//  BorisSpark
//
//  Created by Gellert on 2014-04-08.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "HomeViewController.h"
#import "ExhibitTableViewController.h"
#import "Model.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    Model * sharedModel = [Model sharedModel];
    [sharedModel setController:self.navigationController];
    [_galleryLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
	// Do any additional setup after loading the view.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    NSString * segueName = segue.identifier;
//    if ([segueName isEqualToString: @"tableChange"]) {
//        [segue.destinationViewController setGalleryName:@"Earth and Sky"];
        // do something with the AlertView's subviews here...
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewGalleriesForExhibit:(id)sender {
    
    ExhibitTableViewController *tView = [[ExhibitTableViewController alloc] init];
    tView.galleryName = @"Earth and Sky";
    [self.navigationController pushViewController:tView animated:YES];
}
@end
