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

- (id) init
{
//    Gallery *gallery0 = [[Gallery alloc] init];
//    Gallery *gallery1 = [[Gallery alloc] init];
//    Gallery *gallery2 = [[Gallery alloc] init];
//    int a = 0;
//    for (int i = 0; i < 9; i++)
//    {
//        Exhibit *exhibit = [[Exhibit alloc] initWithDescription:[NSString stringWithFormat:@"exhibit %i description",i]
//                                                      Questions:[NSString stringWithFormat:@"exhibit %i questions",i]
//                                                    ButtonLabel:@"label"
//                                                           Name:[NSString stringWithFormat:@"exhibit %i",a]
//                                                     Background:[NSString stringWithFormat:@"background%i",a]];
//        if (i < 3)
//            [[gallery0 exhibitList] addObject:exhibit];
//        else if (i < 6)
//            [[gallery1 exhibitList] addObject:exhibit];
//        else
//            [[gallery2 exhibitList] addObject:exhibit];
//        a++;
//        if (a == 3)
//            a = 0;
//    }
    
    NSLog(@"INIT");
    
    Gallery *gallery0 = [[Gallery alloc] initWithName:@"Earth and Sky"];
    Gallery *gallery1 = [[Gallery alloc] initWithName:@"Energy and Innovation"];
    Gallery *gallery2 = [[Gallery alloc] initWithName:@"Feature"];
    Gallery *gallery3 = [[Gallery alloc] initWithName:@"Creative Kids Museum"];
    Gallery *gallery4 = [[Gallery alloc] initWithName:@"Open Studio"];
    Gallery *gallery5 = [[Gallery alloc] initWithName:@"Being Human"];
    
    _galleryList = [[NSMutableArray alloc] init];
    [_galleryList addObject:gallery0];
    [_galleryList addObject:gallery1];
    [_galleryList addObject:gallery2];
    [_galleryList addObject:gallery3];
    [_galleryList addObject:gallery4];
    [_galleryList addObject:gallery5];
    
    
    NSString *filePath = [[NSString alloc] init];
    int b = 0;
    while (filePath != nil)
    {
        NSString *name = @"exhibit";
        name = [name stringByAppendingString:[NSString stringWithFormat:@"%d",b]];
        //NSLog(@"name = %@", name);
        filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
        if (filePath)
        {
            NSString *contentOfFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            
            NSArray *brokenByLines = [contentOfFile componentsSeparatedByString:@"\n"];
            
            NSString *name = [[brokenByLines objectAtIndex:0] substringFromIndex:14];
            NSString *gallery = [[brokenByLines objectAtIndex:1] substringFromIndex:9];
            NSString *description = [[brokenByLines objectAtIndex:2] substringFromIndex:13];
            NSString *imageName = [[brokenByLines objectAtIndex:3] substringFromIndex:12];
            NSMutableArray *questionArray = [[NSMutableArray alloc] init];
            int c = 4;
            while (c < [brokenByLines count])
            {
                if ([[[brokenByLines objectAtIndex:c] substringToIndex:9] caseInsensitiveCompare:@"question"])
                {
                    [questionArray addObject:[[brokenByLines objectAtIndex:c] substringFromIndex:0]];
                    c++;
                }
                else
                    break;
            }
            
//            NSLog(@"Name = %@", name);
//            NSLog(@"Gallery = %@", gallery);
//            NSLog(@"Description = %@", description);
//            NSLog(@"Image = %@", imageName);
//            NSLog(@"Questions = %@", questionArray);
//            NSLog(@"file = %@", contentOfFile);
            
            Exhibit *exhibit = [[Exhibit alloc] initWithDescription:description Questions:questionArray Name:name Background:imageName];
            for (int i = 0; i < [_galleryList count]; i++)
            {
                if ([gallery caseInsensitiveCompare:[[_galleryList objectAtIndex:i] name]] == NSOrderedSame)
                {
                    [[[_galleryList objectAtIndex:i] exhibitList] addObject:exhibit];
                    break;
                }
            }
        }
        
        b++;
    }
    
//    for (int i = 0; i < [_galleryList count]; i++)
//    {
//        NSLog(@"GALLERY = %@", [[_galleryList objectAtIndex:i] name]);
//        NSLog(@"--------");
//        for (int a = 0; a < [[[_galleryList objectAtIndex:i] exhibitList] count]; a++)
//        {
//            NSLog(@"Exhibit = %@", [[[[_galleryList objectAtIndex:i] exhibitList] objectAtIndex:a] name]);
//            NSLog(@"Description = %@", [[[[_galleryList objectAtIndex:i] exhibitList] objectAtIndex:a] description]);
//            //NSLog(@"Image = %@", [[[[_galleryList objectAtIndex:i] exhibitList] objectAtIndex:a] background]);
//            NSLog(@"Questions = %@", [[[[_galleryList objectAtIndex:i] exhibitList] objectAtIndex:a] questions]);
//        }
//    }
//    NSLog(@"count = %d", [[[_galleryList objectAtIndex:1] exhibitList] count]);
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
