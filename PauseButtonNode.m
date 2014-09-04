//
//  PauseButtonNode.m
//  Crypto_Test
//
//  Created by Basel Farag on 9/3/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "PauseButtonNode.h"

@implementation PauseButtonNode

+ (instancetype)pauseButtonLocation:(CGPoint)position
{
    PauseButtonNode *pauseButton = [self spriteNodeWithImageNamed:@"pause"];
    pauseButton.position = position;
    pauseButton.anchorPoint = CGPointMake(0.5, 0);
    pauseButton.size = CGSizeMake(65, 50);
    pauseButton.name = @"pauseButton";

    return pauseButton;
}

@end
