//
//  ViewController.m
//  密码强度
//
//  Created by sw on 2022/8/29.
//

#import "ViewController.h"
#import "NSString+HJCore.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *setPasswordField; //设置密码
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField; //确认密码
@property (weak, nonatomic) IBOutlet UIButton *resetPasswordBtn; //完成按钮
@property (weak, nonatomic) IBOutlet UILabel *scoreLbl; //密码分数
@property (weak, nonatomic) IBOutlet UIView *passwordStrongthView; //密码强度

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
    [self passwordStrengthWithScore:0];
    
}

//隐藏密码
- (IBAction)hidePassword:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.setPasswordField.secureTextEntry = !sender.isSelected;
    [self.setPasswordField becomeFirstResponder];
}

//隐藏确认密码
- (IBAction)hideConfirmPassword:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.confirmPasswordField.secureTextEntry = !sender.isSelected;
    [self.confirmPasswordField becomeFirstResponder];
}

//重置密码
- (IBAction)resetPassword:(id)sender {
    
    [self.setPasswordField resignFirstResponder];
    [self.confirmPasswordField resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.setPasswordField resignFirstResponder];
    [self.confirmPasswordField resignFirstResponder];
}

- (void)textChange{
    
    int score = [self scoreComputation];
    [self passwordStrengthWithScore:score]; //密码强度
    self.scoreLbl.text = [NSString stringWithFormat:@"%d分",score]; //密码分数
    
    if (self.setPasswordField.text.length > 0
        && self.confirmPasswordField.text.length > 0) {
        self.resetPasswordBtn.enabled = YES;
        self.resetPasswordBtn.backgroundColor = [UIColor orangeColor];
        [self.resetPasswordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        self.resetPasswordBtn.enabled = NO;
        self.resetPasswordBtn.backgroundColor = [UIColor lightGrayColor];
        [self.resetPasswordBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

//密码强度分数计算
- (int)scoreComputation{
    int score = 0;
    NSString *text = self.setPasswordField.text;
    
    //长度（25分）—— 小于 8个字符（0分） / 8到 10个字符（10分） / 大于 10个字符（25分）
    if (text.length > 8 && text.length < 11) { //8-10个字符
        score = score + 10;
    }else if(text.length > 10){ //大于10个字符
        score = score + 25;
    }
    
    //字母组成（25分）—— 没有字母（0分） / 全都是大（小）写字母（10分） / 大小写混合字母（25分）
    if (([text containsLetters] && ![text containsLowerCaseLetters]) || ([text containsLetters] && ![text containsUpperCaseLetters])) { //全是大（小）写字母
        score = score + 10;
    }else if([text containsUpperCaseLetters] && [text containsLowerCaseLetters]){ //大小写混合字母
        score = score + 25;
    }
    
    //数字（20分）—— 没有数字（0分）/ 1个数字（10分） / 大于2个数字（20分）
    if ([text containsDigit]) { //包含数字
        if ([text numberOfDigits] == 1) { //1个数字
            score = score + 10;
        }else if([text numberOfDigits] > 1){ //大于2个数字
            score = score + 20;
        }
    }
    
    //其它特殊符号（25分）—— 没有符号（0分） / 1个符号（10分） / 大于1个符号（25分）
    if ([text numberOfSpecialCharacter] == 1) { //1个符号
        score = score + 10;
    }else if ([text numberOfSpecialCharacter] > 1){ //大于1个符号
        score = score + 25;
    }
    
    //额外奖励（5分）—— 字母和数字（2分） / 字母、数字和符号（3分） / 大小写字母、数字和符号（5分）
    if([text containsUpperCaseLetters] && [text containsLowerCaseLetters] && [text containsDigit] && [text containsSpecialCharacter]){ //大小写字母、数字和特殊符号
        score = score + 5;
    }else if ([text containsLetters] && [text containsDigit] && [text containsSpecialCharacter]){ //字母、数字和符号
        score = score + 3;
    }else if ([text containsLetters] && [text containsDigit]) { //字母和数字
        score = score + 2;
    }
    return score;
}

//密码强度
- (void)passwordStrengthWithScore:(int)score{
    
    for(UIView *tmpView in self.passwordStrongthView.subviews){
        [tmpView removeFromSuperview];
    }
    
    int strength = score / 10;
    float viewWidth = ([UIScreen mainScreen].bounds.size.width - 135) / 10.00;
    for (int i = 0; i < 10; i++) {
        UIView *strengthView = [[UIView alloc]initWithFrame:CGRectMake((viewWidth + 4) * i, 10, viewWidth, 5)];
        [self.passwordStrongthView addSubview:strengthView];
        strengthView.layer.cornerRadius = 2.5;
        strengthView.layer.masksToBounds = YES;
        if (i < strength) {
            strengthView.backgroundColor = [UIColor blueColor];
        }else{
            strengthView.backgroundColor = [UIColor lightGrayColor];
        }
    }
}


@end
