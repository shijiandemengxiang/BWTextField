//
//  NSString+BWExtension.h
//  HongYan
//
//  Created by user on 16/6/17.
//  Copyright © 2016年 rihui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BWExtension)
/**
 限制输入数字
 */
+ (BOOL)validateNumberByRegExp:(NSString *)string;
/**
 查找某个字符串中最靠前的某个字符的位置
 */
- (NSInteger)indexOfCharacterPositionWithChar:(NSString *)str;
/**
 删除字符串中所有的某个字符
 */
- (NSString *)deleteAllCharacter:(NSString *)str;
/**
  限制输入字符和数字
 */
+ (BOOL)isNumberOrLetter:(NSString *)num;
/**
  给一个字符串每隔两位添加冒号
 */
+ (NSString *)addColonForString:(NSString *)string;
/**
    去掉一个字符串中的所有非数字和字母的字符
 */
+ (NSString *)deleteAllOtherCharacterWithString:(NSString *)string;
#pragma mark -- 二进制 十进制 相关处理
/**
 将一个十进制的数转换成二进制的字符串
 */
+ (NSString *)toBinarySystemWithDecimalSystem:(NSInteger)decimal;
/**
 二进制转十进制
 */
+ (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary;
/**
 两个八位二进制字符串按位或运算
 */
+ (NSString *)toDecimalStringWithDecimalStr1:(NSString *)decStr1 str2:(NSString *)decStr2;
/**
 两个十进制合并得到一个二进制字符串
 */
+ (NSString *)toDecimalSystemWithData1:(NSInteger)data1 data2:(NSInteger)data2;
/**
  对二进制字符串的某一位为取反
 */
+ (NSString *)changeBinaryString:(NSString *)binaryString index:(NSInteger)index;
/**
 对一个十进制按某一为取反得到一个十进制
 */
+ (NSInteger)getMyDataWithData:(NSInteger)data index:(NSInteger)index;
/**
 给一个十进制的数取得其转换为二进制后的某一位的值
 @param data 十进制数
 @param index 二进制位
 */
+ (NSInteger)getBinaryDataWithData:(NSInteger)data index:(NSInteger)index;
@end
