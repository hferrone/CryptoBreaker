//
//  RotorNode.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "RotorNode.h"
#import "Utilities.h"

@implementation RotorNode

+(instancetype)rotorNodeAtPosition:(CGPoint)position
{
    //custom node properties
    RotorNode *rotorTile = [RotorNode spriteNodeWithImageNamed:@"rotor"];
    rotorTile.position = position;
    rotorTile.anchorPoint = CGPointMake(0.5, 0);
    rotorTile.name = @"rotorNode";
    rotorTile.size = CGSizeMake(100, 150);

    [rotorTile setupPhysicsBody];

    return rotorTile;
}

-(void)setupPhysicsBody
{
    //physics setup and contact bitmask assignment
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(100, 150)];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = ContactCategoryRotor;
    self.physicsBody.contactTestBitMask = ContactCategoryTile;
    self.physicsBody.collisionBitMask = 0;
}

@end
