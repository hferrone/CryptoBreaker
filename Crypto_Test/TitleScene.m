//
//  TitleScene.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "TitleScene.h"
#import "MenuScene.h"

@interface TitleScene ()

@end


@implementation TitleScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        //background setup and segue with fade
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"TitleSceneBackground"];
        background.position = CGPointMake(CGRectGetMidX(self.frame) - 125, CGRectGetMidY(self.frame) + 125);
        background.size = CGSizeMake(325, 200);
        background.color = [UIColor blackColor];

        [self addChild:background];

        [self performSelector:@selector(segueToMenu) withObject:self.view afterDelay:1.0];
    }
    return self;
}

-(void)segueToMenu
{
    //segue to next scene - menu scene
    MenuScene *menuScene = [MenuScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:1.5];
    [self.view presentScene:menuScene transition:transition];
}

@end
