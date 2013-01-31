//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Victor Engel on 1/31/13.
//  Copyright (c) 2013 Victor Engel. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic,strong) PlayingCardDeck* theDeck;
@end

@implementation CardGameViewController

-(void)setFlipCount:(int)flipCount
{
   _flipCount = flipCount;
   self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
   if (!self.theDeck) self.theDeck = [[PlayingCardDeck alloc] init];
   if (!sender.selected) {
      PlayingCard *randomCard = (PlayingCard *)[self.theDeck drawRandomCard];
      if (randomCard) {
         NSString *newTitle = [randomCard contents];
         [sender setTitle:newTitle forState:UIControlStateSelected];
         self.flipCount++;
      } else {
         //Game is finished.
         NSLog(@"The game is finished");
      }
   }
   sender.selected = !sender.selected;
}

@end
