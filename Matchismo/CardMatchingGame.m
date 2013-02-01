//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Victor Engel on 2/1/13.
//  Copyright (c) 2013 Victor Engel. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (readwrite, nonatomic) int score;
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
   if (!_cards) _cards = [[NSMutableArray alloc] init];
   return _cards;
}

-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
   self = [super init];
   if (self) {
      for (int i=0; i<=cardCount; i++) {
         Card *card = [deck drawRandomCard];
         if (!card) {
            self = nil; //This can happen if there are not enough cards in the deck.
         } else {
            self.cards[i] = card;
         }
      }
   }
   return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
   return (index < self.cards.count) ? self.cards[index] : nil;
}

#define MATCH_BONUS 4
#define MATCH_PENALTY -2
#define FLIP_COST -1

-(void)flipCardAtIndex:(NSUInteger)index
{
   Card *card = [self cardAtIndex:index];
   if (!card.isUnplayable) {
      if (!card.isFaceUp) {
         for (Card *otherCard in self.cards) {
            if (otherCard.isFaceUp && !otherCard.isUnplayable) {
               int matchScore = [card match:@[otherCard]];
               if (matchScore) {
                  otherCard.unplayable = YES;
                  card.unplayable = YES;
                  self.score += matchScore * MATCH_BONUS;
               } else {
                  otherCard.faceUp = NO;
                  self.score += MATCH_PENALTY;
               }
            }
         }
         self.score += FLIP_COST;
      }
      card.faceUp = !card.isFaceUp;
   }
}

@end


