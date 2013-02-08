//
//  SetCard.m
//  Matchismo
//
//  Created by Victor Engel on 2/7/13.
//  Copyright (c) 2013 Victor Engel. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validNumbers
{
   static NSArray *validNumbers = nil;
   if (!validNumbers) validNumbers = @[@"one",@"two",@"three"];
   return validNumbers;
}
+ (NSArray *)validSymbols
{
   static NSArray *validSymbols = nil;
   if (!validSymbols) validSymbols = @[@"diamond",@"squiggle",@"oval"];
   return validSymbols;
}
+ (NSArray *)validShadings
{
   static NSArray *validShadings = nil;
   if (!validShadings) validShadings = @[@"solid",@"striped",@"open"];
   return validShadings;
}
+ (NSArray *)validColors
{
   static NSArray *validColors = nil;
   if (!validColors) validColors = @[@"red",@"green",@"purple"];
   return validColors;
}
-(BOOL)isSet:(NSArray *)items
{
   BOOL isASet = NO;
   NSMutableArray *itemTypes = [[NSMutableArray alloc] init];
   //returns true if all items in the array are different or all items in array are the same.
   int arraySize = [items count];
   if (arraySize) {
      for (int index=0; index<arraySize; index++) {
         NSString *thisItem = items[index];
         if (![itemTypes indexOfObjectIdenticalTo:thisItem]) {
            [itemTypes addObject:thisItem];
         }
      }
   }
   if ([itemTypes count] == 1) {
      isASet = YES;
   }
   if ([itemTypes count] == [items count]) {
      isASet = YES;
   }
   return isASet;
}
-(int)match:(NSArray *)otherCards
{
   int score=0; // Return nonzero if there is a set.
                // Check if there is a set of number
   NSMutableArray *allItems = [[NSMutableArray alloc] init];
   [allItems addObject:self.number];
   for (SetCard *item in otherCards) {
      [allItems addObject:item.number];
   }
   if ([self isSet:allItems]) score += 1;
                // Check if there is a set of symbol
   allItems = nil;
   [allItems addObject:self.symbol];
   for (SetCard *item in otherCards) {
      [allItems addObject:item.symbol];
   }
   if ([self isSet:allItems]) score += 1;
                // Check if there is a set of shading
   allItems = nil;
   [allItems addObject:self.shading];
   for (SetCard *item in otherCards) {
      [allItems addObject:item.shading];
   }
   if ([self isSet:allItems]) score += 1;
                // Check if there is a set of color
   allItems = nil;
   [allItems addObject:self.color];
   for (SetCard *item in otherCards) {
      [allItems addObject:item.color];
   }
   if ([self isSet:allItems]) score += 1;
   return score;
}

@end
