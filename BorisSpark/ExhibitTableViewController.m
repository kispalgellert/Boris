//
//  ExhibitTableViewController.m
//  BorisSpark
//
//  Created by ASE Lab on 3/22/2014.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "ExhibitTableViewController.h"
#import "GlassViewController.h"
#import "Model.h"
#import "Exhibit.h"
#import "Gallery.h"



@interface ExhibitTableViewController ()

@end

@implementation ExhibitTableViewController
{
    NSMutableArray *exhibits;
    Model *sharedModel;
}

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
    self.view.backgroundColor = [UIColor blackColor];
    _tableView.backgroundView = nil;
    _tableView.backgroundColor = [UIColor blackColor];
    _tableView.backgroundView.backgroundColor = [UIColor blackColor];
	// Do any additional setup after loading the view.
    exhibits = [[NSMutableArray alloc] init];
    sharedModel = [Model sharedModel];
    for (int i = 0; i < [[sharedModel galleryList] count]; i++)
    {
        if ([[[[sharedModel galleryList] objectAtIndex:i] name] isEqualToString:_galleryName])
        {
            for (id object in [[[sharedModel galleryList] objectAtIndex:i] exhibitList])
            {
                [exhibits addObject:object];
            }
        }
    }
    self.view.backgroundColor = [UIColor clearColor];
    [_tableView setSeparatorColor:[UIColor clearColor]];
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [exhibits count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[[exhibits objectAtIndex:indexPath.row] background]];
    cell.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    
//    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.textLabel.text = [@"\n" stringByAppendingString:[[exhibits objectAtIndex:indexPath.row] name]];
////    cell.textLabel.text = (@"\n%@",[[exhibits objectAtIndex:indexPath.row] name]);
//    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:33];
//    cell.textLabel.numberOfLines = 0;
//    [cell.textLabel sizeToFit];
    
    //[cell.contentView.layer setBorderColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor];
    //[cell.contentView.layer setBorderWidth:1.0f];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,26,320,30)];
    label.textColor = [UIColor whiteColor];
    label.text = [[exhibits objectAtIndex:indexPath.row] name];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:22];
    label.shadowColor = [UIColor blackColor];
    label.shadowOffset = CGSizeMake(1, -1);
    //label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [cell.contentView addSubview:label];
    
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:1
                                                      green:1
                                                       blue:1
                                                      alpha:0.7];
    cell.selectedBackgroundView =  customColorView;
    
//    UILabel *ttitle = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)] autorelease];
//    ttitle.font = [UIFont boldSystemFontOfSize:13];
//    ttitle.textColor    = [UIColor blackColor];
//    ttitle.textAlignment = UITextAlignmentLeft;
//    
//    [ttitle setText:[[stories objectAtIndex: storyIndex] objectForKey: @"title"]];
//    
//    [cell.contentView addSubview:ttitle];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GlassViewController *view = [[GlassViewController alloc] init];
    view.selectedGallery = _galleryName;
    view.selectedExhibit = [[exhibits objectAtIndex:indexPath.row] name];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:view animated:YES];

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.backgroundColor = [UIColor redColor]; //must do here in willDisplayCell
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
