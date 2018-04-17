//
//  ViewController.m
//  GVRVideoSample
//
//  Created by Akihiko Sato on 2018/04/17.
//  Copyright © 2018年 akihiyo76. All rights reserved.
//

#import "ViewController.h"
#import <GVRVideoView.h>

@interface ViewController () <GVRWidgetViewDelegate>
@property (nonatomic) GVRVideoView *videoView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect viewFrame = CGRectZero;
    viewFrame.origin.x = 8;
    viewFrame.origin.y = 128;
    viewFrame.size.width = self.view.frame.size.width - viewFrame.origin.x * 2;
    viewFrame.size.height = floor(viewFrame.size.width * self.view.frame.size.width / self.view.frame.size.height);
    
    self.videoView = [[GVRVideoView alloc] initWithFrame:viewFrame];
    self.videoView.delegate = self;  // Delegate の内容は GVRPanoramaView とほぼ同じだが、再生位置が取得できるようになっている。
    self.videoView.enableFullscreenButton = YES;
    self.videoView.enableCardboardButton = YES;
    [self.view addSubview:self.videoView];
    
    // 再生する動画ファイルをURL形式で指定する。
    NSURL *videoUrl = [[NSBundle mainBundle] URLForResource:@"sample" withExtension:@"mp4"];
    // HLS 配信の場合はこのようにURLを直接指定する。
    // NSURL *videoUrl = [NSURL URLWithString:@"https://vr.cloudfront.net/sample.m3u8"];
    [self.videoView loadFromUrl:videoUrl ofType:kGVRVideoTypeMono];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPlayButtonTapped:(id)sender {
    NSLog(@">>> %f", (float)self.videoView.playableDuration);
    
    NSURL *videoUrl = [[NSBundle mainBundle] URLForResource:@"sample" withExtension:@"mp4"];
    // HLS 配信の場合はこのようにURLを直接指定する。
    // NSURL *videoUrl = [NSURL URLWithString:@"https://vr.cloudfront.net/sample.m3u8"];
    [self.videoView loadFromUrl:videoUrl ofType:kGVRVideoTypeMono];
}

- (void)widgetView:(GVRWidgetView *)widgetView didLoadContent:(id)content
{
    // コンテンツの読み込みが完了した時に呼ばれる。
    NSLog(@"%s - %@", __PRETTY_FUNCTION__, content);
    [self.videoView play];
}

@end
