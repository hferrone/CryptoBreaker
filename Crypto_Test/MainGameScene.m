//
//  MainGameScene.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "MainGameScene.h"
#import "MenuScene.h"
#import "KeyNode.h"
#import "RotorNode.h"
#import "TileNode.h"
#import "WinConditionScene.h"

static NSString * const tileNodeName = @"movable";
static NSString * const vowelString = @"vowel";
static NSString * const nonVowelString = @"nonVowel";


@interface MainGameScene ()

@property NSInteger levelScore;
@property NSInteger comboScore;
@property NSString *deckLetter1;
@property NSString *deckLetter2;
@property (nonatomic, strong) SKSpriteNode *selectedNode;
@property (nonatomic, strong) SKSpriteNode *destinationNode;
@property (nonatomic, strong) SKLabelNode *scoreLabel;
@property BOOL hasCollidedAndScored;
@property NSArray *tileSlotsArray;

@end

@implementation MainGameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
//        //background image
//        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"map"];
//        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//        [self addChild:background];

        //[self randomTileSelection];
        self.levelScore = 0;
        self.comboScore = 1;
        [self generateNewTile];

        //instances and positioning of keys
        KeyNode *keyNode1 = [KeyNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(25, 65)];
        keyNode1.position = CGPointMake(CGRectGetMidX(self.frame) - 100, CGRectGetMidY(self.frame) - 55);
        [self addChild:keyNode1];

        KeyNode *keyNode2 = [KeyNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(25, 65)];
        keyNode2.position = CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMidY(self.frame) - 205);
        [self addChild:keyNode2];

        KeyNode *keyNode3 = [KeyNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(25, 65)];
        keyNode3.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 55);
        [self addChild:keyNode3];

        KeyNode *keyNode4 = [KeyNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(25, 65)];
        keyNode4.position = CGPointMake(CGRectGetMidX(self.frame) + 50, CGRectGetMidY(self.frame) - 205);
        [self addChild:keyNode4];

        KeyNode *keyNode5 = [KeyNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(25, 65)];
        keyNode5.position = CGPointMake(CGRectGetMidX(self.frame) + 100, CGRectGetMidY(self.frame) - 55);
        [self addChild:keyNode5];

        self.tileSlotsArray = @[keyNode1, keyNode2, keyNode3, keyNode4, keyNode5];

        //scoring tile nodes
        KeyNode *scoreNode1 = [KeyNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(25, 65)];
        scoreNode1.position = CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMidY(self.frame) + 100);
        [self addChild:scoreNode1];

        KeyNode *scoreNode2 = [KeyNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(25, 65)];
        scoreNode2.position = CGPointMake(CGRectGetMidX(self.frame) + 50, CGRectGetMidY(self.frame) + 100);
        [self addChild:scoreNode2];

        //rotor instance
        RotorNode *rotorNode = [RotorNode spriteNodeWithImageNamed:@"rotor"];
        rotorNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 235);
        [self addChild:rotorNode];

        //timer lable
        SKLabelNode *timerLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        timerLabel.text = [NSString stringWithFormat:@"%d", self.levelScore];
        timerLabel.fontColor = [UIColor whiteColor];
        timerLabel.fontSize = 16;
        timerLabel.text = @"0:00";
        timerLabel.position = CGPointMake(CGRectGetMidX(self.frame) - 140, CGRectGetMidY(self.frame) + 250);
        [self addChild:timerLabel];

        //score label
        self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        self.scoreLabel.text = [NSString stringWithFormat: @"%d",self.levelScore];
        self.scoreLabel.fontColor = [UIColor whiteColor];
        self.scoreLabel.fontSize = 16;
        self.scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame) + 140, CGRectGetMidY(self.frame) + 250);
        [self addChild: self.scoreLabel];

//        //back button
//        SKSpriteNode *menuButton = [SKSpriteNode spriteNodeWithImageNamed: @"backButton"];
//        menuButton.position = CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMidY(self.frame) - 50);
//        [menuButton setName:@"backButtonNode"];
//        [self addChild:menuButton];
    }
    return self;
}

#pragma tile selection methods

-(void)generateNewTile
{
    KeyNode *tileNode1 = [KeyNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(23, 63)];
    tileNode1.position = CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMidY(self.frame) - 55);
    [tileNode1 setName:tileNodeName];
    [self addChild:tileNode1];

    self.comboScore = 1;
    SKLabelNode *comboLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    comboLabel.fontColor = [UIColor whiteColor];
    comboLabel.text = [NSString stringWithFormat: @"%d",self.comboScore];
    comboLabel.fontSize = 12;
    comboLabel.position = CGPointMake(5, 5);
    [tileNode1 addChild:comboLabel];

    KeyNode *tileNode2 = [KeyNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(23, 63)];
    tileNode2.position = CGPointMake(CGRectGetMidX(self.frame) + 50, CGRectGetMidY(self.frame) - 55);
    [tileNode2 setName:tileNodeName];
    [self addChild:tileNode2];
}

//-(void)randomTileSelection
//{
//    //array of possible letters
//    NSArray *letterArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
//
//    //2 random number generators, one for each tile deck
//    int randomTileGenerator1 = arc4random_uniform(25);
//    int randomTileGenerator2 = arc4random_uniform(25);
//
//    //assign each random number to array - do this twice so we have a variable for each tile deck
//    NSString *deckLetter1 = [letterArray objectAtIndex:randomTileGenerator1];
//    NSString *deckLetter2 = [letterArray objectAtIndex:randomTileGenerator2];
//
//    self.deckLetter1 = deckLetter1;
//    self.deckLetter2 = deckLetter2;

//    NSArray *array = @[[SKSpriteNode spriteNodeWithImageNamed:@"key"].name = vowelString];
//}

#pragma dragging and dropping methods

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

    CGPoint positionInScene = [touch locationInNode:self];
    [self selectNodeForTouch:positionInScene];
}

- (void)selectNodeForTouch:(CGPoint)touchLocation
{
    //1
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];

    //2
	if(![_selectedNode isEqual:touchedNode])
    {
		[_selectedNode removeAllActions];
		[_selectedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];

		_selectedNode = touchedNode;
	}
    
}

float degToRad(float degree) {
	return degree / 180.0f * M_PI;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint positionInScene = [touch locationInNode:self];
	CGPoint previousPosition = [touch previousLocationInNode:self];

	CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, positionInScene.y - previousPosition.y);

    for (SKSpriteNode *node in self.tileSlotsArray)
    {
        _destinationNode = node;

        if (CGRectContainsPoint(_destinationNode.frame, positionInScene))
        {
            [_selectedNode setName:@"notMovable"];
            _selectedNode.position = _destinationNode.position;
            self.hasCollidedAndScored = YES;
        }
    }

	[self panForTranslation:translation];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self updateScore];
    [self generateNewTile];
}

- (void)panForTranslation:(CGPoint)translation {
    CGPoint position = [_selectedNode position];
    if([[_selectedNode name] isEqualToString:tileNodeName]) {
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    }
}

#pragma scoring methods

-(void)updateScore
{
    self.levelScore += 50;
    self.scoreLabel.text = [NSString stringWithFormat: @"%d",self.levelScore];

    //only increment child comboLabel for the selected tile

    //win condition and segue back to menu (resets game conditions)
    if (self.levelScore > 250)
    {
        WinConditionScene *menuScene = [WinConditionScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:menuScene transition:transition];
    }
}

@end
