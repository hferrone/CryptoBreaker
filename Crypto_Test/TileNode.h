//
//  TileNode.h
//  Crypto_Test
//
//  Created by Harrison Ferrone on 8/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TileNode : SKSpriteNode

+(instancetype)tileNodeAtPosition:(CGPoint)position tileComboScore:(NSInteger)comboScore tileArray:(NSArray*)array randomNumber:(int)randomNumber initialCombo:(NSInteger)initCombo;

@end
