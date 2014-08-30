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
    tileNode.anchorPoint = CGPointMake(0.5, 0);
    tileNode.size = CGSizeMake(23, 63);

    SKLabelNode *comboLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    comboLabel.fontColor = [UIColor whiteColor];
    comboLabel.text = [NSString stringWithFormat: @"%d",comboScore];
    comboLabel.fontSize = 12;
    comboLabel.position = CGPointMake(10, 50);
    [tileNode addChild:comboLabel];

    for (SKLabelNode *labelNode in tileNode.children)
    {
        labelNode.text = [NSString stringWithFormat: @"%d",initCombo];
    }

    return tileNode;
}

@end
