//
//  KeyTileNode.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "KeyNode.h"

@implementation KeyNode

+(instancetype)keyNodeAtPosition:(CGPoint)position
{
    KeyNode *keyTile = [KeyNode spriteNodeWithImageNamed:@"key"];
    keyTile.position = position;
    keyTile.anchorPoint = CGPointMake(0.5, 0);
    keyTile.name = @"keyNode";

    return keyTile;
}

@end
