//
//  TutorialGameScenes.m
//  Crypto_Test
//
//  Created by Basel Farag on 9/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "TutorialScene1.h"
#import "TutorialScene2.h"

@implementation TutorialScene1

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        //background setup
        SKSpriteNode *tutorialScene = [SKSpriteNode spriteNodeWithImageNamed:@"TutorialScreen2"];
        tutorialScene.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        tutorialScene.size = CGSizeMake(320, 568);
        [self addChild:tutorialScene];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    TutorialScene2 *toTutorial2 = [TutorialScene2 sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:0.5];

    [self.view presentScene:toTutorial2 transition:transition];
}

@end
