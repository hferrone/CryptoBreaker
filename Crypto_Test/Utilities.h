//
//  Utilities.h
//  Crypto_Test
//
//  Created by Harrison Ferrone on 9/3/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>

//contact bit masks
typedef NS_OPTIONS(uint32_t, ContactCategory) {
    ContactCategoryKey      = 1 << 0,   //0000
    ContactCategoryTile     = 1 << 1,   //0010
    ContactCategoryRotor    = 1 << 2,   //0100
};

@interface Utilities : NSObject

@end