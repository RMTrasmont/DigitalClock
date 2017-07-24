//
//  DigitView.m
//  Digital Clock
//
//  Created by Rafael M. Trasmontero on 12/7/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "DigitView.h"

@interface DigitView();

@end


@implementation DigitView

//LOAD XIB INTO VIEWCONTROLLER UIVIEWS
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self) {
        UIView *digitNib = [[[NSBundle mainBundle]loadNibNamed:@"DigitView" owner:self options:nil]objectAtIndex:0];
        digitNib.frame = self.bounds;
        digitNib.clipsToBounds = YES;
        [self addSubview:digitNib];
        [self myCellsArray];
    }
    return self;
}

// CALL AT ViewController.m
-(void) displayDigitCells:(long)number {
    switch (number) {
        case 0:
            self.digitOneTop.hidden = YES;
            self.digitOneBot.hidden = YES;
            self.digitTopCell.hidden = NO;
            self.digitTopLeftCell.hidden = NO;
            self.digitTopRightCell.hidden = NO;
            self.digitMidCell.hidden = YES;
            self.digitBottomLeftCell.hidden = NO;
            self.digitBottomRightCell.hidden = NO;
            self.digitBottomCell.hidden = NO;
            break;
        case 1:
            self.digitOneTop.hidden = NO;
            self.digitOneBot.hidden = NO;
            self.digitTopCell.hidden = YES;
            self.digitTopLeftCell.hidden = YES;
            self.digitTopRightCell.hidden = YES;
            self.digitMidCell.hidden = YES;
            self.digitBottomLeftCell.hidden = YES;
            self.digitBottomRightCell.hidden = YES;
            self.digitBottomCell.hidden = YES;
            break;
        case 2:
            self.digitOneTop.hidden = YES;
            self.digitOneBot.hidden = YES;
            self.digitTopCell.hidden = NO;
            self.digitTopLeftCell.hidden = YES;
            self.digitTopRightCell.hidden = NO;
            self.digitMidCell.hidden = NO;
            self.digitBottomLeftCell.hidden = NO;
            self.digitBottomRightCell.hidden = YES;
            self.digitBottomCell.hidden = NO;
            break;
        case 3:
            self.digitOneTop.hidden = YES;
            self.digitOneBot.hidden = YES;
            self.digitTopCell.hidden = NO;
            self.digitTopLeftCell.hidden = YES;
            self.digitTopRightCell.hidden = NO;
            self.digitMidCell.hidden = NO;
            self.digitBottomLeftCell.hidden = YES;
            self.digitBottomRightCell.hidden = NO;
            self.digitBottomCell.hidden = NO;
            break;

        case 4:
            self.digitOneTop.hidden = YES;
            self.digitOneBot.hidden = YES;
            self.digitTopCell.hidden = YES;
            self.digitTopLeftCell.hidden = NO;
            self.digitTopRightCell.hidden = NO;
            self.digitMidCell.hidden = NO;
            self.digitBottomLeftCell.hidden = YES;
            self.digitBottomRightCell.hidden = NO;
            self.digitBottomCell.hidden = YES;
            break;
        case 5:
            self.digitOneTop.hidden = YES;
            self.digitOneBot.hidden = YES;
            self.digitTopCell.hidden = NO;
            self.digitTopLeftCell.hidden = NO;
            self.digitTopRightCell.hidden = YES;
            self.digitMidCell.hidden = NO;
            self.digitBottomLeftCell.hidden = YES;
            self.digitBottomRightCell.hidden = NO;
            self.digitBottomCell.hidden = NO;
            break;
        case 6:
            self.digitOneTop.hidden = YES;
            self.digitOneBot.hidden = YES;
            self.digitTopCell.hidden = NO;
            self.digitTopLeftCell.hidden = NO;
            self.digitTopRightCell.hidden = YES;
            self.digitMidCell.hidden = NO;
            self.digitBottomLeftCell.hidden = NO;
            self.digitBottomRightCell.hidden = NO;
            self.digitBottomCell.hidden = NO;
            break;
        case 7:
            self.digitOneTop.hidden = YES;
            self.digitOneBot.hidden = YES;
            self.digitTopCell.hidden = NO;
            self.digitTopLeftCell.hidden = YES;
            self.digitTopRightCell.hidden = NO;
            self.digitMidCell.hidden = YES;
            self.digitBottomLeftCell.hidden = YES;
            self.digitBottomRightCell.hidden = NO;
            self.digitBottomCell.hidden = YES;
            break;
        case 8:
            self.digitOneTop.hidden = YES;
            self.digitOneBot.hidden = YES;
            self.digitTopCell.hidden = NO;
            self.digitTopLeftCell.hidden = NO;
            self.digitTopRightCell.hidden = NO;
            self.digitMidCell.hidden = NO;
            self.digitBottomLeftCell.hidden = NO;
            self.digitBottomRightCell.hidden = NO;
            self.digitBottomCell.hidden = NO;
            break;
        case 9:
            self.digitOneTop.hidden = YES;
            self.digitOneBot.hidden = YES;
            self.digitTopCell.hidden = NO;
            self.digitTopLeftCell.hidden = NO;
            self.digitTopRightCell.hidden = NO;
            self.digitMidCell.hidden = NO;
            self.digitBottomLeftCell.hidden = YES;
            self.digitBottomRightCell.hidden = NO;
            self.digitBottomCell.hidden = YES;
            break;
        default:
            break;
    }
}



@end
