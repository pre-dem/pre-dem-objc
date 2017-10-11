//
//  AppIDViewController.m
//  PreDemObjcDemo
//
//  Created by 王思宇 on 8/1/17.
//  Copyright © 2017 pre-engineering. All rights reserved.
//

#import "AppIDViewController.h"
#import <PreDemObjc/PREDemObjc.h>
#import <UICKeyChainStore/UICKeyChainStore.h>

@interface AppIDViewController ()

@property (nonatomic, strong) IBOutlet UITextField *textField;

@end

@implementation AppIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"com.qiniu.pre.demo"];
    NSString *prevID = keychain[@"appid"];
    if (prevID) {
        _textField.text = prevID;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapped:(id)sender {
    [_textField resignFirstResponder];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (_textField.text.length < 8) {
        [[[UIAlertView alloc] initWithTitle:@"出错啦" message:@"appID必须在8位以上才能继续哦" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil] show];
        return NO;
    } else {
        return YES;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"com.qiniu.pre.demo"];
    keychain[@"appid"] = _textField.text;
#ifdef DEBUG
    [PREDManager startWithAppKey:_textField.text
                   serviceDomain:@"http://bgcn4yyud3ui.dem.qbox.net"
                        complete:^(BOOL succeess, NSError * _Nullable error) {
                            if (error) {
                                NSLog(@"initialize PREDManager error: %@", error);
                            }
                        }];
    PREDManager.tag = @"userid_debug";
    PREDLogger.ttyLogLevel = PREDLogLevelWarning;
#else
    [PREDManager startWithAppKey:_textField.text
                   serviceDomain:@"http://bgcn4yyud3ui.dem.qbox.net"
                        complete:^(BOOL succeess, NSError * _Nullable error) {
                            if (error) {
                                NSLog(@"initialize PREDManager error: %@", error);
                            }
                        }];
    PREDManager.tag = @"userid_release";
#endif
}

@end
