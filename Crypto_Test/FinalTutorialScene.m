//
//  FinalTutorialScene.m
//  Crypto_Test
//
//  Created by Basel Farag on 9/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "FinalTutorialScene.h"
#import "MenuScene.h"

@implementation FinalTutorialScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        //background setup
        SKSpriteNode *tutorialScene = [SKSpriteNode spriteNodeWithImageNamed:@"TutorialScreen4"];
        tutorialScene.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        tutorialScene.size = CGSizeMake(320, 568);
        tutorialScene.name = @"GoToTut3";
        [self addChild:tutorialScene];

        //Back button
        SKSpriteNode *menuButton = [SKSpriteNode spriteNodeWithImageNamed: @"BackButton"];
        menuButton.position = CGPointMake(CGRectGetMidX(self.frame) + 125, CGRectGetMidY(self.frame) + 250);
        menuButton.size = CGSizeMake(65, 50);
        [menuButton setName:@"backButtonNode"];
        [self addChild:menuButton];


    }

    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Set up a touch event
    UITouch *tutorialTouch = [touches anyObject];
    //Create a CGLocation point
    CGPoint location = [tutorialTouch locationInNode:self];
    //create a node where location can be accepted
    SKNode *node = [self nodeAtPoint:location];
    NSLog(@"SUP");

    if ([node.name isEqualToString:@"backButtonNode"])
    {
        MenuScene *menuScene = [MenuScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:menuScene transition:transition];
    }

}


@end
