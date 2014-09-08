//
//  TutorialGameScenes.m
//  Crypto_Test
//
//  Created by Basel Farag on 9/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "TutorialGameScenes.h"
#import "NextTutorialGameScene.h"

@implementation TutorialGameScenes

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        //background setup
        SKSpriteNode *tutorialScene = [SKSpriteNode spriteNodeWithImageNamed:@"TutorialScreen2"];
        tutorialScene.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        tutorialScene.size = CGSizeMake(320, 568);
        tutorialScene.name = @"GoToTutorial";
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
    node.name = @"GoToTut3";
    NSLog(@"SUP");

    if([node.name isEqualToString:@"GoToTut3"]){
        NextTutorialGameScene *tutorialSceneTwo = [NextTutorialGameScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:0.5];
        [tutorialSceneTwo setName:@"GoToTutorial"];
        [self.view presentScene:tutorialSceneTwo transition:transition];
    }
    
}

@end
