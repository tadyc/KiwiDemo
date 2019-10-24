//
//  ViewController.m
//  KiwiDemo
//
//  Created by save on 2018/7/10.
//  Copyright © 2018年 save. All rights reserved.
//

#import "ViewController.h"
#import "MD5Utils.h"
#import "KiWiOBF.h"
@interface ViewController ()

@end
//extern void hikari_fla(void);
@implementation ViewController
- (void) KIWIOBF viewDidLoad  {
    [super viewDidLoad];
   // hikari_fla();
    NSString* strMD5 = [MD5Utils getmd5WithString:@"kiwidemo"];
    NSLog(@"the md5 is :%@",strMD5);
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 60, 400, 20)];
    nameLabel.font = [UIFont systemFontOfSize:21];
    nameLabel.text = @"计算\"kiwidemo\"的md5为：";
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.numberOfLines = 2;  //用于设置UILabel中文本的行数
    [self.view addSubview:nameLabel];
    
    UILabel *newPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 60+40, 400, 30)];
    newPasswordLabel.font = [UIFont systemFontOfSize:18];
    newPasswordLabel.text = strMD5;
    newPasswordLabel.backgroundColor = [UIColor clearColor];
    newPasswordLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:newPasswordLabel];
    NSLog(@"the path:%@",[[NSBundle mainBundle]resourcePath]);
    checkSignatureMsg();
    
}

static NSDictionary * rootDic=nil;

void KIWIOBF checkSignatureMsg()
{
    NSString *newPath=[[NSBundle mainBundle]resourcePath];
    
    if (!rootDic) {
        
        rootDic = [[NSDictionary alloc] initWithContentsOfFile:[newPath stringByAppendingString:@"/_CodeSignature/CodeResources"]];
    }
    
    NSDictionary*fileDic = [rootDic objectForKey:@"files2"];
    
    NSDictionary *infoDic = [fileDic objectForKey:@"embedded.mobileprovision"];
    NSData *tempData = [infoDic objectForKey:@"hash"];
    NSString *hashStr = [tempData base64EncodedStringWithOptions:0];
    NSLog(@"the hash::%@", hashStr);
//    if (![PROVISION_HASH isEqualToString:hashStr]) {
//        abort();//退出应用
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
