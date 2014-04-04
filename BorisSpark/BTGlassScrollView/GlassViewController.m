//
//  ViewController.m
//  BTGlassScrollViewExample
//
//  Created by Byte on 10/18/13.
//  Copyright (c) 2013 Byte. All rights reserved.
//

#import "GlassViewController.h"
#import "Model.h"
#import "Gallery.h"
#import "Exhibit.h"
#import "SWRevealViewController.h"
#import "SideMenuTableViewController.h"
#import "UIViewController+BackButtonHandler.h"


@interface GlassViewController ()

@end

@implementation GlassViewController
{
//    BTGlassScrollView *_glassScrollView;
    
//    UIScrollView *_viewScroller;
    UIScrollView *_viewScroll;
//    BTGlassScrollView *_glassScrollView1;
//    BTGlassScrollView *_glassScrollView2;
//    BTGlassScrollView *_glassScrollView3;
    int _page;
    int _pageIndex;
    Model *sharedModel;
    NSMutableArray *_glassScrollArray;
    int galleryIndex;
    int counter;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _page = 0;
        _pageIndex = 0;
        counter = 0;
    }
    
    return self;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [(SideMenuTableViewController*)(self.revealViewController.rightViewController) setSelectedExhibit:_selectedExhibit];
    [(SideMenuTableViewController*)(self.revealViewController.rightViewController) setSelectedGallery:_selectedGallery];
    [[(SideMenuTableViewController*)(self.revealViewController.rightViewController) tableView] reloadData];

    
    sharedModel = [Model sharedModel];
    for (int i = 0; i < [[sharedModel galleryList] count]; i++)
    {
        if ([[[[sharedModel galleryList] objectAtIndex:i] name] caseInsensitiveCompare:_selectedGallery] == NSOrderedSame)
            galleryIndex = i;
    }


    for (int i = 0; i < [[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] count]; i++)
    {
        if ([[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:i] name] caseInsensitiveCompare:_selectedExhibit] == NSOrderedSame)
            _pageIndex = i;
    }
    
   
    
                _glassScrollArray = [[NSMutableArray alloc] init];

    
    //showing white status
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //preventing weird inset
    [self setAutomaticallyAdjustsScrollViewInsets: NO];
    
    //navigation bar work
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:CGSizeMake(1, 1)];
    [shadow setShadowColor:[UIColor blackColor]];
    [shadow setShadowBlurRadius:1];

    


    //background
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat blackSideBarWidth = 2;
    
//    _viewScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, self.view.frame.size.height)];
//    [_viewScroller setPagingEnabled:YES];
//    [_viewScroller setDelegate:self];
//    [_viewScroller setShowsHorizontalScrollIndicator:NO];
//    [self.view addSubview:_viewScroller];
    
    
                _viewScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, self.view.frame.size.height)];
                [_viewScroll setPagingEnabled:YES];
                [_viewScroll setDelegate:self];
                [_viewScroll setShowsHorizontalScrollIndicator:NO];
                [self.view addSubview:_viewScroll];
    
                for (int i = 0; i < [[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] count]; i++)
                {
                    BTGlassScrollView *glassView = [[BTGlassScrollView alloc] initWithFrame:self.view.frame
                                                                            BackgroundImage:[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:i] background]
                                                                               blurredImage:nil
                                                                     viewDistanceFromBottom:120
                                                                             foregroundView:[self customView]];
                    
                    
                    [_glassScrollArray addObject:glassView];
                    [_viewScroll addSubview:glassView];
                }
    
    
//    _glassScrollView1 = [[BTGlassScrollView alloc] initWithFrame:self.view.frame
//                                                 BackgroundImage:[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:0] background]
//                                                    blurredImage:nil
//                                          viewDistanceFromBottom:120
//                                                  foregroundView:[self customView]];
//    
//    _glassScrollView2 = [[BTGlassScrollView alloc] initWithFrame:self.view.frame
//                                                 BackgroundImage:[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:1] background]
//                                                    blurredImage:nil
//                                          viewDistanceFromBottom:120
//                                                  foregroundView:[self customView]];
//    
//    _glassScrollView3 = [[BTGlassScrollView alloc] initWithFrame:self.view.frame
//                                                 BackgroundImage:[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:2] background]
//                                                    blurredImage:nil
//                                          viewDistanceFromBottom:120
//                                                  foregroundView:[self customView]];
//
//    
//    [_viewScroller addSubview:_glassScrollView1];
//    [_viewScroller addSubview:_glassScrollView2];
//    [_viewScroller addSubview:_glassScrollView3];
    
  
    
}



-(void)viewDidAppear:(BOOL)animated
{
     if (galleryIndex == 0)
     {
//         TableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
//         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
         //[[[(SideBarTableViewController*)(self.revealViewController.rightViewController) firstCell] textLabel] setText:@"FUCK YEA"];
         //[(SideBarTableViewController*)(self.revealViewController.rightViewController) setTemp:10];
     }
}

-(void)forceRedraw
{
    [self.view setNeedsDisplay];
}

- (void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightRevealToggle:)];
    
    // Change button color
    button.tintColor = [UIColor whiteColor];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    button.target = self.revealViewController;
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.navigationItem.rightBarButtonItem = button;
//    int page = _page; // resize scrollview can cause setContentOffset off for no reason and screw things up
                int pageIndex = _pageIndex;
    
    CGFloat blackSideBarWidth = 2;
//    [_viewScroller setFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, self.view.frame.size.height)];
//    [_viewScroller setContentSize:CGSizeMake(3*_viewScroller.frame.size.width, self.view.frame.size.height)];
    
                [_viewScroll setFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, self.view.frame.size.height)];
                [_viewScroll setContentSize:CGSizeMake([[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] count]*_viewScroll.frame.size.width, self.view.frame.size.height)];
            
                for (int i = 0; i < [_glassScrollArray count]; i++)
                {
                    [[_glassScrollArray objectAtIndex:i] setFrame:self.view.frame];
                }
            
                int a = 1;
                for (int i = 1; i < [_glassScrollArray count]; i++)
                {
                    [[_glassScrollArray objectAtIndex:i] setFrame:CGRectOffset([[_glassScrollArray objectAtIndex:i] bounds], a*_viewScroll.frame.size.width, 0)];
                    a++;
                }
            
                [_viewScroll setContentOffset:CGPointMake(pageIndex * _viewScroll.frame.size.width, _viewScroll.contentOffset.y)];
                _pageIndex = pageIndex;
    
//    [_glassScrollView1 setFrame:self.view.frame];
//    [_glassScrollView2 setFrame:self.view.frame];
//    [_glassScrollView3 setFrame:self.view.frame];
//    
//    [_glassScrollView2 setFrame:CGRectOffset(_glassScrollView2.bounds, _viewScroller.frame.size.width, 0)];
//    [_glassScrollView3 setFrame:CGRectOffset(_glassScrollView3.bounds, 2*_viewScroller.frame.size.width, 0)];
//    
//    [_viewScroller setContentOffset:CGPointMake(page * _viewScroller.frame.size.width, _viewScroller.contentOffset.y)];
//    _page = page;
    
    //show animation trick
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
       // [_glassScrollView1 setBackgroundImage:[UIImage imageNamed:@"background"] overWriteBlur:YES animated:YES duration:1];
    });
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillLayoutSubviews
{
    // if the view has navigation bar, this is a great place to realign the top part to allow navigation controller
    // or even the status bar
//    [_glassScrollView1 setTopLayoutGuideLength:[self.topLayoutGuide length]];
//    [_glassScrollView2 setTopLayoutGuideLength:[self.topLayoutGuide length]];
//    [_glassScrollView3 setTopLayoutGuideLength:[self.topLayoutGuide length]];
    
                for (int i = 0; i < [_glassScrollArray count]; i++)
                {
                    [[_glassScrollArray objectAtIndex:i] setTopLayoutGuideLength:[self.topLayoutGuide length]];
                }
}

- (UIView *)customView
{
    NSString *questionString = @"";
    for (int i = 0; i < [[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:counter] questions] count]; i++)
    {
        questionString = [questionString stringByAppendingString:[[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:counter] questions] objectAtIndex:i]];
        questionString = [questionString stringByAppendingString:@"\n\n"];
    }
    
    CGSize size = [[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:counter] name]
                   sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60]
                   constrainedToSize:CGSizeMake(310, 200)
                   lineBreakMode:UILineBreakModeWordWrap];
    CGSize size1 = [[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:counter] description]
                    sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]
                    constrainedToSize:CGSizeMake(310, 500)
                    lineBreakMode:UILineBreakModeWordWrap];
    CGSize size2 = [questionString
                    sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]
                    constrainedToSize:CGSizeMake(310, 500)
                    lineBreakMode:UILineBreakModeWordWrap];
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, window.frame.size.height+size.height)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 35, 310, size.height)];
    [label setText:[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:counter] name]];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60]];
    [label setShadowColor:[UIColor blackColor]];
    [label setShadowOffset:CGSizeMake(1, 1)];
    [label setNumberOfLines:0];
    [view addSubview:label];

    
    UIView *box1 = [[UIView alloc] initWithFrame:CGRectMake(5, 140, 310, size1.height)];
    box1.layer.cornerRadius = 3;
    box1.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 140, 310, size1.height)];
    [label1 setText:[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:counter] description]];
    [label1 setTextColor:[UIColor whiteColor]];
    [label1 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
    [label1 setShadowColor:[UIColor blackColor]];
    [label1 setShadowOffset:CGSizeMake(1, 1)];
    [label1 setNumberOfLines:0];
    [view addSubview:box1];
    [view addSubview:label1];
    
    UIView *box2 = [[UIView alloc] initWithFrame:CGRectMake(5, 140+size1.height+10, 310, size2.height)];
    box2.layer.cornerRadius = 3;
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 140+size1.height+10, 310, size2.height)];

    [label2 setText:questionString];
    [label2 setTextColor:[UIColor whiteColor]];
    [label2 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
    [label2 setShadowColor:[UIColor blackColor]];
    [label2 setShadowOffset:CGSizeMake(1, 1)];
    [label2 setNumberOfLines:0];
    box2.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
    [view addSubview:label2];
    [view addSubview:box2];

    UIView *box3 = [[UIView alloc] initWithFrame:CGRectMake(5, 140+size1.height+10+size2.height+10, 310, size2.height)];
    box3.layer.cornerRadius = 3;
    box3.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
    UIButton *collage = [UIButton buttonWithType:UIButtonTypeCustom];
    collage.frame = CGRectMake(5, 140+size1.height+10+size2.height+10, 310, size2.height);
    [collage setTitle:@"Take Photo For Collage" forState:UIControlStateNormal];
    [collage addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchUpInside];
    [collage setEnabled:YES];
    [[collage titleLabel] setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
    [collage setBackgroundColor:[UIColor clearColor]];

//    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(5, 140+size1.height+10+size2.height+10, 310, size2.height)];
//    [label3 setText:[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:counter] description]];
//    [label3 setTextColor:[UIColor whiteColor]];
//    [label3 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
//    [label3 setShadowColor:[UIColor blackColor]];
//    [label3 setShadowOffset:CGSizeMake(1, 1)];
//    [label3 setNumberOfLines:0];
    [view addSubview:box3];
    [view addSubview:collage];
//    [view addSubview:label3];

    counter++;
    return view;
}

-(void)myAction:(id)sender {
    NSLog(@"ha");
}


- (CGSize)sizeForLabel:(UILabel *)label {
    CGSize constrain = CGSizeMake(label.bounds.size.width, FLT_MAX);
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:constrain lineBreakMode:UILineBreakModeWordWrap];
    
    return size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat ratio = scrollView.contentOffset.x/scrollView.frame.size.width;
//    _page = (int)floor(ratio);
//    if (ratio > -1 && ratio < 1) {
//        [_glassScrollView1 scrollHorizontalRatio:-ratio];
//    }
//    if (ratio > 0 && ratio < 2) {
//        [_glassScrollView2 scrollHorizontalRatio:-ratio + 1];
//    }
//    if (ratio > 1 && ratio < 3) {
//        [_glassScrollView3 scrollHorizontalRatio:-ratio + 2];
//    }

                CGFloat currentRatio = scrollView.contentOffset.x/scrollView.frame.size.width;
                int temp = (int)floor(currentRatio);
                if (_pageIndex != temp)
                {
                    _pageIndex = temp;
                    NSString * newExhibit = [[NSString alloc] init];
                    newExhibit = [[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:_pageIndex] name];
                    [(SideMenuTableViewController*)(self.revealViewController.rightViewController) setSelectedExhibit:newExhibit];
                    [[(SideMenuTableViewController*)(self.revealViewController.rightViewController) tableView] reloadData];
                }

                int lowerBound = -1;
                int upperBound = 1;
                for (int i = 0; i < [_glassScrollArray count]; i++)
                {
                    if (currentRatio > lowerBound && currentRatio < upperBound)
                        [[_glassScrollArray objectAtIndex:i] scrollHorizontalRatio:-currentRatio + upperBound - 1];

                    lowerBound++;
                    upperBound++;
                }
}



- (void)viewWillDisappear:(BOOL)animated {
    
    //if true, back was pressed
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        NSLog(@"count = %i", [self.navigationController.viewControllers count]);
        //[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        //[self.navigationController popToRootViewControllerAnimated:NO];
    }
}

-(BOOL) navigationShouldPopOnBackButton {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    return NO; // Ignore 'Back' button this time
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    BTGlassScrollView *glass = [self currentGlass];
    
    //can probably be optimized better than this
//    //this is just a demonstration without optimization
//    [_glassScrollView1 scrollVerticallyToOffset:glass.foregroundScrollView.contentOffset.y];
//    [_glassScrollView2 scrollVerticallyToOffset:glass.foregroundScrollView.contentOffset.y];
//    [_glassScrollView3 scrollVerticallyToOffset:glass.foregroundScrollView.contentOffset.y];
    
                for (int i = 0; i < [_glassScrollArray count]; i++)
                {
                    [[_glassScrollArray objectAtIndex:i] scrollVerticallyToOffset:glass.foregroundScrollView.contentOffset.y];
                }
}

- (BTGlassScrollView *)currentGlass
{
    BTGlassScrollView *glass;
    BTGlassScrollView *currentGlass;
//    switch (_page) {
//        case 0:
//            glass = _glassScrollView1;
//            break;
//        case 1:
//            glass = _glassScrollView2;
//            break;
//        case 2:
//            glass = _glassScrollView3;
//        default:
//            break;
//    }
//            switch (_pageIndex)
//            {
//                case 0:
//                    currentGlass = [_glassScrollArray objectAtIndex:_pageIndex];
//                    break;
//                default:
//                    break;
//            }
    for (int i = 0; i < [_glassScrollArray count]; i++)
    {
        if (i == _pageIndex)
            currentGlass = [_glassScrollArray objectAtIndex:_pageIndex];
    }

//                currentGlass = [_glassScrollArray objectAtIndex:_pageIndex];

    
//    return glass;
                return currentGlass;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self viewWillAppear:YES];
}

@end
