//
//  TablePageViewController.m
//  BorisSpark
//
//  Created by Gellert on 2014-04-08.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "TablePageViewController.h"
#import "TableContent.h"

@interface TablePageViewController ()

@end

@implementation TablePageViewController

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
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [view setBackgroundColor:[UIColor greenColor]];
    
    
    [super viewDidLoad];
    
    _currentStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    NSNumber *aNum = [[NSNumber alloc] initWithInt:0];
    TableContent *first = [_currentStoryboard instantiateViewControllerWithIdentifier:@"TableContentID"];
    [first initView];
    first.index = aNum.integerValue;
    TableContent *second = [_currentStoryboard instantiateViewControllerWithIdentifier:@"TableContentID"];
    second.index = [[NSNumber numberWithInt:[aNum intValue] + 1] integerValue];
    [second initView];
    _pages = [[NSArray alloc] initWithObjects:first, second, nil];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:first, nil];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
}


- (TableContent *)viewControllerAtIndex:(NSUInteger)index {
    NSNumber* requestedPage = [NSNumber numberWithInt:(long)index % [_pages count]];
    return _pages[[requestedPage intValue]];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger currentViewControllerIndex = [(TableContent *)viewController index];
    currentViewControllerIndex++;
    return [self viewControllerAtIndex:currentViewControllerIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger currentViewControllerIndex = [(TableContent *)viewController index];
    currentViewControllerIndex--;
    return [self viewControllerAtIndex:currentViewControllerIndex];
}


- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end