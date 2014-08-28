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

        SKLabelNode *clickToContinue = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        clickToContinue.text = @"You lose! Europe is lost!";
        clickToContinue.fontSize = 12;
        clickToContinue.fontColor = [SKColor whiteColor];
        clickToContinue.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 40);
        [self addChild:clickToContinue];

        //back button
        SKSpriteNode *restartButton = [SKSpriteNode spriteNodeWithImageNamed: @"backButton"];
        restartButton.position = CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMidY(self.frame) - 50);
        restartButton.name = @"restartButtonNode";
        [self addChild:restartButton];
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
