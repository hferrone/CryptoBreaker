//
//  KeyTileNode.h
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface KeyNode : SKSpriteNode

//custom initializing method w/ position input in MainGameScene
+ (instancetype)keyNodeAtPosition:(CGPoint)position;

@end
