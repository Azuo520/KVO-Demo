//
//  ViewController.m
//  KVO演示
//
//  Created by zuoA on 16/4/27.
//  Copyright © 2016年 Azuo. All rights reserved.
//

#import "ViewController.h"
#import "myKVO.h"

@interface ViewController ()

@property (nonatomic,strong)myKVO *myKVO;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myKVO = [[myKVO alloc]init];
    
    /*1.注册对象myKVO为被观察者:
     option中，
      NSKeyValueObservingOptionOld 以字典的形式提供 “初始对象数据”;
      NSKeyValueObservingOptionNew 以字典的形式提供 “更新后新的数据”;
     */
    [self.myKVO addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
}

/* 2.只要object的keyPath属性发生变化，就会调用此回调方法，进行相应的处理：UI更新：*/
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"num"] && object == self.myKVO)
    {
        // 响应变化处理：UI更新（label文本改变）
        self.label.text = [NSString stringWithFormat:@"当前的num值为：%@",[change valueForKey:@"new"]];
        
        //上文注册时，枚举为2个，因此可以提取change字典中的新、旧值的这两个方法
        NSLog(@"\noldnum:%@ newnum:%@",[change valueForKey:@"old"],[change valueForKey:@"new"]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    /* 3.移除KVO */
    [self removeObserver:self forKeyPath:@"num" context:nil];
}

//按钮事件
- (IBAction)changeNum:(UIButton *)sender {
    //按一次，使num的值+1
    self.myKVO.num = self.myKVO.num + 1;
}

@end
