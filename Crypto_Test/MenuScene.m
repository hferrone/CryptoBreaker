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
        NSArray *titleMenuButtons = @[@"New Game", @"Options", @"Profile", @"Credits"];
        NSArray *menuButtonTags = @[@"credits", @"profile", @"options", @"newGame"];
        for (int i = 0; i < titleMenuButtons.count; i++)
        {
            NSString *imageName = [titleMenuButtons objectAtIndex:i];
            NSString *imageTag = [menuButtonTags objectAtIndex:i];
            SKSpriteNode *menuButton = [SKSpriteNode spriteNodeWithImageNamed: imageName];
            [menuButton setName:imageTag];

            float offsetFraction = ((float)(i + 1)) / ([titleMenuButtons count] + 1);
            [menuButton setPosition:CGPointMake(CGRectGetMidX(self.frame) - 75, size.height * offsetFraction)];
            [self addChild:menuButton];
        }

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

    if ([node.name isEqualToString:@"newGame"])
    {
        MainGameScene *mainGameScene = [MainGameScene sceneWithSize:self.frame.size];
        SKTransition *transition =[SKTransition fadeWithDuration:1.0];
        [self.view presentScene:mainGameScene transition:transition];
    }
}

@end
