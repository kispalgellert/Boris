//
//  Model.m
//  BorisSpark
//
//  Created by Gellert on 2/18/2014.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "Model.h"
#import "Exhibit.h"
#import "Gallery.h"

@implementation Model

-(NSArray *)findFiles:(NSString *)extension{
    
    NSMutableArray *matches = [[NSMutableArray alloc]init];
    NSFileManager *fManager = [NSFileManager defaultManager];
    NSString *item;
    NSArray *contents = [fManager contentsOfDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] error:nil];
    
    // >>> this section here adds all files with the chosen extension to an array
    for (item in contents){
        if ([[item pathExtension] isEqualToString:extension]) {
            [matches addObject:item];
        }
    }
    return matches;
}

- (id) init
{
    Gallery *gallery0 = [[Gallery alloc] init];
    Gallery *gallery1 = [[Gallery alloc] init];
    Gallery *gallery2 = [[Gallery alloc] init];
    int a = 0;
    for (int i = 0; i < 9; i++)
    {
        Exhibit *exhibit = [[Exhibit alloc] initWithDescription:[NSString stringWithFormat:@"exhibit %i description",i]
                                                      Questions:[NSString stringWithFormat:@"exhibit %i questions",i]
                                                    ButtonLabel:@"label"
                                                           Name:[NSString stringWithFormat:@"exhibit %i",a]
                                                     Background:[NSString stringWithFormat:@"background%i",a]];
        if (i < 3)
            [[gallery0 exhibitList] addObject:exhibit];
        else if (i < 6)
            [[gallery1 exhibitList] addObject:exhibit];
        else
            [[gallery2 exhibitList] addObject:exhibit];
        a++;
        if (a == 3)
            a = 0;
    }
    _galleryList = [[NSMutableArray alloc] init];
    [_galleryList addObject:gallery0];
    [_galleryList addObject:gallery1];
    [_galleryList addObject:gallery2];
    
    NSArray *arr = [[NSArray alloc] initWithArray:[self findFiles:@"h"]];
    for (int i = 0; i < [arr count]; i++)
    {
        NSLog(@"qwe %@", [arr objectAtIndex:i]);
    }
    return self;
}

+ (id)sharedModel {
    static Model *sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedModel = [[self alloc] init];
    });
    return sharedModel;
}

@end
