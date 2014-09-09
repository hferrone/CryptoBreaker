//
//  NextTutorialGameScene.m
//  Crypto_Test
//
//  Created by Basel Farag on 9/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "TutorialScene2.h"
#import "FinalTutorialScene.h"

@implementation TutorialScene2

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        //background setup
        SKSpriteNode *tutorialScene = [SKSpriteNode spriteNodeWithImageNamed:@"TutorialScreen3"];
        tutorialScene.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        tutorialScene.size = CGSizeMake(320, 568);
        [self addChild:tutorialScene];
    }

    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    FinalTutorialScene *toTutorial3 = [FinalTutorialScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:1.0];

    [self.view presentScene:toTutorial3 transition:transition];
}

@end
