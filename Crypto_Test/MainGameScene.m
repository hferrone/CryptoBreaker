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
#import "LoseConditionScene.h"

static NSString * const vowelString = @"vowel";
static NSString * const nonVowelString = @"nonVowel";

@interface MainGameScene () <UIAlertViewDelegate>

@property NSInteger levelScore;
@property NSInteger comboScore;
@property NSInteger initialCombo;
@property int selectedTileComboScore;
@property int destinationTileComboScore;
@property CGPoint positionInScene;
//@property (nonatomic, strong) SKSpriteNode *newTileNode;
@property (nonatomic, strong) SKSpriteNode *selectedNode;
@property (nonatomic, strong) SKSpriteNode *destinationNode;
@property (nonatomic, strong) SKSpriteNode *previousSelectedNode;
@property (nonatomic, strong) KeyNode *capNode1;
@property (nonatomic, strong) KeyNode *capNode2;
@property (nonatomic, strong) SKLabelNode *scoreLabel;
@property (nonatomic, strong) SKLabelNode *comboLabel;
@property (nonatomic, strong) SKLabelNode *timerLabel;
@property NSTimeInterval startTime;
@property BOOL gameStartTimer;
@property BOOL startGame;
@property BOOL hasCollidedAndScored;
@property BOOL hasComboed;
@property BOOL hasNewDestination;
@property BOOL isMovable;
@property NSMutableArray *tileSlotsArray;


@end

@implementation MainGameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        //[self randomTileSelection];
        self.levelScore = 0;
        self.gameStartTimer = NO;

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

        KeyNode *keyNode6 = [KeyNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(25, 65)];
        keyNode6.position = CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMidY(self.frame) - 55);
        [self addChild:keyNode6];

        KeyNode *keyNode7 = [KeyNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(25, 65)];
        keyNode7.position = CGPointMake(CGRectGetMidX(self.frame) + 50, CGRectGetMidY(self.frame) - 55);
        [self addChild:keyNode7];

        //back button
        SKSpriteNode *menuButton = [SKSpriteNode spriteNodeWithImageNamed: @"BackButton"];
        menuButton.position = CGPointMake(CGRectGetMidX(self.frame) - 125, CGRectGetMidY(self.frame) - 250);
        menuButton.size = CGSizeMake(65, 50);
        [menuButton setName:@"backButtonNode"];
        [self addChild:menuButton];

        [self generateNewTile];
        self.tileSlotsArray = [[NSMutableArray alloc] initWithObjects:keyNode1, keyNode2, keyNode3, keyNode4, keyNode5, keyNode6, keyNode7, nil];

        //scoring tile nodes
        self.capNode1 = [KeyNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(25, 65)];
        self.capNode1.position = CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMidY(self.frame) + 100);
        [self addChild:self.capNode1];

        self.capNode2 = [KeyNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(25, 65)];
        self.capNode2.position = CGPointMake(CGRectGetMidX(self.frame) + 50, CGRectGetMidY(self.frame) + 100);
        [self addChild:self.capNode2];

        //rotor instance
        RotorNode *rotorNode = [RotorNode rotorNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 235)];
        [self addChild:rotorNode];

        //timer lable
        self.timerLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        self.timerLabel.text = [NSString stringWithFormat:@"%d", self.levelScore];
        self.timerLabel.fontColor = [UIColor whiteColor];
        self.timerLabel.fontSize = 16;
        self.timerLabel.text = @"Ready";
        self.timerLabel.position = CGPointMake(CGRectGetMidX(self.frame) - 140, CGRectGetMidY(self.frame) + 250);
        [self addChild:self.timerLabel];

        //score label
        self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        self.scoreLabel.text = [NSString stringWithFormat: @"%d",self.levelScore];
        self.scoreLabel.fontColor = [UIColor whiteColor];
        self.scoreLabel.fontSize = 16;
        self.scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame) + 140, CGRectGetMidY(self.frame) + 250);
        [self addChild: self.scoreLabel];
    }
    return self;
}

#pragma tile selection methods

-(void)generateNewTile
{
    SKSpriteNode *nodeA = [SKSpriteNode spriteNodeWithImageNamed:@"A"];
    nodeA.name = vowelString;

    SKSpriteNode *nodeB = [SKSpriteNode spriteNodeWithImageNamed:@"B"];
    nodeB.name = nonVowelString;

    SKSpriteNode *nodeC = [SKSpriteNode spriteNodeWithImageNamed:@"C"];
    nodeC.name = nonVowelString;

    SKSpriteNode *nodeD = [SKSpriteNode spriteNodeWithImageNamed:@"D"];
    nodeD.name = nonVowelString;

    SKSpriteNode *nodeE = [SKSpriteNode spriteNodeWithImageNamed:@"E"];
    nodeE.name = vowelString;

    SKSpriteNode *nodeF = [SKSpriteNode spriteNodeWithImageNamed:@"F"];
    nodeF.name = nonVowelString;

    SKSpriteNode *nodeG = [SKSpriteNode spriteNodeWithImageNamed:@"G"];
    nodeG.name = nonVowelString;

    SKSpriteNode *nodeH = [SKSpriteNode spriteNodeWithImageNamed:@"H"];
    nodeH.name = nonVowelString;

    SKSpriteNode *nodeI = [SKSpriteNode spriteNodeWithImageNamed:@"I"];
    nodeI.name = vowelString;

    SKSpriteNode *nodeO = [SKSpriteNode spriteNodeWithImageNamed:@"O"];
    nodeO.name = vowelString;

    SKSpriteNode *nodeU= [SKSpriteNode spriteNodeWithImageNamed:@"U"];
    nodeU.name = vowelString;

    SKSpriteNode *nodeY = [SKSpriteNode spriteNodeWithImageNamed:@"Y"];
    nodeY.name = vowelString;

    NSArray *tileImagesArray = @[nodeA, nodeB, nodeC, nodeD, nodeE, nodeF, nodeG, nodeH, nodeI, nodeO, nodeU, nodeY];
    int randomTileGenerator = arc4random_uniform(11);

    self.initialCombo = 1;
    CGPoint position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 230);
    TileNode *tileNode1 = [TileNode tileNodeAtPosition:position tileComboScore:self.comboScore tileArray:tileImagesArray randomNumber:randomTileGenerator initialCombo:self.initialCombo];
    self.isMovable = YES;

    [self addChild:tileNode1];
}

- (void) incorrectDragByUser
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"HALT!" message:@"A good cryptologist knows when to pair keys. Try combining a vowel with a consonant." delegate:self cancelButtonTitle:@"Return" otherButtonTitles:@"Quit", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex)
    {
        _selectedNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 230);
    }
}

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

    //Timer logic.
    for (UITouch *touch in touches){
        CGPoint location = [touch locationInNode:_selectedNode];
        if (CGRectContainsPoint(self.frame, location)){
            self.startGame = YES;
            self.gameStartTimer = YES;
        }
    }

    CGPoint positionInScene = [touch locationInNode:self];
    [self selectNodeForTouch:positionInScene];

    if ([node.name isEqualToString:@"backButton"])
    {
        MenuScene *menuScene = [MenuScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:menuScene transition:transition];
    }
}

-(void)update:(NSTimeInterval)currentTime
{
    if (self.startGame){
        self.startTime = currentTime;
        self.startGame = NO;
    }
    int countDownInt = 10.0 - (int)(currentTime - self.startTime);

    if (self.gameStartTimer) {
        if (countDownInt>0){
            self.timerLabel.text = [NSString stringWithFormat:@"%i", countDownInt];
        }else if (countDownInt == 0) {
            self.timerLabel.text = [NSString stringWithFormat:@"%@", @"TIME"];
            LoseConditionScene *loseScene = [LoseConditionScene sceneWithSize:self.frame.size];
            SKTransition *transition = [SKTransition fadeWithDuration:1.0];
            [self.view presentScene:loseScene transition:transition];
        }
    }
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

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint positionInScene = [touch locationInNode:self];
    self.positionInScene = positionInScene;
	CGPoint previousPosition = [touch previousLocationInNode:self];

	CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, positionInScene.y - previousPosition.y);

    for (SKSpriteNode *node in self.tileSlotsArray)
    {
        _destinationNode = node;

        if (CGRectContainsPoint(_destinationNode.frame, positionInScene))
        {
            _selectedNode.position = _destinationNode.position;
            self.hasCollidedAndScored = YES;
            self.isMovable = NO;
        }

        if (CGRectContainsRect(_destinationNode.frame, _selectedNode.frame))
            {
                if (_destinationNode.name == _selectedNode.name)
                {
                    [self incorrectDragByUser];
                }else{
                    _selectedNode.position = _destinationNode.position;
                    self.hasComboed = YES;
                    self.isMovable = NO;
                }
            }
    }

	[self panForTranslation:translation];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.hasCollidedAndScored)
    {
        for (SKLabelNode *labelNode in _selectedNode.children)
        {
            self.comboScore++;
            self.selectedTileComboScore = self.comboScore;
            labelNode.text = [NSString stringWithFormat: @"%d",self.comboScore];
        }

        [self.tileSlotsArray addObject:_selectedNode];

        [self generateNewTile];
        [self updateScore];
        [self checkForCapPoint];

    }else{
        _selectedNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 230);
        self.isMovable = YES;
    }

    if (self.hasComboed)
    {
        for (SKLabelNode *labelNode in _destinationNode.children)
        {
            labelNode.text = [NSString stringWithFormat: @"%d",self.comboScore];
            self.comboScore = self.selectedTileComboScore + self.comboScore;
        }
    }

    self.hasCollidedAndScored = NO;
    self.isMovable = YES;
}

- (void)panForTranslation:(CGPoint)translation {
    CGPoint position = [_selectedNode position];
    if(self.isMovable) {
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    }
}

#pragma scoring methods

-(void)updateScore
{
    self.levelScore += 50;
    self.scoreLabel.text = [NSString stringWithFormat: @"%d",self.levelScore];

    //win condition and segue back to menu (resets game conditions)
    if (self.levelScore > 250)
    {
        WinConditionScene *menuScene = [WinConditionScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:menuScene transition:transition];
    }
}

-(void)checkForCapPoint
{
    if (self.comboScore >= 7)
    {
        [self.tileSlotsArray addObject:self.capNode1];
        [self.tileSlotsArray addObject:self.capNode2];
    }
}

@end
