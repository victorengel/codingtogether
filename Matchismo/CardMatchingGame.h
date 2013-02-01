//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Victor Engel on 2/1/13.
//  Copyright (c) 2013 Victor Engel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

-(id) initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

-(void)flipCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;

@end
