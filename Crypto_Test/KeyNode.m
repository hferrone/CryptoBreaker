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
    //custom class properties for generic yellow nodes in UI
    KeyNode *keyTile = [KeyNode spriteNodeWithImageNamed:@"key"];
    keyTile.position = position;
    keyTile.anchorPoint = CGPointMake(0.5, 0.5);
    keyTile.name = @"keyNode";
    keyTile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(25, 65)];
    keyTile.physicsBody.affectedByGravity = NO;

    return keyTile;
}

@end
