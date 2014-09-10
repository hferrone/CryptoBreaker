//
//  StoryScene.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 9/9/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "StoryScene.h"
#import "MainGameScene.h"

@implementation StoryScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        //background setup
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"TutorialScreen1"];
        background.size = CGSizeMake(320, 568);
        background.color = [UIColor blackColor];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
    }

    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    MainGameScene *toGame = [MainGameScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:0.5];

    [self.view presentScene:toGame transition:transition];
}

@end
