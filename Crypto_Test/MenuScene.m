//
//  MenuScene.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/23/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "MenuScene.h"
#import "TutorialScene1.h"
#import "StoryScene.h"
#import <AVFoundation/AVFoundation.h>

@interface MenuScene ()
@property (nonatomic) SKAction *pressStartSFX;
@property (nonatomic) AVAudioPlayer *titleMusic;


@end

@implementation MenuScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        //background setup
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"MenuScreenBackground"];
        background.size = CGSizeMake(320, 568);
        background.color = [UIColor blackColor];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];

        //new game UI button
        SKSpriteNode *newGameButton = [SKSpriteNode spriteNodeWithImageNamed: @"NewGameButton"];
        newGameButton.size = CGSizeMake(85, 65);
        [newGameButton setName:@"newGame"];
        [newGameButton setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 25)];
        [self addChild:newGameButton];
        //We don't want our action to wait until the entire sound file is played.
        //self.pressStartSFX = [SKAction playSoundFileNamed:@"" waitForCompletion:NO];

        //profile UI button
        SKSpriteNode *tutorialButton = [SKSpriteNode spriteNodeWithImageNamed: @"TutorialButton"];
        tutorialButton.size = CGSizeMake(85, 65);
        [tutorialButton setName:@"tutorial"];
        [tutorialButton setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 150)];
        [self addChild:tutorialButton];

        NSURL *url = [[NSBundle mainBundle] URLForResource:@"Victory Fanfare" withExtension:@"mp3"];
        self.titleMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        self.titleMusic.numberOfLoops = -1;
        [self.titleMusic prepareToPlay];
        [self.titleMusic play];

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
        [self.titleMusic stop];
        StoryScene *storyScene = [StoryScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:0.5];
        [self.view presentScene:storyScene transition:transition];
    }else if ([node.name isEqualToString:@"tutorial"]){
        TutorialScene1 *tutorial1 = [TutorialScene1 sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:0.5];
        [self.view presentScene:tutorial1 transition:transition];
    }
}

@end
