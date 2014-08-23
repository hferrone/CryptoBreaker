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
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splashScreen"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];

        SKLabelNode *clickToContinue = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        clickToContinue.text = @"Touch Screen to Play";
        clickToContinue.fontSize = 12;
        clickToContinue.fontColor = [SKColor blackColor];
        clickToContinue.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 40);
        [self addChild:clickToContinue];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    MenuScene *menuScene = [MenuScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:menuScene transition:transition];
}

@end
