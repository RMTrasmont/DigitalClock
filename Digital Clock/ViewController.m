//
//  ViewController.m
//  Digital Clock
//
//  Created by Rafael M. Trasmontero on 12/7/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "ViewController.h"
#import "DigitView.h"
#import "settingsArchiver.h"
@interface ViewController ()

@property (strong,nonatomic)IBOutletCollection(DigitView)NSArray *digitCellsArray;
@property (strong,nonatomic)NSDictionary *colorDictionaryForBackground;
@property (strong,nonatomic)NSDictionary *colorDictionaryForCells;
@property (strong, nonatomic) NSDictionary *dictionaryOfTimeZones;
@property (strong,nonatomic)NSDictionary *imageDictionary;
@property (weak,nonatomic) NSString *timeZoneKey;
@property (strong, nonatomic) IBOutlet UIImageView *WallpaperForMainView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //DICTIONARY OF TIMEZONES
    self.dictionaryOfTimeZones = @{
                                   @"Eastern Daylight Time": @"EDT",
                                   @"Central Daylight Time": @"CDT",
                                   @"Mountain Daylight Time": @"MDT",
                                   @"Pacific Daylight Time": @"PDT",
                                   @"Alaska Daylight Time": @"AKDT",
                                   @"Hawaii Standard Time": @"HST",
                                   };
    
    //DICTIONARY OF WALLPAPERS
    self.imageDictionary = @{
                             @"Wall1":[UIImage imageNamed:@"Wallpaper1"],
                             @"Wall2":[UIImage imageNamed:@"Wallpaper2"],
                             @"Wall3":[UIImage imageNamed:@"Wallpaper3"],
                             @"Wall4":[UIImage imageNamed:@"Wallpaper4"],
                             };
    
    //SETTINGS BUTTON HIDDEN/ LONGTAP OR QUICKTAP
    [self.settingsButton setHidden:YES];
    
    //BLINK DOTS W/ TIMER EVERY 1/2 SECONDS
    [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(blinkDots) userInfo:nil repeats:YES];
    
    //DISPLAY SELECTED TEXT AND CELL COLOR
    [self loadCellAndTextColor];
    
    //DISPLAY TIME UPDATE EVERY 1 SECOND
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showProperTimeFormat) userInfo:nil repeats:YES];
    
    //DISPLAY DAY MONTH YEAR
    [self displayDayMonthYear];
    
    //DISPLAY BACKGROUND and WALLPAPER (one will be nil)
    [self loadBackgroundColors];
    [self loadWallpaper];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

    //DISPLAY DAY-MONTH-YEAR
- (void)displayDayMonthYear{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [self getTimeZoneKey];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:self.timeZoneKey]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:self.timeZoneKey]];
    NSDate *date = [NSDate date];
    NSString *dateString = [dateFormatter stringFromDate:date];
    self.dateLabel.text = dateString;
    
}

#pragma mark TIME

    //GET SELECTED TIMEZONE
- (void)getTimeZoneKey{
    NSString *timeZoneName =  [[NSUserDefaults standardUserDefaults]objectForKey:@"settingsChosenTimeZoneName"];
    self.timeZoneKey = self.dictionaryOfTimeZones[timeZoneName];
}

    //TIME PREFERENCE YES/NO
- (BOOL)setTime24hrFormatON{
    BOOL timeStatus = [[NSUserDefaults standardUserDefaults]boolForKey:@"settingsChosenTimeFormat"];
    return timeStatus;
}

    //TIME FORMAT 12/24 HR FORMAT
- (void)showProperTimeFormat{
    NSDateFormatter *myTimeFormat = [[NSDateFormatter alloc]init];
    [self getTimeZoneKey];
    [myTimeFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:self.timeZoneKey]];
    [myTimeFormat setDateFormat:@"HH:mm:ss a"];
    NSDate *currentTime = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:self.timeZoneKey]];
    NSDateComponents *dateComponent = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:currentTime];
    
    //CONVERT TIME INTO STRING TO SEE IF AM OR PM EXISTS TO HIDE/SHOW
    NSString *timeString = [myTimeFormat stringFromDate:currentTime];

    //DATE COMPONENTS
    long hours = [dateComponent hour];
    long minutes = [dateComponent minute];
    long seconds = [dateComponent second];
    
    //FIND STATUS OF SWITCH
    [self setTime24hrFormatON];
    
    //***IF SWITCH IS NOT ON 12 HOUR FORMAT
    if ([self setTime24hrFormatON] == NO) {
        if([timeString containsString:@"AM"]){
            [self.pmLabel setHidden:YES];
        } else {
            [self.amLabel setHidden:YES];
        }
        
        if(hours < 10 ){
            [self.H setHidden: YES];
            [self.HH displayDigitCells:hours];
        } else {
            [self.H setHidden:NO];
            [self.H displayDigitCells:hours/10];
            [self.HH displayDigitCells:hours % 10];
        }
        
        if(hours >= 13 && hours <=21){
            [self.H setHidden:YES];
            [self.HH displayDigitCells:hours-12];
        }
        if(hours > 21){
            [self.H setHidden:NO];
            [self.H displayDigitCells:hours - 12/10];
            [self.HH displayDigitCells:hours -12%10];
        }
        
        if(hours == 00){
            [self.H displayDigitCells:1];
            [self.HH displayDigitCells:2];
        }
        
        [self.M displayDigitCells:minutes/10];
        [self.MM displayDigitCells:minutes % 10];
        [self.S displayDigitCells:seconds / 10];
        [self.SS displayDigitCells:seconds % 10];
    
    } else {
    
        //IF SWITCH IS ON SHOW 24HOUR FORMAT
        [self.amLabel setHidden:YES];
        [self.pmLabel setHidden:YES];
        if(hours < 10){
            self.H.hidden = YES;
            [self.HH displayDigitCells:hours];
        } else {
            self.H.hidden = NO;
        }
        [self.H displayDigitCells:hours/10];
        [self.HH displayDigitCells:hours%10];
        [self.M displayDigitCells:minutes/10];
        [self.MM displayDigitCells:minutes%10];
        [self.S displayDigitCells:seconds/10];
        [self.SS displayDigitCells:seconds%10];
    }
}

    //BLINK DOTS
-(void)blinkDots{
    if (self.timeColon.isHidden == NO){
        self.timeColon.hidden = YES;
    } else {
        self.timeColon.hidden = NO;
    }
}

    //GESTURE TO SHOW SETTINGS BUTTON
- (IBAction)longPressShowSettings:(UILongPressGestureRecognizer *)sender {
    [self.settingsButton setHidden:NO];
}

    //GESTURE TO DIE SETTINGS BUTTON
- (IBAction)tapToHideSettings:(UITapGestureRecognizer *)sender {
    [self.settingsButton setHidden:YES];
}

#pragma mark COLORS CELLS/BACKGROUND

    //COLORS FOR CELLS
- (NSDictionary *)colorDictionaryForCells {
    
        _colorDictionaryForCells = @{
                               @"redCellColor": [UIColor redColor],
                               @"blueCellColor": [UIColor blueColor],
                               @"greenCellColor": [UIColor greenColor],
                               @"yellowCellColor": [UIColor yellowColor]
                               };
    
    return _colorDictionaryForCells ;
}

    //COLORS FOR BACKGROUND
- (NSDictionary *)colorDictionaryForBackground {
    _colorDictionaryForBackground = @{
                                @"whiteBackgroundColor": [UIColor whiteColor],
                                @"grayBackgroundColor": [UIColor grayColor],
                                @"drkGrayBackgroundColor": [UIColor darkGrayColor],
                                @"blackBackgroundColor":[UIColor blackColor],
                                };
    return _colorDictionaryForBackground;
}

    //LOAD BACKGROUND COLORS
- (void)loadBackgroundColors{
    [self colorDictionaryForBackground];
    NSString *colorSelected = [[NSUserDefaults standardUserDefaults]objectForKey:@"settingsChosenBackgroundColor"];
    UIColor *color = _colorDictionaryForBackground[colorSelected];
    if([colorSelected  isEqual: @"none"]){
        color = [UIColor clearColor];
    }
    [self.WallpaperForMainView setBackgroundColor:color];
    [self.mainView setBackgroundColor:color];
    [self.dateLabel setBackgroundColor:color];
    [self.colonContainer setBackgroundColor:color];
    [self.amLabel setBackgroundColor:color];
    [self.pmLabel setBackgroundColor:color];
    [self.H setBackgroundColor:color];
    [self.HH setBackgroundColor:color];
    [self.M setBackgroundColor:color];
    [self.MM setBackgroundColor:color];
    [self.S setBackgroundColor:color];
    [self.SS setBackgroundColor:color];
    for(DigitView *digit in _digitCellsArray){
        digit.digitBackground.backgroundColor = color;
    }
}

    //LOAD DIGIT CELL AND TEXT COLORS
- (void)loadCellAndTextColor{
    [self colorDictionaryForCells];
    NSString *colorSelected = [[NSUserDefaults standardUserDefaults]objectForKey:@"settingsChosenCellColor"];
    UIColor *color = _colorDictionaryForCells[colorSelected];
    self.dateLabel.textColor = color;
    self.amLabel.textColor = color;
    self.pmLabel.textColor = color;
    self.timeColon.textColor = color;
    for(DigitView *digit in _digitCellsArray){
    digit.digitTopCell.backgroundColor = color;
    digit.digitTopLeftCell.backgroundColor = color;
    digit.digitTopRightCell.backgroundColor = color;
    digit.digitMidCell.backgroundColor = color;
    digit.digitBottomLeftCell.backgroundColor = color;
    digit.digitBottomRightCell.backgroundColor = color;
    digit.digitBottomCell.backgroundColor = color;
    digit.digitOneTop.backgroundColor = color;
    digit.digitOneBot.backgroundColor = color;
    }
}

    //LOAD WALLPAPER using "settingsArchiver"
- (void)loadWallpaper{
//    NSString *wallpaperName = [[NSUserDefaults standardUserDefaults]objectForKey:@"settingsChosenWallpaper"];
    NSString *wallpaper = [settingsArchiver getObjectForkey:@"archiverChosenWallpaper"];
    [self.WallpaperForMainView setImage:self.imageDictionary[wallpaper]];
    [_mainView setBackgroundColor:[UIColor clearColor]];
    [_dateLabel setBackgroundColor:[UIColor clearColor]];
    [_colonContainer setBackgroundColor:[UIColor clearColor]];
    [_amLabel setBackgroundColor:[UIColor clearColor]];
    [_pmLabel setBackgroundColor:[UIColor clearColor]];
    [self.H setBackgroundColor:[UIColor clearColor]];
    [self.HH setBackgroundColor:[UIColor clearColor]];
    [self.M setBackgroundColor:[UIColor clearColor]];
    [self.MM setBackgroundColor:[UIColor clearColor]];
    [self.S setBackgroundColor:[UIColor clearColor]];
    [self.SS setBackgroundColor:[UIColor clearColor]];
    for(DigitView *digit in _digitCellsArray){
        digit.digitBackground.backgroundColor =[UIColor clearColor];
    };
}

@end
