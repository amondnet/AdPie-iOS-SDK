//
//  NativeAdViewController.m
//  AdPieSample
//
//  Created by sunny on 2016. 10. 17..
//  Copyright © 2016년 GomFactory. All rights reserved.
//

#import "NativeAdViewController.h"

@interface NativeAdViewController () <APNativeDelegate>

@end

@implementation NativeAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nativeAd = [[APNativeAd alloc] initWithSlotId:@"580491a37174ea5279c5d09b"];
    // 델리게이트 등록
    self.nativeAd.delegate = self;
    
    // 광고 요청
    [self.nativeAd load];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark APNativeAd delegates

- (void)nativeDidLoadAd:(APNativeAd *)nativeAd {
    // 광고 요청 완료 후 이벤트 발생
    APNativeAdView *nativeAdView = [[[NSBundle mainBundle] loadNibNamed:@"AdPie_300x250_NativeAdView"
                                                       owner:nil
                                                     options:nil] firstObject];
    
    [self.view addSubview:nativeAdView];
    
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(nativeAdView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[nativeAdView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[nativeAdView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDictionary]];
    
    // 광고뷰에 데이터 표출
    [nativeAdView fillAd:nativeAd.getNativeAdData];
    
    // 광고 클릭 이벤트 수신을 위해 등록
    [nativeAd registerViewForInteraction:nativeAdView];
}

- (void)nativeDidFailToLoadAd:(APNativeAd *)nativeAd
                          withError:(NSError *)error {
    // 광고 요청 실패 후 이벤트 발생
    NSString *title = @"Error";
    NSString *message = [NSString
                         stringWithFormat:
                         @"Failed to load native ads. \n (code : %d, message : %@)",
                         (int)[error code], [error localizedDescription]];
    
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:title
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction *action){
                               
                               // do something when click button
                           }];
    [alert addAction:okAction];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate]
                             window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

- (void)nativeWillLeaveApplication:(APNativeAd *)nativeAd {
    // 광고 클릭 후 이벤트 발생
}

@end
