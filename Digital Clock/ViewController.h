//
//  ViewController.h
//  Digital Clock
//
//  Created by Rafael M. Trasmontero on 12/7/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DigitView.h"
@interface ViewController : UIViewController
//STORYBOARD PROPERTIES
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet DigitView *H;
@property (weak, nonatomic) IBOutlet DigitView *HH;
@property (weak, nonatomic) IBOutlet UIView *colonContainer;
@property (weak, nonatomic) IBOutlet UILabel *timeColon;
@property (weak, nonatomic) IBOutlet UILabel *amLabel;
@property (weak, nonatomic) IBOutlet UILabel *pmLabel;
@property (weak, nonatomic) IBOutlet DigitView *M;
@property (weak, nonatomic) IBOutlet DigitView *MM;
@property (weak, nonatomic) IBOutlet DigitView *S;
@property (weak, nonatomic) IBOutlet DigitView *SS;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
- (IBAction)tapToHideSettings:(UITapGestureRecognizer *)sender;
- (IBAction)longPressShowSettings:(UILongPressGestureRecognizer *)sender;
@end

