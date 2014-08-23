//
//  TileNode.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "TileNode.h"

@implementation TileNode

+(instancetype)tileNodeAtPosition:(CGPoint)position
{
    TileNode *tileNode = [TileNode spriteNodeWithImageNamed:@"key"];
    tileNode.position = position;
    tileNode.anchorPoint = CGPointMake(0.5, 0);
    tileNode.name = @"keyTile";

    return tileNode;
}

@end
