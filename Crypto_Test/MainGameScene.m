//
//  MainGameScene.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "MainGameScene.h"
#import "KeyNode.h"
#import "RotorNode.h"
#import "TileNode.h"

@interface MainGameScene ()

@property NSNumber *levelScore;
@property NSString *deckLetter1;
@property NSString *deckLetter2;

@end

@implementation MainGameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
//        //background image
//        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"map"];
//        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//        [self addChild:background];

        self.levelScore = @100;
        [self randomTileSelection];

        //instances and positioning of keys
        KeyNode *keyNode1 = [KeyNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(25, 65)];
        keyNode1.position = CGPointMake(CGRectGetMidX(self.frame) - 100, CGRectGetMidY(self.frame) - 25);
        [self addChild:keyNode1];

        KeyNode *keyNode2 = [KeyNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(25, 65)];
        keyNode2.position = CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMidY(self.frame) - 175);
        [self addChild:keyNode2];

        KeyNode *keyNode3 = [KeyNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(25, 65)];
        keyNode3.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 25);
        [self addChild:keyNode3];

        KeyNode *keyNode4 = [KeyNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(25, 65)];
        keyNode4.position = CGPointMake(CGRectGetMidX(self.frame) + 50, CGRectGetMidY(self.frame) - 175);
        [self addChild:keyNode4];

        KeyNode *keyNode5 = [KeyNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(25, 65)];
        keyNode5.position = CGPointMake(CGRectGetMidX(self.frame) + 100, CGRectGetMidY(self.frame) - 25);
        [self addChild:keyNode5];

        //scoring tile nodes
        KeyNode *scoreNode1 = [KeyNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(25, 65)];
        scoreNode1.position = CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMidY(self.frame) + 100);
        [self addChild:scoreNode1];

        KeyNode *scoreNode2 = [KeyNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(25, 65)];
        scoreNode2.position = CGPointMake(CGRectGetMidX(self.frame) + 50, CGRectGetMidY(self.frame) + 100);
        [self addChild:scoreNode2];

        //tile deck nodes
        KeyNode *tileNode1 = [KeyNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(25, 65)];
        tileNode1.position = CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMidY(self.frame) - 25);
        [self addChild:tileNode1];

        //add label as child and use random tile letter generator to fill text
        SKLabelNode *tileLetterLabel1 = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        tileLetterLabel1.text = self.deckLetter1;
        tileLetterLabel1.fontColor = [UIColor blackColor];
        tileLetterLabel1.fontSize = 16;
        [tileNode1 addChild:tileLetterLabel1];

        KeyNode *tileNode2 = [KeyNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(25, 65)];
        tileNode2.position = CGPointMake(CGRectGetMidX(self.frame) + 50, CGRectGetMidY(self.frame) - 25);
        [self addChild:tileNode2];

        //add label as child and use random tile letter generator to fill text
        SKLabelNode *tileLetterLabel2 = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        tileLetterLabel2.text = self.deckLetter2;
        tileLetterLabel2.fontColor = [UIColor blackColor];
        tileLetterLabel2.fontSize = 16;
        [tileNode2 addChild:tileLetterLabel2];

        //rotor instance
        RotorNode *rotorNode = [RotorNode spriteNodeWithImageNamed:@"rotor"];
        rotorNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 235);
        [self addChild:rotorNode];

        //score label
        SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        scoreLabel.text = self.levelScore.description;
        scoreLabel.fontColor = [UIColor whiteColor];
        scoreLabel.fontSize = 16;
        scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame) + 140, CGRectGetMidY(self.frame) + 250);
        [self addChild:scoreLabel];

        //timer lable
        SKLabelNode *timerLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        timerLabel.text = self.levelScore.description;
        timerLabel.fontColor = [UIColor whiteColor];
        timerLabel.fontSize = 16;
        timerLabel.text = @"0:00";
        timerLabel.position = CGPointMake(CGRectGetMidX(self.frame) - 140, CGRectGetMidY(self.frame) + 250);
        [self addChild:timerLabel];
    }
    return self;
}

-(void)randomTileSelection
{
    //array of possible letters
    NSArray *letterArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];

    //2 random number generators, one for each tile deck
    int randomTileGenerator1 = arc4random_uniform(25);
    int randomTileGenerator2 = arc4random_uniform(25);

    //assign each random number to array - do this twice so we have a variable for each tile deck
    NSString *deckLetter1 = [letterArray objectAtIndex:randomTileGenerator1];
    NSString *deckLetter2 = [letterArray objectAtIndex:randomTileGenerator2];

    self.deckLetter1 = deckLetter1;
    self.deckLetter2 = deckLetter2;
}

@end
