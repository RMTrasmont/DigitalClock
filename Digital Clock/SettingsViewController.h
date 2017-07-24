//
//  SettingsViewController.h
//  Digital Clock
//
//  Created by Rafael M. Trasmontero on 1/3/17.
//  Copyright © 2017 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
- (IBAction)pickRedCells:(UIButton *)sender;
- (IBAction)pickBlueCells:(UIButton *)sender;
- (IBAction)pickGreenCells:(UIButton *)sender;
- (IBAction)pickYellowCells:(UIButton *)sender;
- (IBAction)setBackgroundColor:(UISegmentedControl *)sender;
- (IBAction)militaryTimePreference:(UISwitch *)sender;
- (IBAction)doneAndUpload:(UIButton *)sender;
- (IBAction)swipeForWallpaper:(UISwipeGestureRecognizer *)sender;

@end
