//
//  InputViewController.m
//  ApiDoc2Property
//
//  Created by zyc on 2021/5/17.
//

#import "InputViewController.h"
#import "PropertyModel.h"

@interface InputViewController ()
@property (unsafe_unretained) IBOutlet NSTextView *inputView;
@property (weak) IBOutlet NSTextView *outView;

/// 字段列表
@property (nonatomic,strong) NSMutableArray *propertyNameAry;
/// 字段类型列表
@property (nonatomic,strong) NSMutableArray *propertyTypeAry;
/// 字段描述列表
@property (nonatomic,strong) NSMutableArray *propertyDescAry;

@property (weak) IBOutlet NSButton *strCopyBtn;


@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}


- (IBAction)clear:(NSButton *)sender {
    
    self.inputView.string = @"";
    self.outView.string = @"";
}

/// 转换
- (IBAction)transform:(NSButton *)sender {
    
    // 结果
    NSMutableString *resultStr = [NSMutableString string];
    // 目前showdoc上的文档 有2种，一种没有说必选
    // 1.  参数名    必选    类型    说明
    // 2.  参数名    类型    描述
    NSString *str = self.inputView.string;
    
    NSArray *propertyList = [str componentsSeparatedByString:@"\n"];
    
    for (NSString *oneLineStr in propertyList) {
        if ([oneLineStr hasPrefix:@"参数"]) { // 可以从 参数 必选 ... 开始复制
            break;
        }
        PropertyModel *model = [[PropertyModel alloc] initWithString:oneLineStr];
        NSString *string = model.converToString;
        [resultStr appendString:string];
        [resultStr appendString:@"\n"];
    }
    
    self.outView.string = resultStr;
    

    NSLog(@"%@",resultStr);
    
}
// 提示
- (void)hint
{
    
    NSString *message = @"复制成功!";
    [self.strCopyBtn setTitle:message];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self.strCopyBtn setTitle:@"拷贝结果"];
    });
}

/// 拷贝结果
- (IBAction)copyResult:(NSButton *)sender {
    
    // 粘贴板
    NSString *resultStr = self.outView.string;
    NSPasteboard *pasteBoard = [NSPasteboard generalPasteboard];
    
    [pasteBoard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
    [pasteBoard setString:resultStr forType:NSStringPboardType];
    
//    pastenboard.string = text;
//    [kKeyWindow makeToast:@"复制成功" duration:1.5 position:CSToastPositionCenter];

//    [[NSPasteboard generalPasteboard]
//               declareTypes: [NSArray arrayWithObject: NSStringPboardType]
//               owner:nil];
//              [[NSPasteboard generalPasteboard]
//               setString: resultStr
//               forType: NSStringPboardType];
    
    
    [self hint];
    
}



@end
