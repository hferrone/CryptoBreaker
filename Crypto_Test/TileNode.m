//
//  TileNode.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "TileNode.h"
#import "Utilities.h"

@interface TileNode ()

@end

@implementation TileNode

+(instancetype)tileNodeAtPosition:(CGPoint)position
                tileComboScore:(NSInteger)comboScore
                tileArray:(NSArray*)array
                randomNumber:(int)randomNumber
                initialCombo:(NSInteger)initCombo
{
    //custom node properties
    TileNode *tileNode = [array objectAtIndex:randomNumber];
    tileNode.position = position;
    tileNode.size = CGSizeMake(23, 63);

    //using label property from .h file and parenting to generated tileNode
    tileNode.comboLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    tileNode.comboLabel.fontColor = [UIColor whiteColor];
    tileNode.comboLabel.text = [NSString stringWithFormat: @"%d",initCombo];
    tileNode.comboLabel.fontSize = 12;
    tileNode.comboLabel.position = CGPointMake(13, 45);

    [tileNode setupPhysicsBody];
    [tileNode addChild:tileNode.comboLabel];

    return tileNode;
}

-(void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask = ContactCategoryTile;
    self.physicsBody.contactTestBitMask = ContactCategoryTile | ContactCategoryRotor | ContactCategoryKey;
    self.physicsBody.collisionBitMask = 0;
}

@end
