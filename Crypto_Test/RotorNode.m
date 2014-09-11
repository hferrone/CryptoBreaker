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
    RotorNode *rotorTile = [RotorNode spriteNodeWithImageNamed:@"rotor1"];
    rotorTile.position = position;
    //rotorTile.anchorPoint = CGPointMake(0.5, 0.5);
    rotorTile.name = @"rotorNode";
    rotorTile.size = CGSizeMake(135, 185);

    [rotorTile setupPhysicsBody];

    return rotorTile;
}

-(void)setupPhysicsBody
{
    //physics setup and contact bitmask assignment
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask = ContactCategoryRotor;
    self.physicsBody.contactTestBitMask = ContactCategoryTile;
    self.physicsBody.collisionBitMask = 0;
}

@end
