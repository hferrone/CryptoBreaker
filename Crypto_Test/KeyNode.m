//
//  KeyTileNode.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "KeyNode.h"
#import "Utilities.h"

@implementation KeyNode

+(instancetype)keyNodeAtPosition:(CGPoint)position
{
    //custom class properties for generic yellow nodes in UI
    KeyNode *keyTile = [KeyNode spriteNodeWithImageNamed:@"key"];
    keyTile.position = position;
    keyTile.size = CGSizeMake(25, 65);
    keyTile.anchorPoint = CGPointMake(0.5, 0.5);
    keyTile.name = @"keyNode";

    [keyTile setupPhysicsBody];

    return keyTile;
}

-(void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask = ContactCategoryKey;
    self.physicsBody.contactTestBitMask = ContactCategoryTile;
    self.physicsBody.collisionBitMask = 0;
}

@end
