//
//  MenuScene.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/23/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "MenuScene.h"
#import "MainGameScene.h"

@implementation MenuScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        //adding menu buttons
        SKSpriteNode *menuButton = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(50, 50)];
        menuButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        menuButton.name = @"menuButton";
        [self addChild:menuButton];

        SKLabelNode *menuText = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        menuText.fontColor = [UIColor blackColor];
        menuText.text = @"New Game";
        menuText.fontSize = 10;
        menuText.name = @"menuLabel";
        [menuButton addChild:menuText];

//        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"menu"];
//        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//        [self addChild:background];
    }

    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    if ([node.name isEqualToString:@"menuLabel"])
    {
        MainGameScene *mainGameScene = [MainGameScene sceneWithSize:self.frame.size];
        SKTransition *transition =[SKTransition fadeWithDuration:1.0];
        [self.view presentScene:mainGameScene transition:transition];
    }
}

@end
