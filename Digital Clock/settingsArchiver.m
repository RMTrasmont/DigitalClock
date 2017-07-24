//
//  settingsArchiver.m
//  Digital Clock
//
//  Created by Rafael M. Trasmontero on 1/13/17.
//  Copyright © 2017 TurnToTech. All rights reserved.
//

#import "settingsArchiver.h"

@implementation settingsArchiver

    //CREATES A SECONDARYARCHIVE OF KEY VALUE PAIRS ON THE PLIST, STRING KEYS FOR STRING OBJECTS
+ (void)setObject:(NSString *)stringObject ForKey:(NSString *)stringKey{
    NSFileManager *myArchiver = [NSFileManager defaultManager];
    NSArray *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath = [[documentsPath objectAtIndex:0]stringByAppendingPathComponent:@"settingsArchive.plist"];
    
    if([myArchiver fileExistsAtPath:plistPath]){
        NSMutableDictionary *archiveDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
        [archiveDictionary setObject:stringObject forKey:stringKey];
        [archiveDictionary writeToFile:plistPath atomically:YES];
    }else{
        NSMutableDictionary *archiveDictionary = [[NSMutableDictionary alloc]init];
        [archiveDictionary setObject:stringObject forKey:stringKey];
        [archiveDictionary writeToFile:plistPath atomically:YES];
        }
    }

    //RETRIEVE VALUE FROM DICTIONARY CREATED ABOVE
+ (NSString*)getObjectForkey: (NSString*) stringKey{
    NSFileManager *myArchiver = [NSFileManager defaultManager];
    NSArray *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath = [[documentsPath objectAtIndex:0]stringByAppendingPathComponent:@"settingsArchive.plist"];
    
    if([myArchiver fileExistsAtPath:plistPath]){
        NSMutableDictionary *valuesDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
        return [valuesDictionary objectForKey:stringKey];
    }else{
        NSString *noValueForKey = @"No Value for your Key";
        return noValueForKey;
    }
}
    //SETTING VALUE IN DICTIONARY INTO NIL
+ (void)setObjectNilForKey:(NSString *) stringKey{
    NSFileManager *myArchiver = [NSFileManager defaultManager];
    NSArray *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath = [[documentsPath objectAtIndex:0]stringByAppendingPathComponent:@"settingsArchive.plist"];
    
    if([myArchiver fileExistsAtPath:plistPath]){
        NSMutableDictionary *valuesDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
        [valuesDictionary setNilValueForKey:stringKey];
    }
}
@end
