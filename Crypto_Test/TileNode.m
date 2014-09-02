//
//  TileNode.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "TileNode.h"

@interface TileNode ()

@property BOOL isMovable;

@end

@implementation TileNode

+(instancetype)tileNodeAtPosition:(CGPoint)position
                tileComboScore:(NSInteger)comboScore
                tileArray:(NSArray*)array
                randomNumber:(int)randomNumber
                initialCombo:(NSInteger)initCombo
{
    TileNode *tileNode = [array objectAtIndex:randomNumber];
    tileNode.position = position;
    tileNode.size = CGSizeMake(23, 63);

    tileNode.comboLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    tileNode.comboLabel.fontColor = [UIColor whiteColor];
    tileNode.comboLabel.text = [NSString stringWithFormat: @"%d",comboScore];
    tileNode.comboLabel.fontSize = 12;
    tileNode.comboLabel.position = CGPointMake(13, 45);
    [tileNode addChild:tileNode.comboLabel];

    tileNode.comboLabel.text = [NSString stringWithFormat: @"%d",initCombo];

    return tileNode;
}

@end
