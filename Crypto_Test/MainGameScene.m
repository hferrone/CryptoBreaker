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
#import "Utilities.h"
#import "PauseButtonNode.h"
#import <AVFoundation/AVFoundation.h>

//global constant variables
static NSString * const vowelString = @"vowel";
static NSString * const nonVowelString = @"nonVowel";

@interface MainGameScene () <UIAlertViewDelegate>

@property NSInteger levelScore;
@property NSInteger comboScore;
@property NSInteger initialCombo;
@property NSInteger selectedTileComboScore;
@property NSInteger destinationTileComboScore;

@property CGPoint positionInScene;

@property (nonatomic, strong) TileNode *selectedNode;
@property (nonatomic, strong) SKSpriteNode *destinationNode;
@property (nonatomic, strong) SKSpriteNode *previousSelectedNode;

@property (nonatomic, strong) RotorNode *rotorCapNode;

@property (nonatomic, strong) SKLabelNode *scoreLabel;
@property (nonatomic, strong) SKLabelNode *comboLabel;
@property (nonatomic, strong) SKLabelNode *timerLabel;
@property (nonatomic) AVAudioPlayer *backgroundMusic;
@property UIImageView *pauseView;

@property NSTimeInterval startTime;

@property BOOL gameStartTimer;
@property BOOL startGame;
@property BOOL hasCollidedAndScored;
@property BOOL hasMissedContact;
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
        KeyNode *keyNode1 = [KeyNode keyNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame) - 100, CGRectGetMidY(self.frame) - 15)];
        [self addChild:keyNode1];

        KeyNode *keyNode2 = [KeyNode keyNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMidY(self.frame) - 155)];
        [self addChild:keyNode2];

        KeyNode *keyNode3 = [KeyNode keyNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 15)];
        [self addChild:keyNode3];

        KeyNode *keyNode4 = [KeyNode keyNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame) + 50, CGRectGetMidY(self.frame) - 155)];
        [self addChild:keyNode4];

        KeyNode *keyNode5 = [KeyNode keyNodeAtPosition: CGPointMake(CGRectGetMidX(self.frame) + 100, CGRectGetMidY(self.frame) - 15)];
        [self addChild:keyNode5];

        KeyNode *keyNode6 = [KeyNode keyNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMidY(self.frame) + 105)];
        [self addChild:keyNode6];

        KeyNode *keyNode7 = [KeyNode keyNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame) + 50, CGRectGetMidY(self.frame) + 105)];
        [self addChild:keyNode7];

        //back button
        SKSpriteNode *menuButton = [SKSpriteNode spriteNodeWithImageNamed: @"BackButton"];
        menuButton.position = CGPointMake(CGRectGetMidX(self.frame) - 125, CGRectGetMidY(self.frame) - 250);
        menuButton.size = CGSizeMake(65, 50);
        [menuButton setName:@"backButtonNode"];
        [self addChild:menuButton];

        [self generateNewTile];

        //timer lable
        self.timerLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        self.timerLabel.text = [NSString stringWithFormat:@"%d", self.levelScore];
        self.timerLabel.fontColor = [UIColor whiteColor];
        self.timerLabel.fontSize = 16;
        self.timerLabel.text = @"Ready";
        self.timerLabel.position = CGPointMake(CGRectGetMidX(self.frame) - 125, CGRectGetMidY(self.frame) + 250);
        [self addChild:self.timerLabel];

        PauseButtonNode *pauseButton = [PauseButtonNode pauseButtonLocation:CGPointMake(CGRectGetMidX(self.frame) + 125, CGRectGetMidX(self.frame) - 150)];
        [self addChild:pauseButton];

        //score label
        self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        self.scoreLabel.text = [NSString stringWithFormat: @"%d",self.levelScore];
        self.scoreLabel.fontColor = [UIColor whiteColor];
        self.scoreLabel.fontSize = 16;
        self.scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame) + 140, CGRectGetMidY(self.frame) + 250);
        [self addChild: self.scoreLabel];

        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;

        NSURL *url = [[NSBundle mainBundle] URLForResource:@"StartScreen" withExtension:@"mp3"];

        //Setting up the background music -- Must init with URL of the start screen MP3
        self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        self.backgroundMusic.numberOfLoops = -1;
        [self.backgroundMusic prepareToPlay];
    }
    return self;
}
//Basically the viewDidLoad of the View Controller.


#pragma tile selection methods

-(void)generateNewTile
{
    TileNode *nodeA = [TileNode spriteNodeWithImageNamed:@"A"];
    nodeA.name = vowelString;

    TileNode *nodeB = [TileNode spriteNodeWithImageNamed:@"B"];
    nodeB.name = nonVowelString;

    TileNode *nodeC = [TileNode spriteNodeWithImageNamed:@"C"];
    nodeC.name = nonVowelString;

    TileNode *nodeD = [TileNode spriteNodeWithImageNamed:@"D"];
    nodeD.name = nonVowelString;

    TileNode *nodeE = [TileNode spriteNodeWithImageNamed:@"E"];
    nodeE.name = vowelString;

    TileNode *nodeF = [TileNode spriteNodeWithImageNamed:@"F"];
    nodeF.name = nonVowelString;

    TileNode *nodeG = [TileNode spriteNodeWithImageNamed:@"G"];
    nodeG.name = nonVowelString;

    TileNode *nodeH = [TileNode spriteNodeWithImageNamed:@"H"];
    nodeH.name = nonVowelString;

    TileNode *nodeI = [TileNode spriteNodeWithImageNamed:@"I"];
    nodeI.name = vowelString;

    TileNode *nodeO = [TileNode spriteNodeWithImageNamed:@"O"];
    nodeO.name = vowelString;

    TileNode *nodeU= [TileNode spriteNodeWithImageNamed:@"U"];
    nodeU.name = vowelString;

    TileNode *nodeY = [TileNode spriteNodeWithImageNamed:@"Y"];
    nodeY.name = vowelString;

    NSArray *tileImagesArray = @[nodeA, nodeB, nodeC, nodeD, nodeE, nodeF, nodeG, nodeH, nodeI, nodeO, nodeU, nodeY];
    int randomTileGenerator = arc4random_uniform(11);

    self.initialCombo = 1;
    CGPoint position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 180);

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
        _selectedNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 155);
    }
}

#pragma dragging and dropping methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    [self touchInPauseButton:location];

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
    int countDownInt = 30.0 - (int)(currentTime - self.startTime);

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
    TileNode *touchedNode = (TileNode *)[self nodeAtPoint:touchLocation];

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

	[self panForTranslation:translation];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.hasCollidedAndScored)
    {
        [self generateNewTile];
        [self updateScore];
        [self updateComboScore];
        [self checkForCapPoint:self.selectedTileComboScore];
        [self setSelectedNodePositionToDestination];
    }

    if (self.hasMissedContact)
    {
        [self resetSelectedNodePositionToOrigin];
    }
}

-(void)setSelectedNodePositionToDestination
{
    _selectedNode.position = _destinationNode.position;
    self.hasCollidedAndScored = NO;
}

-(void)resetSelectedNodePositionToOrigin
{
    _selectedNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 230);
    self.hasMissedContact = NO;
}

-(void)didSimulatePhysics
{
    [super didSimulatePhysics];

}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *tileObject, *secondObject;

    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        tileObject = contact.bodyA;
        secondObject = contact.bodyB;
    }else {
        tileObject = contact.bodyB;
        secondObject = contact.bodyA;
    }

    //Condition for tile and key contact
    if (tileObject.categoryBitMask == ContactCategoryTile  && secondObject.categoryBitMask == ContactCategoryKey)
    {
        _selectedNode = (TileNode*)tileObject.node;
        _destinationNode = (KeyNode*)secondObject.node;
        self.hasCollidedAndScored = YES;

        if ([_destinationNode isKindOfClass:[TileNode class]])
        {
            [_destinationNode removeFromParent];
        }
    }
    //condition for tile and tile contact
    else if (tileObject.categoryBitMask == ContactCategoryTile && tileObject.categoryBitMask == ContactCategoryTile)
    {
        _selectedNode = (TileNode*)tileObject.node;
        _destinationNode = (TileNode*)secondObject.node;

        if ((_selectedNode.name == _destinationNode.name) && ![_destinationNode isKindOfClass:[KeyNode class]])
        {
            [self incorrectDragByUser];
        }
        else {
            self.hasCollidedAndScored = YES;

            [_selectedNode removeFromParent];
        }
    }
    //condition for tile and rotor contact
    else if(tileObject.categoryBitMask == ContactCategoryTile && secondObject.categoryBitMask == ContactCategoryRotor)
    {
        _selectedNode = (TileNode*)tileObject.node;
        [self checkForCapPoint:[_selectedNode.comboLabel.text intValue]];
    }
    else {
        _selectedNode = (TileNode*)tileObject.node;
        _destinationNode = (KeyNode*)secondObject.node;
        self.hasMissedContact = YES;
    }
}

//-(void)checkForTileCollision
//{
//    for (SKSpriteNode *node in self.tileSlotsArray)
//    {
//        _destinationNode = node;
//
//        if (CGRectContainsPoint(_destinationNode.frame, self.positionInScene))
//        {
//            _selectedNode.position = _destinationNode.position;
//            self.hasCollidedAndScored = YES;
//            self.isMovable = NO;
//        }
//
//        if (CGRectContainsRect(_destinationNode.frame, _selectedNode.frame))
//        {
//            if (_destinationNode.name == _selectedNode.name)
//            {
//                [self incorrectDragByUser];
//            }else{
//                _selectedNode.position = _destinationNode.position;
//                self.hasComboed = YES;
//                self.isMovable = NO;
//                [_destinationNode removeFromParent];
//            }
//        }
//    }
//}
//
//-(void)checkForCombo
//{
//    if (self.hasCollidedAndScored)
//    {
//        TileNode *tileNode = (TileNode*)_selectedNode;
//        self.selectedTileComboScore = [tileNode.comboLabel.text intValue];
//        self.selectedTileComboScore++;
//        tileNode.comboLabel.text = [NSString stringWithFormat: @"%d",self.selectedTileComboScore];
//
//        [self.tileSlotsArray addObject:_selectedNode];
//
//        [self generateNewTile];
//        [self updateScore];
//        [self checkForCapPoint:self.selectedTileComboScore];
//
//    }else{
//        _selectedNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 230);
//        self.isMovable = YES;
//    }
//
//    if (self.hasComboed)
//    {
//        TileNode *tileNode = (TileNode*)_selectedNode;
//        self.selectedTileComboScore = [tileNode.comboLabel.text intValue];
//
//        for (SKLabelNode *labelNode in _destinationNode.children)
//        {
//            self.destinationTileComboScore = [labelNode.text intValue];
//            self.comboScore = self.destinationTileComboScore + self.selectedTileComboScore;
//            tileNode.comboLabel.text = [NSString stringWithFormat: @"%d",self.comboScore];
//        }
//    }
//
//    self.hasCollidedAndScored = NO;
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self checkForTileCollision];
//    [self checkForCombo];
//}

- (void)panForTranslation:(CGPoint)translation
{
    CGPoint position = [_selectedNode position];
    if(self.isMovable && [_selectedNode isKindOfClass:[TileNode class]]) {
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    }
}

#pragma scoring methods

-(void)updateScore
{
    self.levelScore += 50;
    self.scoreLabel.text = [NSString stringWithFormat: @"%d",self.levelScore];

    //win condition and segue back to menu (resets game conditions)
    if (self.levelScore > 1000)
    {
        WinConditionScene *menuScene = [WinConditionScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:menuScene transition:transition];
    }
}

-(void)updateComboScore
{
    self.selectedTileComboScore = [_selectedNode.comboLabel.text intValue];
    self.comboScore = self.selectedTileComboScore;
    self.comboScore++;
    _selectedNode.comboLabel.text = [NSString stringWithFormat: @"%d",self.comboScore];
}

-(void)checkForCapPoint:(NSInteger)tileCombo
{
    if (tileCombo >= 7)
    {
        [self executeRotorAnimationForward];
    }
}

-(void)executeRotorAnimationForward
{
    //rotor instance
    RotorNode *rotorCapNode = [RotorNode rotorNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame
                                                                                                                  ))];
    rotorCapNode = [RotorNode spriteNodeWithImageNamed:@"rotor1"];
    [self addChild:rotorCapNode];

    NSArray *rotorAnimationArray = @[[SKTexture textureWithImageNamed:@"rotor1"],
                                     [SKTexture textureWithImageNamed:@"rotor2"],
                                     [SKTexture textureWithImageNamed:@"rotor3"],
                                     [SKTexture textureWithImageNamed:@"rotor4"]];
    SKAction *rotorAnimation = [SKAction animateWithTextures:rotorAnimationArray timePerFrame:0.05];
    SKAction *animationRepeat = [SKAction repeatAction:rotorAnimation count:1];
    [rotorCapNode runAction:animationRepeat];
}

//-(void)executeRotorAnimationBackward
//{
//    //rotor instance
//    RotorNode *rotorCapNode = [RotorNode rotorNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 225)];
//    rotorCapNode = [RotorNode spriteNodeWithImageNamed:@"rotor1"];
//    [self addChild:self.rotorCapNode];
//
//    NSArray *rotorAnimationArray = @[[SKTexture textureWithImageNamed:@"rotor4"],
//                                     [SKTexture textureWithImageNamed:@"rotor3"],
//                                     [SKTexture textureWithImageNamed:@"rotor2"],
//                                     [SKTexture textureWithImageNamed:@"rotor1"]];
//
//    SKAction *rotorAnimation = [SKAction animateWithTextures:rotorAnimationArray timePerFrame:0.05];
//    SKAction *animationRepeat = [SKAction repeatAction:rotorAnimation count:1];
//    [self.rotorCapNode runAction:animationRepeat];
//}

#pragma Pause Logic

-(void)didMoveToView:(SKView *)view
{
    UIImage *pauseImage = [UIImage imageNamed:@"pause.png"];
    self.pauseView = [[UIImageView alloc]initWithImage:pauseImage];
    self.pauseView.hidden = NO;
    self.pauseView.center = CGPointMake(self.size.width*0.5, self.size.height*0.5);
    [self.view addSubview:self.pauseView];

    [self.backgroundMusic play];
}

- (BOOL)touchInPauseButton:(CGPoint)touchLocation
{
    if (self.view.paused) {
        self.view.paused = NO;
        return NO;
    }
    if (CGRectContainsPoint([self childNodeWithName:@"pauseButton"].frame, touchLocation)) {
        [self pauseToggle];
        return true;
    }
    return false;
}

-(void)pauseToggle
{
    SKView *view = (SKView*)self.view;
    view.paused = (view.paused) ? NO : YES;
    NSLog(@"view is %hhd",view.paused);
}



@end
