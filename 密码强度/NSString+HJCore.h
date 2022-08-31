//
//  NSString+HJCore.h
//  SWSuperApp
//
//  Created by SW on 2020/4/24.
//  Copyright © 2020 SW. All rights reserved.
//

 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HJCore)
#pragma mark - 判断特殊字符
- (BOOL)hjempty;
- (BOOL)isInteger;
- (BOOL)isFloat;
- (BOOL)isHasSpecialcharacters;
- (BOOL)isHasNumder;

#pragma mark - 时间戳转换
- (NSDate *)dateValueWithMillisecondsSince1970;
- (NSDate *)dateValueWithTimeIntervalSince1970;

#pragma 计算字数(中英混合 都算一个)
- (NSInteger)stringLength;

#pragma mark - 计算是否含有
- (BOOL)containsChineseCharacter;
- (BOOL)containsLetters; //是否包含字母
- (BOOL)containsUpperCaseLetters; //是否包含大写字母
- (BOOL)containsLowerCaseLetters; //是否包含小写字母
- (BOOL)containsDigit; //是否包含数字
- (int)numberOfDigits; //数字个数
- (BOOL)containsSpecialCharacter; //是否包含特殊符号
- (int)numberOfSpecialCharacter; //特殊符号个数

#pragma mark - 正则匹配
- (BOOL)isEmail;
- (BOOL)isUrl;
- (BOOL)isTelephone;
- (BOOL)isValidZipcode;
- (BOOL)isPassword;

- (BOOL)isNumbers;
- (BOOL)isLetter;
- (BOOL)isCapitalLetter;
- (BOOL)isSmallLetter;
- (BOOL)isLetterAndNumbers;
- (BOOL)isChineseAndLetterAndNumberAndBelowLine;
- (BOOL)isChineseAndLetterAndNumberAndBelowLine4to10;
- (BOOL)isChineseAndLetterAndNumberAndBelowLineNotFirstOrLast;
- (BOOL)isBelow7ChineseOrBlow14LetterAndNumberAndBelowLine;

#pragma mark - 加密
// md5
- (NSString*)md5;

// sha
- (NSString *)sha1;
- (NSString *)sha256;
- (NSString *)sha384;
- (NSString *)sha512;

#pragma mark - 获得特殊字符串
+ (NSString*)getTimeAndRandomString;

#pragma mark - json转义
- (NSString *)changeJsonEnter;
#pragma mark -  email 转换为 312******@qq.com 形式
- (NSString *)emailChangeToPrivacy;

#pragma mark - Emoji
- (BOOL)isIncludingEmoji;
- (instancetype)removedEmojiString;

#pragma mark -\r \n
- (NSString *)deletRNWithStr:(NSString *)str;


- (NSArray *)stringToArry;

//JSON字符串转Array
- (NSArray *)getArrayWithJsonString:(NSString *)jsonString;
@end

NS_ASSUME_NONNULL_END
