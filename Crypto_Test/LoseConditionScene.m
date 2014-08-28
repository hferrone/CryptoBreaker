//
//  LoseConditionScene.m
//  Crypto_Test
//
//  Created by Basel Farag on 8/26/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "LoseConditionScene.h"
#import "MenuScene.h"

@implementation LoseConditionScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        SKSpriteNode *creditBackground = [SKSpriteNode spriteNodeWithImageNamed:@"LoseSceneBackground"];
        creditBackground.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        creditBackground.size = CGSizeMake(320, 568);
        [self addChild:creditBackground];

        //back button
        SKSpriteNode *menuButton = [SKSpriteNode spriteNodeWithImageNamed: @"BackButton"];
        menuButton.position = CGPointMake(CGRectGetMidX(self.frame) - 80, CGRectGetMidY(self.frame) - 50);
        menuButton.size = CGSizeMake(75, 65);
        [menuButton setName:@"restartButtonNode"];
        [self addChild:menuButton];
    }

    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    if ([node.name isEqualToString:@"restartButtonNode"])
    {
        MenuScene *menuScene = [MenuScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:menuScene transition:transition];
    }
}

@end
