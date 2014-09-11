//
//  LoseConditionScene.m
//  Crypto_Test
//
//  Created by Basel Farag on 8/26/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "LoseConditionScene.h"
#import "MenuScene.h"
#import <AVFoundation/AVFoundation.h>

@interface LoseConditionScene ()

@property AVAudioPlayer *loseConditionMusic;

@end

@implementation LoseConditionScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        //background setup
        SKSpriteNode *creditBackground = [SKSpriteNode spriteNodeWithImageNamed:@"LoseSceenBackground"];
        creditBackground.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        creditBackground.size = CGSizeMake(320, 568);
        [self addChild:creditBackground];

        //back button
        SKSpriteNode *menuButton = [SKSpriteNode spriteNodeWithImageNamed: @"BackButton"];
        menuButton.position = CGPointMake(CGRectGetMidX(self.frame) - 140, CGRectGetMidY(self.frame) - 225);
        menuButton.size = CGSizeMake(25, 65);
        [menuButton setName:@"backButtonNode"];
        [self addChild:menuButton];
    }

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"GameOver copy" withExtension:@"mp3"];

    //Setting up the background music -- Must init with URL of the start screen MP3
    self.loseConditionMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.loseConditionMusic.numberOfLoops = -1;
    [self.loseConditionMusic prepareToPlay];
    [self.loseConditionMusic play];

    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //user touch location - UI button interaction
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    [self.loseConditionMusic stop];

    //segue to main menu and game reset
    if ([node.name isEqualToString:@"restartButtonNode"])
    {
        MenuScene *menuScene = [MenuScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:menuScene transition:transition];
        [self.loseConditionMusic stop];
    }
}

@end
