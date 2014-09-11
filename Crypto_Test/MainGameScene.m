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
@property NSInteger breakCountdown;
@property NSInteger randomTime;

@property CGPoint positionInScene;
@property (nonatomic) SKAction *tileLock;
@property (nonatomic) SKAction *tileLockSFX;

@property int contactCounter;
@property int contactTimer;

@property NSString *levelLocation;


@property (nonatomic, strong) SKSpriteNode *countDownSpriteNode;
@property (nonatomic, strong) SKLabelNode *countDownLabelNode;

@property (nonatomic, strong) KeyNode *blankTileNode;

@property (nonatomic, strong) TileNode *selectedNode;
@property (nonatomic, strong) TileNode *destinationNode;
@property (nonatomic, strong) TileNode *generatedTile;

//@property (nonatomic, strong) RotorNode *rotorDestinationNode;
@property (nonatomic, strong) RotorNode *rotorAnimationNode;

@property (nonatomic, strong) SKLabelNode *scoreLabel;
@property (nonatomic, strong) SKLabelNode *comboLabel;
@property (nonatomic, strong) SKLabelNode *timerLabel;

@property (nonatomic) AVAudioPlayer *backgroundMusic;

@property UIImageView *pauseView;

@property NSTimeInterval startTime;
@property BOOL gameStartTimer;
@property BOOL startGame;
@property BOOL hasCollidedAndScored;
@property BOOL hasComboed;
@property BOOL hasScoredWithRotor;
@property BOOL hasMissedContact;
@property BOOL hasIncorrectDrag;
@property BOOL hasNewDestination;
@property BOOL isMovable;
@property BOOL hasEnteredTile;

@property NSMutableArray *tileSlotsArray;

@end

@implementation MainGameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        //[self randomTileSelection];
        self.levelScore = 0;
        self.gameStartTimer = NO;
        self.contactCounter = 0;
        self.contactTimer = 0;

        //background setup
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"MainGameSceneBackground"];
        background.size = CGSizeMake(320, 568);
        background.color = [UIColor blackColor];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];

        //instances and positioning of keys
        KeyNode *keyNode1 = [KeyNode keyNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame) - 120, CGRectGetMidY(self.frame))];
        [self addChild:keyNode1];

        KeyNode *keyNode2 = [KeyNode keyNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame) - 80, CGRectGetMidY(self.frame))];
        [self addChild:keyNode2];

        KeyNode *keyNode3 = [KeyNode keyNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame) - 40, CGRectGetMidY(self.frame))];
        [self addChild:keyNode3];

        KeyNode *keyNode4 = [KeyNode keyNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
        [self addChild:keyNode4];

        KeyNode *keyNode5 = [KeyNode keyNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame) + 40, CGRectGetMidY(self.frame))];
        [self addChild:keyNode5];

        KeyNode *keyNode6 = [KeyNode keyNodeAtPosition: CGPointMake(CGRectGetMidX(self.frame) + 80, CGRectGetMidY(self.frame))];
        [self addChild:keyNode6];

        KeyNode *keyNode7 = [KeyNode keyNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame) + 120, CGRectGetMidY(self.frame))];
        [self addChild:keyNode7];

        //back button
        SKSpriteNode *menuButton = [SKSpriteNode spriteNodeWithImageNamed: @"BackButton"];
        menuButton.position = CGPointMake(CGRectGetMidX(self.frame) - 140, CGRectGetMidY(self.frame) - 225);
        menuButton.size = CGSizeMake(25, 65);
        [menuButton setName:@"backButtonNode"];
        [self addChild:menuButton];

        [self generateNewTile];
        [self generateLocationCodeAndDifficulty];

        //timer lable
        self.timerLabel = [SKLabelNode labelNodeWithFontNamed:@"Times New Roman"];
        self.timerLabel.text = [NSString stringWithFormat:@"%ld", (long)self.levelScore];
        self.timerLabel.fontColor = [UIColor whiteColor];
        self.timerLabel.fontSize = 26;
        self.timerLabel.text = @"TIME";
        self.timerLabel.position = CGPointMake(CGRectGetMidX(self.frame) - 90, CGRectGetMidY(self.frame) - 235);
        [self addChild:self.timerLabel];

//        PauseButtonNode *pauseButton = [PauseButtonNode pauseButtonLocation:CGPointMake(CGRectGetMidX(self.frame) + 125, CGRectGetMidX(self.frame) - 150)];
//        [self addChild:pauseButton];

        //score label
        self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Times New Roman"];
        self.scoreLabel.text = [NSString stringWithFormat: @"Score: %d",self.levelScore];
        self.scoreLabel.fontColor = [UIColor whiteColor];
        self.scoreLabel.fontSize = 22;
        self.scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame) + 105, CGRectGetMidY(self.frame) + 250);
        [self addChild: self.scoreLabel];

        //code break countdown setup
        self.countDownLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Times New Roman"];
        self.countDownLabelNode.fontColor = [UIColor whiteColor];
        self.countDownLabelNode.fontSize = 22;
        self.countDownLabelNode.text = [NSString stringWithFormat:@"Breaks: %d", self.breakCountdown];
        self.countDownLabelNode.position = CGPointMake(CGRectGetMidX(self.frame) + 115, CGRectGetMidY(self.frame) + 200);
        self.countDownSpriteNode.name = @"Cat";
        [self addChild: self.countDownLabelNode];

        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;

        NSURL *url = [[NSBundle mainBundle] URLForResource:@"StartScreen" withExtension:@"mp3"];

        //Setting up the background music -- Must init with URL of the start screen MP3
        self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        self.backgroundMusic.numberOfLoops = -1;
        [self.backgroundMusic prepareToPlay];
        [self.backgroundMusic play];

        //Setting up Sound SFX
        self.tileLockSFX = [SKAction playSoundFileNamed:@"export2.caf" waitForCompletion:NO];

    }
    return self;
}

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

    TileNode *nodeJ = [TileNode spriteNodeWithImageNamed:@"J"];
    nodeJ.name = nonVowelString;

    TileNode *nodeK = [TileNode spriteNodeWithImageNamed:@"K"];
    nodeK.name = nonVowelString;

    TileNode *nodeL = [TileNode spriteNodeWithImageNamed:@"L"];
    nodeL.name = nonVowelString;

    TileNode *nodeM = [TileNode spriteNodeWithImageNamed:@"M"];
    nodeM.name = nonVowelString;

    TileNode *nodeN = [TileNode spriteNodeWithImageNamed:@"N"];
    nodeN.name = nonVowelString;

    TileNode *nodeO = [TileNode spriteNodeWithImageNamed:@"O"];
    nodeO.name = vowelString;

    TileNode *nodeP = [TileNode spriteNodeWithImageNamed:@"P"];
    nodeP.name = nonVowelString;

    TileNode *nodeQ = [TileNode spriteNodeWithImageNamed:@"Q"];
    nodeQ.name = nonVowelString;

    TileNode *nodeR = [TileNode spriteNodeWithImageNamed:@"R"];
    nodeR.name = nonVowelString;

    TileNode *nodeS = [TileNode spriteNodeWithImageNamed:@"S"];
    nodeS.name = nonVowelString;

    TileNode *nodeT = [TileNode spriteNodeWithImageNamed:@"T"];
    nodeT.name = nonVowelString;

    TileNode *nodeU= [TileNode spriteNodeWithImageNamed:@"U"];
    nodeU.name = vowelString;

    TileNode *nodeV = [TileNode spriteNodeWithImageNamed:@"V"];
    nodeV.name = nonVowelString;

    TileNode *nodeW = [TileNode spriteNodeWithImageNamed:@"W"];
    nodeW.name = nonVowelString;

    TileNode *nodeX = [TileNode spriteNodeWithImageNamed:@"X"];
    nodeX.name = nonVowelString;

    TileNode *nodeY = [TileNode spriteNodeWithImageNamed:@"Y"];
    nodeY.name = vowelString;

    TileNode *nodeZ = [TileNode spriteNodeWithImageNamed:@"Z"];
    nodeZ.name = nonVowelString;

    NSArray *tileImagesArray = @[nodeA, nodeB, nodeC, nodeD, nodeE, nodeF, nodeG, nodeH, nodeI, nodeO, nodeU, nodeY];
    int randomTileGenerator = arc4random_uniform(11);

    self.initialCombo = 1;
    CGPoint position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 180);

    self.generatedTile = [TileNode tileNodeAtPosition:position tileComboScore:self.comboScore tileArray:tileImagesArray randomNumber:randomTileGenerator initialCombo:self.initialCombo];
    self.isMovable = YES;

    [self addChild:self.generatedTile];
}

-(void)generateLocationCodeAndDifficulty
{
    //randomely selecting location for each game
    NSArray *locationsArray = @[@"Paris, France", @"London, England", @"Frankfurt, Germany", @"Normandy, France", @"Berlin, Germany", @"Wielun, Poland", @"Belfast, Northern Ireland", @"Norwich, England", @"Alsace, France", @"Lorraine, France"];
    int randomLocationGenerator = arc4random_uniform(9);
    self.levelLocation = [locationsArray objectAtIndex:randomLocationGenerator];

    //randomely selecting difficulty (Break Count) for each game
    int randomBreakCount = arc4random_uniform(4) + 2;
    self.breakCountdown = randomBreakCount;

    //Randomely selecting timer time for each game
    int randomTime = arc4random_uniform(12) + 25;
    self.randomTime = randomTime;
}

-(void)incorrectDragByUser
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"HALT!" message:@"A good cryptologist knows when to pair keys. Try combining a vowel with a consonant." delegate:self cancelButtonTitle:@"Return" otherButtonTitles:@"Quit", nil];
    [alertView show];
}

//-(void)endGameCodeAlert
//{
//    NSString* messageString = [NSString stringWithFormat: @"You're recent break: %@", self.levelLocation];
//    UIAlertView * alertView2 = [[UIAlertView alloc] initWithTitle:@"BROKEN!" message: messageString delegate:self cancelButtonTitle:@"Return" otherButtonTitles:@"Quit", nil];
//    [alertView2 show];
//}

-(void)alertView:(UIAlertView *)alertView alert2:(UIAlertView*)alertView2 clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex)
    {
        _selectedNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 155);
    }
}

#pragma dragging and dropping methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _destinationNode = nil;

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
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:_selectedNode];
        if (CGRectContainsPoint(self.frame, location))
        {
            self.contactTimer++;
            if (self.contactTimer == 1)
            {
                self.startGame = YES;
                self.gameStartTimer = YES;
            }
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
    int countDownInt = self.randomTime - (int)(currentTime - self.startTime);

    if (self.gameStartTimer) {
        if (countDownInt > 10){
            self.timerLabel.text = [NSString stringWithFormat:@"0:%i", countDownInt];
        }else if(countDownInt < 10 && countDownInt > 0)
        {
            self.timerLabel.text = [NSString stringWithFormat:@"0:0%i", countDownInt];
        }
        else if (countDownInt == 0) {
            self.timerLabel.text = [NSString stringWithFormat:@"%@", @"TIME"];
            [self segueToLose];
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

#pragma End Contact Physics Behavior
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    if (!_selectedNode.hasFirstContact)
//    {
//        [self generateNewTile];
//        _selectedNode.hasFirstContact = YES;
//    }

    if(self.hasCollidedAndScored)
    {
        [self updateScore];
        [self updateComboScore];
        [self checkForCapPoint:self.selectedTileComboScore];
        [self setSelectedNodePositionToDestination];
        self.hasCollidedAndScored = NO;
    }

    if (self.hasComboed)
    {
        [self generateNewTile];
        self.hasComboed = NO;
    }

    if (self.hasScoredWithRotor)
    {
        self.breakCountdown--;
        self.countDownLabelNode.text = [NSString stringWithFormat:@"Breaks: %d", self.breakCountdown];
        [self generateNewTile];
        self.hasScoredWithRotor = NO;

        if (self.breakCountdown == 0)
        {
            [self segueToWin];
        }
    }

    if (self.hasIncorrectDrag)
    {
        [self incorrectDragByUser];
        self.hasIncorrectDrag = NO;
    }
}

-(void)setSelectedNodePositionToDestination
{
    _selectedNode.position = _blankTileNode.position;
    [self runAction:self.tileLockSFX];
    [self createNodeEmitter:_blankTileNode.position];
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    //Condition for tile and key contact
    if ((contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (ContactCategoryTile | ContactCategoryKey))
    {
        if (contact.bodyA.categoryBitMask == ContactCategoryTile)
        {
            _selectedNode = (TileNode*)contact.bodyA.node;
            _blankTileNode = (KeyNode*)contact.bodyB.node;
        }else{
            _selectedNode = (TileNode*)contact.bodyB.node;
            _blankTileNode = (KeyNode*)contact.bodyA.node;
        }

        self.contactCounter++;
        if (self.contactCounter == 1)
        {
            [self generateNewTile];
        }
        self.hasCollidedAndScored = YES;
    }
    //condition for tile and tile contact
    else if (contact.bodyA.categoryBitMask == contact.bodyB.categoryBitMask)
    {
        if (contact.bodyA.categoryBitMask == ContactCategoryTile)
        {
            _selectedNode = (TileNode*)contact.bodyA.node;
            _destinationNode = (TileNode*)contact.bodyB.node;
        }else{
            _selectedNode = (TileNode*)contact.bodyB.node;
            _destinationNode = (TileNode*)contact.bodyA.node;
        }

        self.selectedTileComboScore = [_selectedNode.comboLabel.text intValue];
        self.destinationTileComboScore = [_destinationNode.comboLabel.text intValue];
        self.comboScore = self.selectedTileComboScore + self.destinationTileComboScore;
        _selectedNode.comboLabel.text = [NSString stringWithFormat: @"%d",self.comboScore];
        self.hasComboed = YES;

        if ([_selectedNode.name isEqualToString:_destinationNode.name])
        {
            self.hasIncorrectDrag = YES;
        }
        else {
            [_destinationNode removeFromParent];
        }
    }
    //condition for tile and rotor contact
    else if((contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (ContactCategoryTile | ContactCategoryRotor))
    {
        if (contact.bodyA.categoryBitMask == ContactCategoryTile)
        {
            _selectedNode = (TileNode*)contact.bodyA.node;
            _rotorAnimationNode = (RotorNode*)contact.bodyB.node;
        }else{
            _selectedNode = (TileNode*)contact.bodyB.node;
            _rotorAnimationNode = (RotorNode*)contact.bodyA.node;
        }

        if ([_selectedNode.comboLabel.text intValue] >= 6)
        {
            self.hasScoredWithRotor = YES;
            [self checkForCapPoint:[_selectedNode.comboLabel.text intValue]];
            [_selectedNode removeFromParent];
        }else{
            [_selectedNode removeFromParent];
        }
    }
}

- (void)panForTranslation:(CGPoint)translation
{
    CGPoint position = [_selectedNode position];
    if(self.isMovable && [_selectedNode isKindOfClass:[TileNode class]]) {
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    }
}

-(void)segueToWin
{
    //segue to next scene - menu scene
    WinConditionScene *winScene = [WinConditionScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:1.0];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.levelLocation forKey:@"levelLocation"];
    [defaults synchronize];
    [self.view presentScene:winScene transition:transition];
}

-(void)segueToLose
{
    //segue to next scene - menu scene
    LoseConditionScene *loseScene = [LoseConditionScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:loseScene transition:transition];
}

#pragma scoring methods

-(void)updateScore
{
    self.levelScore += 50;
    self.scoreLabel.text = [NSString stringWithFormat: @"Score: %d",self.levelScore];
}

-(void)checkForCapPoint:(NSInteger)tileCombo
{
    if (tileCombo >= 6 && self.rotorAnimationNode == nil)
    {
        [self executeRotorAnimationForward];
    }
//    else{
//        for (TileNode *tileNode in self.tileSlotsArray)
//        {
//            if ([tileNode.comboLabel.text intValue] < 6)
//            {
//                [self executeRotorAnimationBackward];
//            }
//        }
//    }
}

-(void)executeRotorAnimationForward
{
    //rotor instance
    RotorNode *rotorAnimationNode = [RotorNode rotorNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 225)];
    [self addChild:rotorAnimationNode];

    NSArray *rotorAnimationArray = @[[SKTexture textureWithImageNamed:@"rotor1"],
                                     [SKTexture textureWithImageNamed:@"rotor2"],
                                     [SKTexture textureWithImageNamed:@"rotor3"],
                                     [SKTexture textureWithImageNamed:@"rotor4"]];

    SKAction *rotorAnimation = [SKAction animateWithTextures:rotorAnimationArray timePerFrame:0.05];
    SKAction *animationRepeat = [SKAction repeatAction:rotorAnimation count:1];
    [rotorAnimationNode runAction:animationRepeat];
}
//

-(void)updateComboScore
{
    self.selectedTileComboScore = [_selectedNode.comboLabel.text intValue];
    self.comboScore = self.selectedTileComboScore;
    self.comboScore++;
    _selectedNode.comboLabel.text = [NSString stringWithFormat: @"%d",self.comboScore];
}

-(void)executeRotorAnimationBackward
{
    //rotor instance
    RotorNode *rotorCapNode = [RotorNode rotorNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 225)];
    rotorCapNode = [RotorNode spriteNodeWithImageNamed:@"rotor1"];
    [self addChild:rotorCapNode];

    NSArray *rotorAnimationArray = @[[SKTexture textureWithImageNamed:@"rotor4"],
                                     [SKTexture textureWithImageNamed:@"rotor3"],
                                     [SKTexture textureWithImageNamed:@"rotor2"],
                                     [SKTexture textureWithImageNamed:@"rotor1"]];

    SKAction *rotorAnimation = [SKAction animateWithTextures:rotorAnimationArray timePerFrame:0.05];
    SKAction *animationRepeat = [SKAction repeatAction:rotorAnimation count:1];
    [rotorCapNode runAction:animationRepeat];
}

#pragma Pause Logic

-(void)didMoveToView:(SKView *)view
{
    UIImage *pauseImage = [UIImage imageNamed:@"pause.png"];
    self.pauseView = [[UIImageView alloc]initWithImage:pauseImage];
    self.pauseView.hidden = NO;
    self.pauseView.center = CGPointMake(self.size.width*0.5, self.size.height*0.5);
    [self.view addSubview:self.pauseView];

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

-(void)createNodeEmitter:(CGPoint)position
{
    NSString *emitterString = [[NSBundle mainBundle] pathForResource:@"TileParticle" ofType:@"sks"];
    SKEmitterNode *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterString];
    emitter.position = position;

    [emitter runAction:[SKAction waitForDuration:1.0] completion:^{
        [self removeFromParent];
    }];
}
@end
