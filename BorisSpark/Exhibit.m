//
//  Exhibit.m
//  BorisSpark
//
//  Created by Gellert on 2/18/2014.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "Exhibit.h"

@implementation Exhibit

- (id) initWithDescription:(NSString*)description Questions:(NSString*)questions ButtonLabel:(NSString*)buttonLabel Name:(NSString*)name Background:(NSString*)imageName
{
    _description = [[NSString alloc] initWithString:description];
    _questions = [[NSString alloc] initWithString:questions];
    _buttonLabel = [[NSString alloc] initWithString:buttonLabel];
    //_background = [[UIImage alloc] initWithContentsOfFile:imageName];
    _background = [[UIImage alloc] init];
    _background = [UIImage imageNamed:imageName];
    _name = name;
    return self;
}

@end

