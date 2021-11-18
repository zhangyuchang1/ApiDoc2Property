//
//  PropertyModel.h
//  ApiDoc2Property
//
//  Created by zyc on 2021/5/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 一个 Property 数据
@interface PropertyModel : NSObject

/// 字段名
@property (nonatomic,copy) NSString *name;
/// 字段类型
@property (nonatomic,copy) NSString *type;
/// 字段描述,即注释
@property (nonatomic,copy) NSString *desc;


// 初始化  “userId\t是\tstring\t用户ID” -> PropertyModel
-(instancetype)initWithString:(NSString *)string;
/// 转换成一个string
-(NSString *)converToString;

@end

NS_ASSUME_NONNULL_END
