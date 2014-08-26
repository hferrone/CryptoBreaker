//
//  TitleScene.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "TitleScene.h"
#import "MenuScene.h"

@implementation TitleScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"TitleScene"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];

        [self performSelector:@selector(segueToMenu) withObject:self.view afterDelay:3.0];
    }
    return self;
}

-(void)segueToMenu
{
    MenuScene *menuScene = [MenuScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:menuScene transition:transition];
}

@end
