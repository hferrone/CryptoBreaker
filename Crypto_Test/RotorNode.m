//
//  RotorNode.m
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "RotorNode.h"

@implementation RotorNode

+(instancetype)rotorNodeAtPosition:(CGPoint)position
{
    RotorNode *rotorTile = [RotorNode spriteNodeWithImageNamed:@"rotor"];
    rotorTile.position = position;
    rotorTile.anchorPoint = CGPointMake(0.5, 0);
    rotorTile.name = @"rotorTile";

    return rotorTile;
}

@end
