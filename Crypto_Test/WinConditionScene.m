//
//  WinConditionScene.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/25/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "WinConditionScene.h"
#import "MenuScene.h"
#import <AVFoundation/AVFoundation.h>

@interface WinConditionScene ()

@property AVAudioPlayer *winConditionScene;
@property (strong, nonatomic) NSString *levelLocation;

@end

@implementation WinConditionScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.levelLocation = [defaults objectForKey:@"levelLocation"];

        //background setup
        SKSpriteNode *creditBackground = [SKSpriteNode spriteNodeWithImageNamed:@"WinSceneBackground"];
        creditBackground.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        creditBackground.size = CGSizeMake(320, 568);
        [self addChild:creditBackground];

        SKLabelNode *savedLocation = [SKLabelNode labelNodeWithFontNamed:@"times New Roman"];
        savedLocation.fontSize = 26;
        savedLocation.text = [NSString stringWithFormat:@"%@", self.levelLocation];
        savedLocation.fontColor = [UIColor blackColor];
        savedLocation.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:savedLocation];

        //back button
        SKSpriteNode *menuButton = [SKSpriteNode spriteNodeWithImageNamed: @"BackButton"];
        menuButton.position = CGPointMake(CGRectGetMidX(self.frame) - 140, CGRectGetMidY(self.frame) - 225);
        menuButton.size = CGSizeMake(25, 65);
        [menuButton setName:@"backButtonNode"];
        [self addChild:menuButton];

        NSURL *url = [[NSBundle mainBundle] URLForResource:@"Title" withExtension:@"mp3"];

        //Setting up the background music -- Must init with URL of the start screen MP3
        self.winConditionScene = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        self.winConditionScene.numberOfLoops = -1;
        [self.winConditionScene prepareToPlay];
        [self.winConditionScene play];
    }

    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //user touch location - UI button interaction
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

     //segue to main menu and game reset
    if ([node.name isEqualToString:@"backButtonNode"])
    {
        [self.winConditionScene stop];
        MenuScene *menuScene = [MenuScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:menuScene transition:transition];
        [self.winConditionScene stop];
    }
}

@end
