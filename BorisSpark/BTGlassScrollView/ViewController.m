//
//  ViewController.m
//  BTGlassScrollViewExample
//
//  Created by Byte on 10/18/13.
//  Copyright (c) 2013 Byte. All rights reserved.
//

#define SIMPLE_SAMPLE NO


#import "ViewController.h"
#import "Model.h"
#import "Gallery.h"
#import "Exhibit.h"

@interface ViewController ()

@end

@implementation ViewController
{
    BTGlassScrollView *_glassScrollView;
    
    UIScrollView *_viewScroller;
    BTGlassScrollView *_glassScrollView1;
    BTGlassScrollView *_glassScrollView2;
    BTGlassScrollView *_glassScrollView3;
    int _page;
    Model *sharedModel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _page = 0;
    }
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sharedModel = [Model sharedModel];
    
    //showing white status
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //preventing weird inset
    [self setAutomaticallyAdjustsScrollViewInsets: NO];
    
    //navigation bar work
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:CGSizeMake(1, 1)];
    [shadow setShadowColor:[UIColor blackColor]];
    [shadow setShadowBlurRadius:1];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSShadowAttributeName: shadow};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.title = @"Awesome App";

    //background
    self.view.backgroundColor = [UIColor blackColor];
    
#warning Toggle this to see the more complex build of this version
    if (SIMPLE_SAMPLE) {
        //create your custom info views
        UIView *view = [self customView];
        
        _glassScrollView = [[BTGlassScrollView alloc] initWithFrame:self.view.frame BackgroundImage:[UIImage imageNamed:@"background3"] blurredImage:nil viewDistanceFromBottom:120 foregroundView:view];
        
        [self.view addSubview:_glassScrollView];
    }else{
        CGFloat blackSideBarWidth = 2;
        
        _viewScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, self.view.frame.size.height)];
        [_viewScroller setPagingEnabled:YES];
        [_viewScroller setDelegate:self];
        [_viewScroller setShowsHorizontalScrollIndicator:NO];
        [self.view addSubview:_viewScroller];
        
//        for (int i = 0; i < [[[[sharedModel galleryList] objectAtIndex:_galleryIndex] exhibitList] count]; i++)
//        {
//            _glassScrollView1 = [[BTGlassScrollView alloc] initWithFrame:self.view.frame
//                                                         BackgroundImage:[[[[sharedModel galleryList] objectAtIndex:_galleryIndex] objectAtIndex:i] background]
//                                                            blurredImage:nil
//                                                  viewDistanceFromBottom:120
//                                                          foregroundView:[self customView]];
//            [_viewScroller addSubview:_glassScrollView1];
//        }
//
        
        _glassScrollView1 = [[BTGlassScrollView alloc] initWithFrame:self.view.frame
                                                     BackgroundImage:[[[[[sharedModel galleryList] objectAtIndex:_galleryIndex] exhibitList] objectAtIndex:0] background]
                                                        blurredImage:nil
                                              viewDistanceFromBottom:120
                                                      foregroundView:[self customView]];
        
        _glassScrollView2 = [[BTGlassScrollView alloc] initWithFrame:self.view.frame
                                                     BackgroundImage:[[[[[sharedModel galleryList] objectAtIndex:_galleryIndex] exhibitList] objectAtIndex:1] background]
                                                        blurredImage:nil
                                              viewDistanceFromBottom:120
                                                      foregroundView:[self customView]];
        
        _glassScrollView3 = [[BTGlassScrollView alloc] initWithFrame:self.view.frame
                                                     BackgroundImage:[[[[[sharedModel galleryList] objectAtIndex:_galleryIndex] exhibitList] objectAtIndex:2] background]
                                                        blurredImage:nil
                                              viewDistanceFromBottom:120
                                                      foregroundView:[self customView]];

        
        [_viewScroller addSubview:_glassScrollView1];
        [_viewScroller addSubview:_glassScrollView2];
        [_viewScroller addSubview:_glassScrollView3];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    if (!SIMPLE_SAMPLE) {
        int page = _page; // resize scrollview can cause setContentOffset off for no reason and screw things up
        
        CGFloat blackSideBarWidth = 2;
        [_viewScroller setFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, self.view.frame.size.height)];
        [_viewScroller setContentSize:CGSizeMake(3*_viewScroller.frame.size.width, self.view.frame.size.height)];
        
        [_glassScrollView1 setFrame:self.view.frame];
        [_glassScrollView2 setFrame:self.view.frame];
        [_glassScrollView3 setFrame:self.view.frame];
        
        [_glassScrollView2 setFrame:CGRectOffset(_glassScrollView2.bounds, _viewScroller.frame.size.width, 0)];
        [_glassScrollView3 setFrame:CGRectOffset(_glassScrollView3.bounds, 2*_viewScroller.frame.size.width, 0)];
        
        [_viewScroller setContentOffset:CGPointMake(page * _viewScroller.frame.size.width, _viewScroller.contentOffset.y)];
        _page = page;
    }
    
    //show animation trick
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
       // [_glassScrollView1 setBackgroundImage:[UIImage imageNamed:@"background"] overWriteBlur:YES animated:YES duration:1];
    });
}

- (void)viewWillLayoutSubviews
{
    // if the view has navigation bar, this is a great place to realign the top part to allow navigation controller
    // or even the status bar
    if (SIMPLE_SAMPLE) {
        [_glassScrollView setTopLayoutGuideLength:[self.topLayoutGuide length]];
    }else{
        [_glassScrollView1 setTopLayoutGuideLength:[self.topLayoutGuide length]];
        [_glassScrollView2 setTopLayoutGuideLength:[self.topLayoutGuide length]];
        [_glassScrollView3 setTopLayoutGuideLength:[self.topLayoutGuide length]];
    }
}

- (UIView *)customView
{
    CGSize size = [[[[[[sharedModel galleryList] objectAtIndex:_galleryIndex] exhibitList] objectAtIndex:_page+1] name]
                   sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60]
                   constrainedToSize:CGSizeMake(310, 200)
                   lineBreakMode:UILineBreakModeWordWrap];
    CGSize size1 = [[[[[[sharedModel galleryList] objectAtIndex:_galleryIndex] exhibitList] objectAtIndex:_page+1] description]
                    sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]
                    constrainedToSize:CGSizeMake(310, 200)
                    lineBreakMode:UILineBreakModeWordWrap];
    CGSize size2 = [[[[[[sharedModel galleryList] objectAtIndex:_galleryIndex] exhibitList] objectAtIndex:_page+1] questions]
                    sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]
                    constrainedToSize:CGSizeMake(310, 200)
                    lineBreakMode:UILineBreakModeWordWrap];
    CGSize size3 = [[[[[[sharedModel galleryList] objectAtIndex:_galleryIndex] exhibitList] objectAtIndex:_page+1] buttonLabel]
                    sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]
                    constrainedToSize:CGSizeMake(310, 200)
                    lineBreakMode:UILineBreakModeWordWrap];
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    NSLog(@"%f",window.frame.size.height
);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, window.frame.size.height+size.height)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 35, 310, size.height)];
    [label setText:[[[[[sharedModel galleryList] objectAtIndex:_galleryIndex] exhibitList] objectAtIndex:_page+1] name]];
//    [label setText:[NSString stringWithFormat:@"Line 1\nLine 2\nLine 3"]];
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
    [label1 setText:[[[[[sharedModel galleryList] objectAtIndex:_galleryIndex] exhibitList] objectAtIndex:_page+1] description]];
    //[label1 setText:[NSString stringWithFormat:@"lorem ip[sumadmaisodmoaismdioamsdioamsdiomasiodmaiosmds"]];
    [label1 setTextColor:[UIColor whiteColor]];
    [label1 setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]];
    [label1 setShadowColor:[UIColor blackColor]];
    [label1 setShadowOffset:CGSizeMake(1, 1)];
    [label1 setNumberOfLines:0];
    [view addSubview:box1];
    [view addSubview:label1];
    
    UIView *box2 = [[UIView alloc] initWithFrame:CGRectMake(5, 140+size1.height+5, 310, size2.height)];
    box2.layer.cornerRadius = 3;
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 140+size1.height+5, 310, size2.height)];
    [label2 setText:[[[[[sharedModel galleryList] objectAtIndex:_galleryIndex] exhibitList] objectAtIndex:_page+1] questions]];
    //[label1 setText:[NSString stringWithFormat:@"lorem ip[sumadmaisodmoaismdioamsdioamsdiomasiodmaiosmds"]];
    [label2 setTextColor:[UIColor whiteColor]];
    [label2 setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]];
    [label2 setShadowColor:[UIColor blackColor]];
    [label2 setShadowOffset:CGSizeMake(1, 1)];
    [label2 setNumberOfLines:0];
    box2.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
    [view addSubview:label2];
    [view addSubview:box2];
    
    UIView *box3 = [[UIView alloc] initWithFrame:CGRectMake(5, 140+size1.height+5+size2.height+5, 310, size3.height)];
    box3.layer.cornerRadius = 3;
    box3.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(5, 140+size1.height+5+size2.height+5, 310, size3.height)];
    [label3 setText:[[[[[sharedModel galleryList] objectAtIndex:_galleryIndex] exhibitList] objectAtIndex:_page+1] buttonLabel]];
    //[label1 setText:[NSString stringWithFormat:@"lorem ip[sumadmaisodmoaismdioamsdioamsdiomasiodmaiosmds"]];
    [label3 setTextColor:[UIColor whiteColor]];
    [label3 setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]];
    [label3 setShadowColor:[UIColor blackColor]];
    [label3 setShadowOffset:CGSizeMake(1, 1)];
    [label3 setNumberOfLines:0];
    [view addSubview:box3];
    [view addSubview:label3];
    
    return view;
}

- (CGSize)sizeForLabel:(UILabel *)label {
    CGSize constrain = CGSizeMake(label.bounds.size.width, FLT_MAX);
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:constrain lineBreakMode:UILineBreakModeWordWrap];
    
    return size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat ratio = scrollView.contentOffset.x/scrollView.frame.size.width;
    _page = (int)floor(ratio);
    NSLog(@"%i",_page);
    if (ratio > -1 && ratio < 1) {
        [_glassScrollView1 scrollHorizontalRatio:-ratio];
    }
    if (ratio > 0 && ratio < 2) {
        [_glassScrollView2 scrollHorizontalRatio:-ratio + 1];
    }
    if (ratio > 1 && ratio < 3) {
        [_glassScrollView3 scrollHorizontalRatio:-ratio + 2];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    BTGlassScrollView *glass = [self currentGlass];
    
    //can probably be optimized better than this
    //this is just a demonstration without optimization
    [_glassScrollView1 scrollVerticallyToOffset:glass.foregroundScrollView.contentOffset.y];
    [_glassScrollView2 scrollVerticallyToOffset:glass.foregroundScrollView.contentOffset.y];
    [_glassScrollView3 scrollVerticallyToOffset:glass.foregroundScrollView.contentOffset.y];
}

- (BTGlassScrollView *)currentGlass
{
    BTGlassScrollView *glass;
    switch (_page) {
        case 0:
            glass = _glassScrollView1;
            break;
        case 1:
            glass = _glassScrollView2;
            break;
        case 2:
            glass = _glassScrollView3;
        default:
            break;
    }
    return glass;
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
