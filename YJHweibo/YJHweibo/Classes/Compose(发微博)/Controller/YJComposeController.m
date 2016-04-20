//
//  YJComposeController.m
//  YJHweibo
//
//  Created by YJH on 16/4/14.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJComposeController.h"
#import "YJComposeToolbar.h"
#import "YJComposePhotosView.h"
#import "YJAccountTool.h"
#import "YJAccount.h"
#import "MBProgressHUD+MJ.h"
//#import "YJdrawRectTextView.h"
#import "YJEmotionKeyboard.h"
#import "YJEmotion.h"
#import "YJEmotionTextView.h"

@interface YJComposeController () <YJComposeToolbarDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
// 输入控件
@property (nonatomic, weak) YJEmotionTextView *textView;
@property (nonatomic, weak) YJComposeToolbar *toolbar;
@property (nonatomic, weak) YJComposePhotosView *photosView;
/** 表情键盘 */
@property (nonatomic, strong) YJEmotionKeyboard *emotionKeyboard;
/** 是否正在切换键盘 */
@property (nonatomic, assign) BOOL switchingKeybaord;
@end

@implementation YJComposeController

#pragma mark - 懒加载
- (YJEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[YJEmotionKeyboard alloc] init];
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 216;
    }
    return _emotionKeyboard;
}



+(instancetype)Compose{

    return [[self alloc]init];
}
#pragma mark - 初始化方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航条内容
    [self setupNavBar];
    
    // 添加输入控件
    [self setupTextView];
    
    // 添加工具条
    [self setupToolbar];
    
    // 添加显示图片的相册控件
    [self setupPhotosView];
    
    
}

// 添加显示图片的相册控件
- (void)setupPhotosView
{
    YJComposePhotosView *photosView = [[YJComposePhotosView alloc] init];
    photosView.width = self.textView.width;
    photosView.height = self.textView.height;
    photosView.y = 70;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

// 添加工具条
- (void)setupToolbar
{
    // 1.创建
    YJComposeToolbar *toolbar = [[YJComposeToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.delegate = self;
    toolbar.height = 44;
    self.toolbar = toolbar;
    
    // inputAccessoryView 设置显示在键盘顶部
//    self.textView.inputAccessoryView = toolbar;
    
    // 2.显示
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
}

// 添加输入控件
- (void)setupTextView
{
    // 1.创建输入控件
    YJEmotionTextView *textView = [[YJEmotionTextView alloc] init];
    textView.keyboardType = UIKeyboardTypeDefault;
    textView.alwaysBounceVertical = YES; // 垂直方向上拥有有弹簧效果 可以拖拽
    textView.frame = self.view.bounds;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.设置提醒文字（占位文字）
    textView.placehoder = @"分享新鲜事...";
    
    // 3.设置字体
    textView.font = [UIFont systemFontOfSize:15];
    
    // 4.监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 监听:表情选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect:) name:YJEmotionDidSelectNotification object:nil];
    
    // 删除文字的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDelete) name:YJEmotionDidDeleteNotification object:nil];
}

#pragma mark - 监听方法

/**
 *  删除文字
 */
- (void)emotionDidDelete
{
    [self.textView deleteBackward];
}

/**
 *  表情被选中了
 */
- (void)emotionDidSelect:(NSNotification *)notification
{
    YJEmotion *emotion = notification.userInfo[YJSelectEmotionKey];
    YJLog(@"选中表情%@",emotion.chs);
    
    [self.textView insertEmotion:emotion];
}

// 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  view显示完毕的时候再弹出键盘，避免显示控制器view的时候会卡住
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者（一进来该控制器的时候就叫出键盘）
    [self.textView becomeFirstResponder];
}

// 设置导航条内容
- (void)setupNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleBordered target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *name = [YJAccountTool account].name;
    NSString *prefix = @"发微博";
    if (name) {
    UILabel *titleView = [[UILabel alloc]init];
    titleView.width = 200;
    titleView.height = 44;
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.numberOfLines = 0;
    NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
    // 创建一个带有属性的字符串
    NSMutableAttributedString *attrstr = [[NSMutableAttributedString alloc]initWithString:str];
    [attrstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
    // 添加属性
    [attrstr addAttribute:NSForegroundColorAttributeName  value:YJRandomColor range:[str rangeOfString:prefix]];
    [attrstr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:[str rangeOfString:prefix]];
    
    titleView.attributedText = attrstr;
    self.navigationItem.titleView  = titleView;
}else{
        self.title = prefix;
   }
}

#pragma mark - 私有方法
/**
 *  取消
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送
 */
- (void)send
{
    // 1.发表微博
    if (self.photosView.photos.count) { // 有图片
        [self sendStatusWithImage];
    } else {
        [self sendStatusWithoutImage]; // 没有图片
    }
    
    // 2.关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发表有图片的微博
 */
- (void)sendStatusWithImage
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [YJAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    YJLog(@"params= %@",params);
    // 3.发送POST请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
#warning 目前新浪开放的发微博接口 最多 只能上传一张图片
        UIImage *image = [self.photosView.photos firstObject];
        
        NSData *data = UIImageJPEGRepresentation(image, 1.0); // 压缩图片文件
        
        // 拼接文件参数       参数: 1=->请求参数. 2->XXX.jpg, 3->文件格式
        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *statusDict) {
        [MBProgressHUD showSuccess:@"发表成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发表失败"];
    }];
}


// 图文混排 ： 图片和文字混合在一起排列
/**
 *  发表没有图片的微博
 */
- (void)sendStatusWithoutImage
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [YJAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    YJLog(@"params= %@",params);
    // 3.发送POST请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params
      success:^(AFHTTPRequestOperation *operation, NSDictionary *statusDict) {
          [MBProgressHUD showSuccess:@"发表成功"];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          [MBProgressHUD showError:@"发表失败"];
      }];
}

#pragma mark - 键盘监听方法
/**
 * 键盘的frame发生改变时调用（显示、隐藏等）
 */
-(void)keyboardWillChangeFrame:(NSNotification *)notification{
    YJLog(@"%@",notification);
    
    // 该标记的作用只会在弹出键盘时执行下面代码 重新计算 frame,退出键盘时不执行
    if (self.switchingKeybaord) return;   // 退出键盘时YJComposeToolbar Y 值不会动
    
    // 1.键盘弹出需要的时间
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 取出键盘frame
    CGRect keyboardF = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:duration animations:^{
//        self.toolbar.y = keyboardF.origin.y -  self.toolbar.height;
        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.toolbar.y = self.view.height - self.toolbar.height; // 显示到view底部
        } else {
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height; // 显示到键盘上方
        }
    }];
}

#pragma mark - UITextViewDelegate
/**
 *  当用户开始拖拽scrollView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/**
 *  当textView的文字改变就会调用
 */
- (void)textViewDidChange:(UITextView *)textView
{
    // 如果有文字 就可以点
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

#pragma mark - HMComposeToolbarDelegate
/**
 *  监听toolbar内部按钮的点击
 */
- (void)composeTool:(YJComposeToolbar *)toolbar didClickedButton:(YJComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case YJComposeToolbarButtonTypeCamera: // 照相机
            [self openCamera];
            break;
            
        case YJComposeToolbarButtonTypePicture: // 相册
            [self openAlbum];
            break;
        case YJComposeToolbarButtonTypeMention: // @
            YJLog(@"--- @");
            break;
            
        case YJComposeToolbarButtonTypeTrend: // #
            YJLog(@"--- #");
            break;

        case YJComposeToolbarButtonTypeEmotion: // 表情
            [self switchKeyboard];
            YJLog(@"switchKeyboard ---");
            break;
            
        default:
            break;
    }
}

/**
 *  打开照相机
 */
- (void)openCamera
{
    // 图片选择控制器  判断Type照相机是否能够使用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    // 显示方式
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开表情
 */
- (void)switchKeyboard
{
    // self.textView.inputView == nil : 使用的是系统自带的键盘
    
    if (self.textView.inputView == nil) { // 切换为自定义的表情键盘{
    self.textView.inputView = self.emotionKeyboard;
        
    // 显示键盘按钮
    self.toolbar.showKeyboardButton = YES;
        
    }else{// 切换为系统自带的键盘
        self.textView.inputView = nil;
        
        // 显示表情按钮
        self.toolbar.showKeyboardButton = NO;
    }
    
    // 开始切换键盘
    self.switchingKeybaord = YES; // 退出键盘时YJComposeToolbar Y 值不会动
    
    // 退出键盘
    [self.textView resignFirstResponder];
    
    // 结束切换键盘
    self.switchingKeybaord = NO;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出键盘
        [self.textView becomeFirstResponder];
    });
}

#pragma mark - UIImagePickerControllerDelegate
// 从控制器选择完图片后-> (拍照 或者 选择完相册图片完毕) 时调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 选择完后得 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 1.取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 2.添加图片到相册中
    [self.photosView addImage:image];
}@end
