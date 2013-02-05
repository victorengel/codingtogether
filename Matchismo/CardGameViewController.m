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
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
//@property (nonatomic,strong) Deck* theDeck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipResultLabel;
@end

@implementation CardGameViewController

/*-(Deck *)theDeck
{
   if (!_theDeck) {
      _theDeck = [[PlayingCardDeck alloc] init];
   }
   return _theDeck;
}*/

-(CardMatchingGame *)game
{
   if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                         usingDeck:[[PlayingCardDeck alloc] init]];
   return _game;
}

-(void)setFlipCount:(int)flipCount
{
   _flipCount = flipCount;
   self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}

-(void)setCardButtons:(NSArray *)cardButtons
{
   _cardButtons = cardButtons;
}

-(void)updateUI
{
   UIImage *cardImage = [UIImage imageNamed:@"cardback.png"];
   for (UIButton *cardButton in self.cardButtons) {
      Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
      [cardButton setTitle:card.contents forState:UIControlStateSelected];
      [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
      [cardButton setImage:card.isFaceUp ? nil : cardImage forState:UIControlStateNormal];
      cardButton.selected = card.isFaceUp;
      cardButton.enabled = !card.isUnplayable;
      cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
      self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
   }
   self.flipResultLabel.text = self.game.flipResult;
}

-(void)disableSegmentedControl
{
   for (UISegmentedControl *view in self.view.subviews) {
      if ([view isKindOfClass:[UISegmentedControl class]]) {
         view.userInteractionEnabled = NO;
      }
   }
}

-(void)enableSegmentedControl
{
   for (UISegmentedControl *view in self.view.subviews) {
      if ([view isKindOfClass:[UISegmentedControl class]]) {
         view.userInteractionEnabled = YES;
      }
   }
}

- (IBAction)flipCard:(UIButton *)sender {
   [self disableSegmentedControl];
   [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender] gameMode:self.game.gameMode];
   self.flipCount++;
   //sender.selected = !sender.selected; now handled by self.game
   [self updateUI];
}
- (IBAction)deal:(UIButton *)sender {
   //User has touched the deal button. Clean up and deal a new deck of cards.
   self.game = nil;
   self.flipCount = 0;
   [self updateUI];
   [self enableSegmentedControl];
}
- (IBAction)matchModeSwitch:(UISegmentedControl *)sender {
   if (sender.selectedSegmentIndex == 0) {
      self.game.gameMode = 2;
   } else {
      self.game.gameMode = 3;
   }
}

@end
