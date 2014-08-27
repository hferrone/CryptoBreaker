//
//  ProfileScene.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/23/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ProfileScene.h"
#import "MenuScene.h"

@implementation ProfileScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        SKSpriteNode *profileBackground = [SKSpriteNode spriteNodeWithImageNamed:@"ProfileSceneBackground"];
        profileBackground.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        profileBackground.size = CGSizeMake(320, 568);
        [self addChild:profileBackground];

        SKLabelNode *clickToContinue = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        clickToContinue.text = @"PROFILE";
        clickToContinue.fontSize = 12;
        clickToContinue.fontColor = [SKColor whiteColor];
        clickToContinue.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 40);
        [self addChild:clickToContinue];

        //back button
        SKSpriteNode *menuButton = [SKSpriteNode spriteNodeWithImageNamed: @"backButton"];
        menuButton.position = CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMidY(self.frame) - 50);
        menuButton.size = CGSizeMake(75, 65);
        [menuButton setName:@"backButtonNode"];
        [self addChild:menuButton];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    if ([node.name isEqualToString:@"backButtonNode"])
    {
        MenuScene *menuScene = [MenuScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:menuScene transition:transition];
    }
}

@end
