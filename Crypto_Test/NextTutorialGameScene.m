//
//  NextTutorialGameScene.m
//  Crypto_Test
//
//  Created by Basel Farag on 9/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "NextTutorialGameScene.h"
#import "FinalTutorialScene.h"

@implementation NextTutorialGameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        //background setup
        SKSpriteNode *tutorialScene = [SKSpriteNode spriteNodeWithImageNamed:@"TutorialScreen3"];
        tutorialScene.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        tutorialScene.size = CGSizeMake(320, 568);
        tutorialScene.name = @"GoToTut3";
        [self addChild:tutorialScene];
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
    node.name = @"GoToTut4";
    NSLog(@"SUP");

    if([node.name isEqualToString:@"GoToTut4"]){
        FinalTutorialScene *tutorialSceneThree = [FinalTutorialScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:0.5];
        [tutorialSceneThree setName:@"GoToTutorial"];
        [self.view presentScene:tutorialSceneThree transition:transition];
    }


}

@end
