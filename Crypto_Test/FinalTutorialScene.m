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
    }

    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    MenuScene *toMenuScene= [MenuScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:0.5];

    [self.view presentScene:toMenuScene transition:transition];

}


@end
