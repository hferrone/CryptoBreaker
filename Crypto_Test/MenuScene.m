//
//  MenuScene.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/23/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "MenuScene.h"
#import "MainGameScene.h"
#import "CreditsScene.h"
#import "ProfileScene.h"

@implementation MenuScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"MenuSceneBackground"];
        background.size = CGSizeMake(320, 568);
        background.color = [UIColor blackColor];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];

        SKSpriteNode *newGameButton = [SKSpriteNode spriteNodeWithImageNamed: @"NewGame"];
        newGameButton.size = CGSizeMake(75, 65);
        [newGameButton setName:@"newGame"];
        [newGameButton setPosition:CGPointMake(CGRectGetMidX(self.frame) - 80, CGRectGetMidY(self.frame) + 120)];
        [self addChild:newGameButton];

        SKSpriteNode *profileButton = [SKSpriteNode spriteNodeWithImageNamed: @"Profile"];
        profileButton.size = CGSizeMake(75, 65);
        [profileButton setName:@"profile"];
        [profileButton setPosition:CGPointMake(CGRectGetMidX(self.frame) - 80, CGRectGetMidY(self.frame) + 30)];
        [self addChild:profileButton];

        SKSpriteNode *creditsButton = [SKSpriteNode spriteNodeWithImageNamed: @"Credits"];
        creditsButton.size = CGSizeMake(75, 65);
        [creditsButton setName:@"credits"];
        [creditsButton setPosition:CGPointMake(CGRectGetMidX(self.frame) - 80, CGRectGetMidY(self.frame) - 60)];
        [self addChild:creditsButton];
    }

    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    if ([node.name isEqualToString:@"newGame"])
    {
        MainGameScene *mainGameScene = [MainGameScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:mainGameScene transition:transition];
    }else if ([node.name isEqualToString:@"profile"]){
        ProfileScene *profileScene = [ProfileScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:profileScene transition:transition];
    }else if ([node.name isEqualToString:@"credits"]){
        CreditsScene *creditScene = [CreditsScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:creditScene transition:transition];
    }
}

@end
