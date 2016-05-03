//
//  NSObject+MJExtension.h
//  Lee_StandardProject
//
//  Created by leezb101 on 16/2/26.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
@interface NSObject (MJExtension)
+ (id)parse:(id)responseObj;
+ (NSDictionary *)objectClassInArray;
+ (NSDictionary *)replacedKeyFromPropertyName;
@end
