//
//  LXComposeViewController.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/11.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXComposeViewController.h"
#import "LXTextView.h"
#import "LXComposeToolBar.h"

@interface LXComposeViewController ()<UITextViewDelegate>

@property (nonatomic, weak) LXTextView *textView;
@property (nonatomic, weak) LXComposeToolBar *toolBar;

@end

@implementation LXComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发微博";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [postButton setTitle:@"发送" forState:UIControlStateNormal];
    [postButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [postButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:postButton];
    self.navigationItem.rightBarButtonItem.enabled = NO;
//    [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(post)];
    
    LXTextView *textView = [[LXTextView alloc] initWithFrame:self.view.bounds];
    textView.alwaysBounceVertical = YES;
    textView.placeHolder = @"send what you want...";
    textView.font = [UIFont systemFontOfSize:14];
    textView.delegate = self;
    textView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:textView];
    
    _textView = textView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    
    LXComposeToolBar *toolBar = [[LXComposeToolBar alloc] init];
    [self.view addSubview:toolBar];
    _toolBar = toolBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)textDidChange{
    if (self.textView.text.length) {
        self.textView.hidePlaceHolder = YES;
    } else {
        self.textView.hidePlaceHolder = NO;
    }
}

- (void)keyBoardWillHide:(NSNotification *)notification{
    [self UpdateToolBarFrame:notification isHide:YES];
}

- (void)keyBoardWillShow:(NSNotification *)notification{
    [self UpdateToolBarFrame:notification isHide:NO];
}

- (void)UpdateToolBarFrame:(NSNotification *)notification isHide:(BOOL) hide{
    CGRect frame =  [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        
    if (hide) {
        
        [UIView animateWithDuration:duration animations:^{
            self.toolBar.transform = CGAffineTransformIdentity;
        }];
    } else {
        
        [UIView animateWithDuration:duration animations:^{
            self.toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post{
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.toolBar.frame = CGRectMake(0, self.view.height-35, self.view.width, 35);
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
