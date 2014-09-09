//
//  MenuScene.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/23/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "MenuScene.h"
#import "CreditsScene.h"
#import "TutorialScene1.h"
#import "StoryScene.h"

@interface MenuScene ()
@property (nonatomic) SKAction *pressStartSFX;

@end

@implementation MenuScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        //background setup
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"MenuSceneBackground"];
        background.size = CGSizeMake(320, 568);
        background.color = [UIColor blackColor];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];

        //new game UI button
        SKSpriteNode *newGameButton = [SKSpriteNode spriteNodeWithImageNamed: @"NewGame"];
        newGameButton.size = CGSizeMake(75, 65);
        [newGameButton setName:@"newGame"];
        [newGameButton setPosition:CGPointMake(CGRectGetMidX(self.frame) - 80, CGRectGetMidY(self.frame) + 120)];
        [self addChild:newGameButton];
        //We don't want our action to wait until the entire sound file is played.
        self.pressStartSFX = [SKAction playSoundFileNamed:@"" waitForCompletion:NO];

        //profile UI button
        SKSpriteNode *tutorialButton = [SKSpriteNode spriteNodeWithImageNamed: @"Tutorial"];
        tutorialButton.size = CGSizeMake(75, 65);
        [tutorialButton setName:@"tutorial"];
        [tutorialButton setPosition:CGPointMake(CGRectGetMidX(self.frame) - 80, CGRectGetMidY(self.frame) + 30)];
        [self addChild:tutorialButton];

        //credits UI button
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

    //user touch location - UI button interaction
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    [self runAction:self.pressStartSFX];

    //checking to see what label is touched and performing connected segue to correct scene
    if ([node.name isEqualToString:@"newGame"])
    {
        StoryScene *storyScene = [StoryScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:storyScene transition:transition];
    }else if ([node.name isEqualToString:@"tutorial"]){
        TutorialScene1 *tutorial1 = [TutorialScene1 sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:tutorial1 transition:transition];
    }else if ([node.name isEqualToString:@"credits"]){
        CreditsScene *creditScene = [CreditsScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:creditScene transition:transition];
    }
}

@end
