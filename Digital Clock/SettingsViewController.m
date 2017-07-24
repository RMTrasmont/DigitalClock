//
//  SettingsViewController.m
//  Digital Clock
//
//  Created by Rafael M. Trasmontero on 1/3/17.
//  Copyright © 2017 TurnToTech. All rights reserved.
//

#import "SettingsViewController.h"
#import "settingsArchiver.h"
@interface SettingsViewController ()
@property (strong,nonatomic) IBOutlet UIPickerView *timeZonesPickerView;
@property (weak,nonatomic) IBOutlet UIButton *timeZoneShowOnButton;
@property (strong, nonatomic)NSArray *arrayOfTimeZoneNames;
@property (nonatomic) BOOL militaryTime;
@property (strong,nonatomic) IBOutlet UISwitch *militarySwitch;
@property (strong,nonatomic) NSString *selectedColorForCell;
@property (strong,nonatomic) NSString *selectedColorForBackground;
@property (nonatomic)long segmentSelected;
@property (strong,nonatomic) IBOutlet UISegmentedControl *backgroundColorSegment;
@property (strong,nonatomic)NSString *timeZoneName;
@property (strong,nonatomic) UISwipeGestureRecognizer *swipeLeft;
@property (strong,nonatomic) UISwipeGestureRecognizer *swipeRight;
@property (strong,nonatomic) UISwipeGestureRecognizer *swipeUp;
@property (strong,nonatomic) UISwipeGestureRecognizer *swipeDown;
@property (strong,nonatomic) IBOutlet UIImageView *WallpaperForSettings;
@property (strong,nonatomic) NSDictionary *imageDictionary;
@property (strong, nonatomic) IBOutlet UILabel *selectedTimeZoneLabel;
@property (nonatomic) NSInteger lastSelectedRow;
- (IBAction)pickRedCells:(UIButton *)sender;
- (IBAction)pickBlueCells:(UIButton *)sender;
- (IBAction)pickGreenCells:(UIButton *)sender;
- (IBAction)pickYellowCells:(UIButton *)sender;
- (IBAction)militaryTimePreference:(UISwitch *)sender;
- (IBAction)doneAndUpload:(UIButton *)sender;
- (IBAction)setBackgroundColor:(UISegmentedControl *)sender;
- (void)saveBackgroundColorToSettings;
- (void)saveCellsColorToSettings;
@property (strong, nonatomic) IBOutlet UIButton *red8;
@property (strong, nonatomic) IBOutlet UIButton *blue8;
@property (strong, nonatomic) IBOutlet UIButton *green8;
@property (strong, nonatomic) IBOutlet UIButton *yellow8;
@property (weak, nonatomic) NSString *cellColorButtonValue;

@end

@implementation SettingsViewController
//fixes No Compile Time Constant
//UIPickerView
static NSArray *arrayOfTimeZoneNames = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeZonesPickerView.delegate = self;
    self.timeZonesPickerView.dataSource = self;
    [self.timeZonesPickerView setShowsSelectionIndicator:YES];
    
    //MAINTAIN LAST TIME ZONE SELECTED ON LABEL AND PICKER
    NSString *lastSelectedTimeZone = [[NSUserDefaults standardUserDefaults]objectForKey:@"settingsChosenTimeZoneName"];
    self.selectedTimeZoneLabel.text = lastSelectedTimeZone;
    self.lastSelectedRow = [[NSUserDefaults standardUserDefaults]integerForKey:@"settingsSelectedTimeZoneIndex"];
    //MUST OVERRIDE(BELOW) method SEE VIEW DIDAPPPEAR
    //[self.timeZonesPickerView selectRow:lastSelectedRow inComponent: animated:;
    
    //ARRAY OF TIMEZONES
    self.arrayOfTimeZoneNames = @[
                                 @"Eastern Daylight Time",
                                 @"Central Daylight Time",
                                 @"Mountain Daylight Time",
                                 @"Pacific Daylight Time",
                                 @"Alaska Daylight Time",
                                 @"Hawaii Standard Time",
                                 ];
    
    //MAINTAINS LAST SEGMENT SELECTED
    _segmentSelected = [[NSUserDefaults standardUserDefaults]integerForKey:@"segmentLastSelected"];
    [self.backgroundColorSegment setSelectedSegmentIndex:_segmentSelected];
    
    //MAINTAIN LAST CELL COLOR SELECTED WITH DARK GREY BACK GROUND
    NSString *cellColorButtonValue = [[NSUserDefaults standardUserDefaults]objectForKey:@"settingsChosenCellColor"];
    if ([cellColorButtonValue isEqualToString:@"redCellColor"]) {
        [self.red8 setBackgroundColor:[UIColor redColor]];
    } else if ([cellColorButtonValue isEqualToString:@"blueCellColor"]){
        [self.blue8 setBackgroundColor:[UIColor blueColor]];
    } else if ([cellColorButtonValue isEqualToString:@"greenCellColor"]){
        [self.green8 setBackgroundColor:[UIColor greenColor]];
    } else {
        [self.yellow8 setBackgroundColor:[UIColor yellowColor]];
    }
    
    //MAINTAINS LAST SWITCH STATUS SELECTED
    _militaryTime = [[NSUserDefaults standardUserDefaults]boolForKey:@"settingsChosenTimeFormat"];
    
    if(_militaryTime == YES){
        [_militarySwitch setOn:YES];
    } else {
        [_militarySwitch setOn:NO];
    }
    
    //SWIPE GESTURES, SET UP AND DETERMINE THE DIRECTION OF THE GESTURES TO RECOGNIZE
    self.swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeForWallpaper:)];
    self.swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeForWallpaper:)];
    self.swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeForWallpaper:)];
    self.swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeForWallpaper:)];
    
    self.swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    self.swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    self.swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    self.swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.view addGestureRecognizer:self.swipeRight];
    [self.view addGestureRecognizer:self.swipeLeft];
    [self.view addGestureRecognizer:self.swipeUp];
    [self.view addGestureRecognizer:self.swipeDown];
    
    //IMAGE DICTIONARY
    self.imageDictionary = @{@"Wall1":[UIImage imageNamed:@"Wallpaper1"],
                             @"Wall2":[UIImage imageNamed:@"Wallpaper2"],
                             @"Wall3":[UIImage imageNamed:@"Wallpaper3"],
                             @"Wall4":[UIImage imageNamed:@"Wallpaper4"],
                             };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

    //OVERRIDE ALLOWS THE USE OF "selectRow:" inComponent: animated:] method.
    //SHOW LAST TIMEZONE SELECTED
- (void)viewDidAppear:(BOOL)animated{
         [self.timeZonesPickerView selectRow:self.lastSelectedRow inComponent:0 animated:NO];
     }
     
    //SAVE CELL COLORS TO PLIST
-(void)saveCellsColorToSettings{
    [[NSUserDefaults standardUserDefaults] setObject:self.selectedColorForCell forKey:@"settingsChosenCellColor"];
}
    //SELECT THE BUTTON TO CHANGE COLOR OF CELLS
- (IBAction)pickRedCells:(UIButton *)sender {
    self.selectedColorForCell = @"redCellColor";
    [self.red8 setBackgroundColor:[UIColor redColor]];
    [self.blue8 setBackgroundColor:[UIColor clearColor]];
    [self.green8 setBackgroundColor:[UIColor clearColor]];
    [self.yellow8 setBackgroundColor:[UIColor clearColor]];
    [self saveCellsColorToSettings];
}

- (IBAction)pickBlueCells:(UIButton *)sender {
    self.selectedColorForCell = @"blueCellColor";
    [self.red8 setBackgroundColor:[UIColor clearColor]];
    [self.blue8 setBackgroundColor:[UIColor blueColor]];
    [self.green8 setBackgroundColor:[UIColor clearColor]];
    [self.yellow8 setBackgroundColor:[UIColor clearColor]];
    [self saveCellsColorToSettings];
}

- (IBAction)pickGreenCells:(UIButton *)sender {
    self.selectedColorForCell = @"greenCellColor";
    [self.red8 setBackgroundColor:[UIColor clearColor]];
    [self.blue8 setBackgroundColor:[UIColor clearColor]];
    [self.green8 setBackgroundColor:[UIColor greenColor]];
    [self.yellow8 setBackgroundColor:[UIColor clearColor]];
    [self saveCellsColorToSettings];
}

- (IBAction)pickYellowCells:(UIButton *)sender {
    self.selectedColorForCell = @"yellowCellColor";
    [self.red8 setBackgroundColor:[UIColor clearColor]];
    [self.blue8 setBackgroundColor:[UIColor clearColor]];
    [self.green8 setBackgroundColor:[UIColor clearColor]];
    [self.yellow8 setBackgroundColor:[UIColor yellowColor]];
    [self saveCellsColorToSettings];
}
    //SAVE BACKGROUND COLOR TO PLIST
- (void)saveBackgroundColorToSettings{
    [[NSUserDefaults standardUserDefaults] setObject:self.selectedColorForBackground forKey:@"settingsChosenBackgroundColor"];
    [[NSUserDefaults standardUserDefaults]setInteger:self.segmentSelected forKey:@"segmentLastSelected"];
}
    //SELECT BACKGROUND COLOR USING SEGMENTS
- (IBAction)setBackgroundColor:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.selectedColorForBackground = @"whiteBackgroundColor";
            self.segmentSelected = sender.selectedSegmentIndex;
            [self saveBackgroundColorToSettings];
            [self setWallPaperNil];
            break;
        case 1:
            self.selectedColorForBackground = @"grayBackgroundColor";
            self.segmentSelected = sender.selectedSegmentIndex;
            [self saveBackgroundColorToSettings];
            [self setWallPaperNil];
            break;
        case 2:
            self.selectedColorForBackground = @"drkGrayBackgroundColor";
            self.segmentSelected = sender.selectedSegmentIndex;
            [self saveBackgroundColorToSettings];
            [self setWallPaperNil];
            break;
        case 3:
            self.selectedColorForBackground = @"blackBackgroundColor";
            self.segmentSelected = sender.selectedSegmentIndex;
            [self saveBackgroundColorToSettings];
            [self setWallPaperNil];
            break;
        default:
            break;
    }
    
}

    //SET TIME PREFERENCE
- (IBAction)militaryTimePreference:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:[sender isOn]  forKey:@"settingsChosenTimeFormat"];
}

#pragma mark UIPickerView Data Source Methods

    //@required Method for UIPickerView... 1 components all timezones
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
    //@required Method for UIPickerView...rows equal to the number of timezones in the array
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.arrayOfTimeZoneNames count];
}

#pragma mark UIPickerView Delegate Method

    //LOAD ARRAY OF LOCATIONS IN PICKERVIEW
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.arrayOfTimeZoneNames[row];
}
    //LOAD PICKERVIEW WITH NAMES OF TIMEZONES (Array) note: use "objectAtIndex:row" to access string Value
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.timeZoneName = [self.arrayOfTimeZoneNames objectAtIndex:row];
    self.selectedTimeZoneLabel.text = self.timeZoneName;
    [[NSUserDefaults standardUserDefaults]setObject:self.timeZoneName forKey:@"settingsChosenTimeZoneName"];
    [[NSUserDefaults standardUserDefaults]setInteger:row forKey:@"settingsSelectedTimeZoneIndex"];

}
    //SWIPE VALUES TO CHANGE WALLPAPER
    //Using Secondary Archiver instead of NSDefault
- (IBAction)swipeForWallpaper:(UISwipeGestureRecognizer *)sender {
    switch(sender.direction){
        case UISwipeGestureRecognizerDirectionLeft:
            self.WallpaperForSettings.image = [UIImage imageNamed:@"Wallpaper1"];
//            [[NSUserDefaults standardUserDefaults]setObject:@"Wall1" forKey:@"settingsChosenWallpaper"];
            [settingsArchiver setObject:@"Wall1" ForKey:@"archiverChosenWallpaper"];
            [self setBackgroundColorNil];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            self.WallpaperForSettings.image = [UIImage imageNamed:@"Wallpaper2"];
//            [[NSUserDefaults standardUserDefaults]setObject:@"Wall2" forKey:@"settingsChosenWallpaper"];
            [settingsArchiver setObject:@"Wall2" ForKey:@"archiverChosenWallpaper"];
            [self setBackgroundColorNil];
            break;
        case UISwipeGestureRecognizerDirectionUp:
            self.WallpaperForSettings.image = [UIImage imageNamed:@"Wallpaper3"];
//            [[NSUserDefaults standardUserDefaults]setObject:@"Wall3"  forKey:@"settingsChosenWallpaper"];
            [settingsArchiver setObject:@"Wall3" ForKey:@"archiverChosenWallpaper"];
            [self setBackgroundColorNil];
            break;
        case UISwipeGestureRecognizerDirectionDown:
            self.WallpaperForSettings.image = [UIImage imageNamed:@"Wallpaper4"];
//            [[NSUserDefaults standardUserDefaults]setObject:@"Wall4"  forKey:@"settingsChosenWallpaper"];
            [settingsArchiver setObject:@"Wall4" ForKey:@"archiverChosenWallpaper"];
            [self setBackgroundColorNil];
            break;
        default:
            break;
    }

}
    //SET WALLPAPER TO NIL using settingsArchiver
-(void)setWallPaperNil{
//    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"settingsChosenWallpaper"];
    //note: setttingsArchiver CANNOT set to nil. so use @"none" and [UIColor UIClear]
    [settingsArchiver setObject:@"None" ForKey:@"archiverChosenWallpaper"];
    
}
    //SET BACKGROUND TO NIL
-(void)setBackgroundColorNil {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"settingsChosenBackgroundColor"];;
}
    //DONE BUTTON SEGUES(storyboard)BACK TO MAINVIEW
- (IBAction)doneAndUpload:(UIButton *)sender {
    
}


@end
