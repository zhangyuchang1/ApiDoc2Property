//
//  PropertyModel.m
//  ApiDoc2Property
//
//  Created by zyc on 2021/5/17.
//

#import "PropertyModel.h"

@implementation PropertyModel

-(instancetype)initWithString:(NSString *)string
{
    self = [super init];
    if (self) {
        
        NSArray *ary = [string componentsSeparatedByString:@"\t"]; // showdoc里都是 \t 截开的
        NSMutableArray *mutAr = [NSMutableArray arrayWithArray:ary];
        
        // 一种是中间有 是否必选的，一种没有
        if (ary.count == 4) {
            // 去掉 是/否
            if([ary[1] isEqualToString:@"是"]){ // 一般是第2个或者第3个
                [mutAr removeObjectAtIndex:1];
            }
            if([ary[1] isEqualToString:@"否"]){ // 一般是第2个或者第3个
                [mutAr removeObjectAtIndex:1];
            }
            if([ary[2] isEqualToString:@"是"]){ // 一般是第2个或者第3个
                [mutAr removeObjectAtIndex:2];
            }
            if([ary[2] isEqualToString:@"否"]){ // 一般是第2个或者第3个
                [mutAr removeObjectAtIndex:2];
            }
            
        }
        
        if(mutAr.count == 3){
            self.name = mutAr[0];
            self.type = mutAr[1];
            self.desc = mutAr[2];
            
        }else{
            
            NSLog(@" 识别出错。。。。。");
        }
        
    }
    
    return self;
}


/// 转换成一个string
-(NSString *)converToString
{
    NSMutableString *result = [NSMutableString string];
    [result appendString:@"/** "];
    [result appendString:self.desc];
    [result appendString:@" */"];
    [result appendString:@"\n"];
    [result appendString:[NSString stringWithFormat:@"@property(nonatomic, %@) ",self.modifyTypeStr]];
    [result appendString:self.typeInOC];
    [result appendString:self.name];
    [result appendString:@";"];
    
    
    return result;
}

// OC中的数据类型 ,有拼上*
-(NSString *)typeInOC
{
    NSString *type = self.type;
    if ([type isEqual:@"string"]) {
        type = @"NSString *";
    }
    if ([type isEqual:@"String"]) {
        type = @"NSString *";
    }
    if ([type isEqual:@"long"]) {
        type = @"long ";
    }
    if ([type isEqual:@"Long"]) {
        type = @"long ";
    }
    if ([type isEqual:@"integer"]) {
        type = @"int ";
    }
    if ([type isEqual:@"Integer"]) {
        type = @"int ";
    }
    if ([type isEqual:@"int"]) {
        type = @"int ";
    }
    if ([type isEqual:@"Int"]) {
        type = @"int ";
    }
    if ([type isEqual:@"number"]) {
        type = @"int ";
    }
    if ([type isEqual:@"Number"]) {
        type = @"int ";
    }
    if ([type isEqual:@"double"]) {
        type = @"double ";
    }
    return type;
}
// 修饰类型。strong还是assign,copy
-(NSString *)modifyTypeStr
{
    
    NSString *typeStr = self.typeInOC;
    if ([typeStr isEqual:@"NSString *"]) {
     
        return @"copy";
    }
    
    return @"assign";
}

@end
