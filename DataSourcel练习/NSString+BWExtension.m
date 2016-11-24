//
//  NSString+BWExtension.m
//  HongYan
//
//  Created by user on 16/6/17.
//  Copyright © 2016年 rihui. All rights reserved.
//

#import "NSString+BWExtension.h"

@implementation NSString (BWExtension)
#pragma mark -- 字符串的相关限制
//限制输入数字
+(BOOL)validateNumberByRegExp:(NSString *)string
{
    BOOL isValid = YES;
    NSUInteger len = string.length;
    if (len > 0) {
        NSString *numberRegex = @"^[0-9]*$";
        NSPredicate *numberPerdicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
        isValid = [numberPerdicate evaluateWithObject:string];
    }
    return isValid;
}

//检测字符串是否是数字或字母组成
+ (BOOL)isNumberOrLetter:(NSString *)num
{
    NSString *numberOrLetter = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:numberOrLetter] invertedSet];
    NSString *filtered = [[num componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [num isEqualToString:filtered];
    return basic;
}
//去掉string中的所有非字母、数字
+ (NSString *)deleteAllOtherCharacterWithString:(NSString *)string
{
    NSMutableString *mStr = [NSMutableString stringWithString:@""];
    NSRange range = NSMakeRange(0, 1);
    for (NSInteger i = 0; i < string.length; i++) {
        range.location = i;
        NSString *str = [string substringWithRange:range];
        if ([self isNumberOrLetter:str]) {
            [mStr appendString:str];
        }
    }
    return [mStr copy];
}
#pragma mark -- 字符的处理
//查询该字符串中某个字符的位置
- (NSInteger)indexOfCharacterPositionWithChar:(NSString *)str
{
    NSInteger len = self.length;
    NSRange range  = NSMakeRange(0, 1);
    NSInteger index = 0;
    NSString *str1 = @"";
    for (int i = 0; i < len; i++) {
        range.location = i;
        str1 = [self substringWithRange:range];
        if ([str1 isEqualToString:str]) {
            index = i;
            break;
        }
    }
    return index;
}
#pragma mark -- 删除该字符串中的某个字符
- (NSString *)deleteAllCharacter:(NSString *)str
{
    NSInteger len = self.length;
    NSRange range  = NSMakeRange(0, 1);
    NSMutableString *mStr = [NSMutableString stringWithFormat:@""];
    NSString *str1 = @"";
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i < len; i++) {
        range.location = i;
        str1 = [self substringWithRange:range];
        if ([str1 isEqualToString:str] == NO) {
            [mArr addObject:str1];
        }
    }
    for (NSString *stt in mArr) {
        [mStr appendString:stt];
    }
    return mStr;
}

#pragma mark -- 判断字符串是否为空或者都是空格
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil){
        return YES;
    }
    if (string == NULL){
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]){
        return YES;
    }
    //判断字符串是否全部为空格（[NSCharacterSet whitespaceAndNewlineCharacterSet]去掉字符串两端的空格)
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0){
        return YES;
    }
    return NO;
}
#pragma mark -- 给一个字符串每个两位加一个冒号
+ (NSString *)addColonForString:(NSString *)string
{
    NSInteger len = string.length;
    NSRange range = NSMakeRange(0, 2);
    NSMutableString *mStr = [NSMutableString stringWithString:@""];
    if (len < 3) {
        return string;
    }
    for (int i = 0; i < len; i+=2) {
        range.location = i;
        if (i == (len / 2 * 2 )) {
            range.length = len % 2 == 1?1:2;
        }
        NSString *str = [string substringWithRange:range];
        [mStr appendString:str];
        if (len % 2 == 0) {
            if (i != (len / 2 * 2 - 2)) {
                [mStr appendString:@":"];
            }
        }else{
            if (i != (len / 2 * 2 )) {
                [mStr appendString:@":"];
            }
        }
    }
    return [mStr copy];
}
#pragma mark -- 二进制与十进制的相关处理
//将一个十进制的数转换成二进制的字符串
+ (NSString *)toBinarySystemWithDecimalSystem:(NSInteger)decimal
{
    NSInteger num = decimal;//[decimal intValue];
    NSInteger remainder = 0;      //余数
    NSInteger divisor = 0;        //除数
    
    NSString * prepare = @"";
    
    while (true)
    {
        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%ld",remainder];
        
        if (divisor == 0)
        {
            break;
        }
    }
    
    NSString * result = @"";
    for (NSInteger i = prepare.length - 1; i >= 0; i --)
    {
        result = [result stringByAppendingFormat:@"%@",
                  [prepare substringWithRange:NSMakeRange(i , 1)]];
    }
    //不足8位的用零补齐
    NSMutableString *mStr = [NSMutableString stringWithString:@""];
    if (result.length < 8) {
        for (NSInteger i = result.length; i < 8; i++) {
            [mStr appendString:@"0"];
        }
    }
    [mStr appendString:result];
    return [mStr copy];
}

//  二进制转十进制
+ (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary
{
    int ll = 0 ;
    int  temp = 0 ;
    for (int i = 0; i < binary.length; i ++)
    {
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    
    NSString * result = [NSString stringWithFormat:@"%d",ll];
    
    return result;
}

//两个八位二进制字符串按位或运算
+ (NSString *)toDecimalStringWithDecimalStr1:(NSString *)decStr1 str2:(NSString *)decStr2
{
    NSString *str1 = [self toEightDecimalString:decStr1];
    NSString *str2 = [self toEightDecimalString:decStr2];
    NSMutableString *mStr = [NSMutableString stringWithString:@""];
    NSRange range = NSMakeRange(0, 1);
    for (NSInteger i = 0; i < 8; i++) {
        range.location = i;
        NSString *subStr1 = [str1 substringWithRange:range];
        NSString *subStr2 = [str2 substringWithRange:range];
        NSString *result = @"0";
        if ([subStr1 boolValue] || [subStr2 boolValue]) {
            result = @"1";
        }
        [mStr appendString:result];
    }
    return [mStr copy];
}
//两个十进制合并得到一个二进制字符串
+ (NSString *)toDecimalSystemWithData1:(NSInteger)data1 data2:(NSInteger)data2
{
   return  [self toDecimalStringWithDecimalStr1:[NSString stringWithFormat:@"%ld",(long)data1] str2:[NSString stringWithFormat:@"%ld",(long)data2]];
}

//不足八位的二进制用零补齐
+ (NSString *)toEightDecimalString:(NSString *)originString
{
    NSMutableString *mStr = [NSMutableString stringWithString:@""];
    if (originString.length < 8) {
        for (NSInteger i = originString.length; i < 8; i++) {
            [mStr appendString:@"0"];
        }
    }
    [mStr appendString:originString];
    return [mStr copy];
}
//对二进制字符串的某一位为取反得到一个二进制字符串
+ (NSString *)changeBinaryString:(NSString *)binaryString index:(NSInteger)index
{
    NSMutableString *changeStr = [NSMutableString stringWithFormat:@""];
    NSRange range = NSMakeRange(0, 1);
    for (NSInteger i = 0; i < 8; i++) {
        range.location = i;
        NSString *str = [binaryString substringWithRange:range];
        if (i == (7 - index)) {
            BOOL boolStr = [str boolValue];
            if (boolStr)
            {
                str = @"0";
            }else{
                str = @"1";
            }
        }
        [changeStr appendString:str];
    }
    return [changeStr copy];
}
//对一个十进制按某一为取反得到一个十进制
+ (NSInteger)getMyDataWithData:(NSInteger)data index:(NSInteger)index
{
    NSString *binaryStr = [self toBinarySystemWithDecimalSystem:data];
    NSString *resultStr = [self changeBinaryString:binaryStr index:index];
    NSString *decimalStr = [self toDecimalSystemWithBinarySystem:resultStr];
    
    return [decimalStr integerValue];
}
//给一个十进制的数取得其转换为二进制后的某一位的值
+ (NSInteger)getBinaryDataWithData:(NSInteger)data index:(NSInteger)index
{
    NSString *binaryStr = [self toBinarySystemWithDecimalSystem:data];
    return [self getBinaryDataWithBinaryStr:binaryStr index:index];
}
//取出一个二进制字符串的某一位
+ (NSInteger)getBinaryDataWithBinaryStr:(NSString *)binaryStr index:(NSInteger)index
{
    NSString *bitBinary = [binaryStr substringWithRange:NSMakeRange(7 - index, 1)];
    return [bitBinary integerValue];
}
@end
