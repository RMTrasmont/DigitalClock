//
//  settingsArchiver.h
//  Digital Clock
//
//  Created by Rafael M. Trasmontero on 1/13/17.
//  Copyright © 2017 TurnToTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface settingsArchiver : NSObject

+ (void)setObject: (NSString*) stringObject  ForKey: (NSString*) stringKey;
+ (NSString*)getObjectForkey: (NSString*) stringKey;
+ (void)setObjectNilForKey: (NSString*) stringKey;
@end
