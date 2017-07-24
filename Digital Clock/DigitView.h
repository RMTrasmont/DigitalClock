//
//  DigitView.h
//  Digital Clock
//
//  Created by Rafael M. Trasmontero on 12/7/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DigitView : UIView

//Digit Properties & it's cells

@property (strong, nonatomic) IBOutlet UIView *digitBackground;
@property (weak, nonatomic) IBOutlet UIView *digitTopCell;
@property (weak, nonatomic) IBOutlet UIView *digitTopLeftCell;
@property (weak, nonatomic) IBOutlet UIView *digitTopRightCell;
@property (weak, nonatomic) IBOutlet UIView *digitMidCell;
@property (weak, nonatomic) IBOutlet UIView *digitBottomLeftCell;
@property (weak, nonatomic) IBOutlet UIView *digitBottomRightCell;
@property (weak, nonatomic) IBOutlet UIView *digitBottomCell;
@property (weak, nonatomic) IBOutlet UIView *digitOneTop;
@property (weak, nonatomic) IBOutlet UIView *digitOneBot;
@property (nonatomic) NSArray *myCellsArray;
-(void)displayDigitCells:(long)number;
@end
