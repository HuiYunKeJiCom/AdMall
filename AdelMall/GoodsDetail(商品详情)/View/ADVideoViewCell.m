//
//  ADVideoViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/7.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品详情-详情-视频

#import "ADVideoViewCell.h"
#import <AVFoundation/AVFoundation.h>

@interface ADVideoViewCell()
@property (nonatomic, strong) UIView  *bgView;
/** 视频展示 */
@property(nonatomic,strong)UILabel *titleLab;
/** 分割线 */
@property (nonatomic, strong) UIView  *lineView;

@property (strong, nonatomic) UIView *backView; // 底部View
@property (nonatomic,strong) AVPlayer *player; // 播放器
@property (nonatomic,strong) AVPlayerItem *playerItem; // 播放器属性对象
@property (nonatomic,strong) AVPlayerLayer *playerLayer; // 播放器需要的layer
@property (nonatomic,strong) UIButton *playButton;
@property (nonatomic,assign) BOOL isDragSlider; // 是否拖动Slider

// 底部BottmView
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *fullScreenButton;
@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic,strong) UISlider *slider;
@property (nonatomic,strong) UILabel *nowLabel;
@property (nonatomic,strong) UILabel *remainLabel;

// 是否全屏
@property (nonatomic,assign) BOOL isFullScreen;
// 定时器 自动消失View
@property (nonatomic,strong) NSTimer *autoDismissTimer;
@end

@implementation ADVideoViewCell
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        [self setUpData];
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.bgView];
    [self addSubview:self.lineView];
    [self addSubview:self.titleLab];
    
    self.isFullScreen = NO;
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(40, 50, kScreenWidth-80, 160)];
    self.backView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.backView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self.backView addGestureRecognizer:tap];
    
    [self initUI];
    
    // 初始化播放器item
    NSString *path = [[NSBundle mainBundle]pathForResource:@"IMG_2670" ofType:@"mp4"];
    self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:path]];
    self.player = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
    // 初始化播放器的Layer
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    // layer的frame
    self.playerLayer.frame = self.backView.bounds;
    // layer的填充属性 和UIImageView的填充属性类似
    // AVLayerVideoGravityResizeAspect 等比例拉伸，会留白
    // AVLayerVideoGravityResizeAspectFill // 等比例拉伸，会裁剪
    // AVLayerVideoGravityResize // 保持原有大小拉伸
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    // 把Layer加到底部View上
    [self.backView.layer insertSublayer:self.playerLayer atIndex:0];
    // 监听播放器状态变化
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    // 监听缓存大小
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    // 监听音乐是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.playerItem];
    
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
}

// 屏幕旋转
- (void)onDeviceOrientationChange
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
//            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
//            NSLog(@"第0个旋转方向---电池栏在上");
            [self toCell];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
//            NSLog(@"第2个旋转方向---电池栏在右");
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
//            NSLog(@"第1个旋转方向---电池栏在左");
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        default:
            break;
    }
}

- (void)initUI
{
    [self.backView addSubview:self.bottomView];
    [self.backView addSubview:self.playButton];
    [self.bottomView addSubview:self.fullScreenButton];
    [self.bottomView addSubview:self.slider];
    [self.bottomView addSubview:self.progressView];
    [self.bottomView sendSubviewToBack:self.progressView];
    [self.bottomView addSubview:self.nowLabel];
    [self.bottomView addSubview:self.remainLabel];
}

#pragma mark
#pragma mark - 暂停或者播放
- (void)pauseOrPlay:(UIButton *)sender
{
    if (self.player.rate != 1.0f){
        [sender setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        
        [self.player play];
    }else{
        [sender setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [self.player pause];
    }
}

#pragma mark
#pragma mark - slider的更改
// 拖拽的时候调用  这个时候不更新视频进度
- (void)sliderDragValueChange:(UISlider *)slider
{
    self.isDragSlider = YES;
}
// 点击调用  或者 拖拽完毕的时候调用
- (void)sliderTapValueChange:(UISlider *)slider
{
    self.isDragSlider = NO;
    // CMTimeMake(帧数（slider.value * timeScale）, 帧/sec)
    // 直接用秒来获取CMTime
    [self.player seekToTime:CMTimeMakeWithSeconds(slider.value, self.playerItem.currentTime.timescale)];
}

// 点击事件的Slider
- (void)touchSlider:(UITapGestureRecognizer *)tap
{
    // 根据点击的坐标计算对应的比例
    CGPoint touch = [tap locationInView:self.slider];
    CGFloat scale = touch.x / self.slider.bounds.size.width;
    self.slider.value = CMTimeGetSeconds(self.playerItem.duration) * scale;
    [self.player seekToTime:CMTimeMakeWithSeconds(self.slider.value, self.playerItem.currentTime.timescale)];
    /* indicates the current rate of playback; 0.0 means "stopped", 1.0 means "play at the natural rate of the current item" */
    if (self.player.rate != 1)
    {
        [self.playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [self.player play];
    }
}

#pragma mark - 单击手势
- (void)singleTap:(UITapGestureRecognizer *)tap
{
    // 和即时搜索一样，删除之前未执行的操作
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoDismissView:) object:nil];
    
    // 这里点击会隐藏对应的View，那么之前的定时还开着，如果不关掉，就会可能重复
    [self.autoDismissTimer invalidate];
    self.autoDismissTimer = nil;
    self.autoDismissTimer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(autoDismissView:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.autoDismissTimer forMode:NSDefaultRunLoopMode];
    
    [UIView animateWithDuration:1.0 animations:^{
        if (self.bottomView.alpha == 1)
        {
            self.bottomView.alpha = 0;
            self.playButton.alpha = 0.0;
        }
        else if (self.bottomView.alpha == 0)
        {
            self.bottomView.alpha = 1.0f;
            self.playButton.alpha = 1.0f;
        }
        
        
    }];
}

// 监听播放器的变化属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"])
    {
        AVPlayerItemStatus statues = [change[NSKeyValueChangeNewKey] integerValue];
        switch (statues) {
            case AVPlayerItemStatusReadyToPlay:
                // 最大值直接用sec，以前都是
                // CMTimeMake(帧数（slider.value * timeScale）, 帧/sec)
                self.slider.maximumValue = CMTimeGetSeconds(self.playerItem.duration);
                [self initTimer];
                // 启动定时器 2秒自动隐藏
                if (!self.autoDismissTimer)
                {
                    self.autoDismissTimer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(autoDismissView:) userInfo:nil repeats:YES];
                    [[NSRunLoop currentRunLoop] addTimer:self.autoDismissTimer forMode:NSDefaultRunLoopMode];
                }
                break;
            case AVPlayerItemStatusUnknown:
                break;
            case AVPlayerItemStatusFailed:
                break;
            default:
                break;
        }
    }
    else if ([keyPath isEqualToString:@"loadedTimeRanges"]) // 监听缓存进度的属性
    {
        // 计算缓存进度
        NSTimeInterval timeInterval = [self availableDuration];
        // 获取总长度
        CMTime duration = self.playerItem.duration;
        CGFloat durationTime = CMTimeGetSeconds(duration);
        // 监听到了给进度条赋值
        [self.progressView setProgress:timeInterval / durationTime animated:NO];
    }
    
    
}

#pragma mark - 自动隐藏bottom和top
- (void)autoDismissView:(NSTimer *)timer
{
    if (self.player.rate == 0)
    {
        // 暂停状态就不隐藏
    }
    else if (self.player.rate == 1)
    {
        if (self.bottomView.alpha == 1)
        {
            [UIView animateWithDuration:1.0 animations:^{
                
                self.bottomView.alpha = 0;
                self.playButton.alpha = 0.0;
            }];
        }
    }
}

// 全屏显示
-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    // 先移除之前的
    [self.backView removeFromSuperview];
    // 初始化
    self.backView.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        self.backView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        self.backView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    // BackView的frame能全屏
    self.backView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    // layer的方向宽和高对调
    self.playerLayer.frame = CGRectMake(0, 0, kScreenHeight, kScreenWidth);
    
    // remark 约束
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(kScreenWidth-50);
        make.left.equalTo(self.backView).with.offset(0);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    [self.nowLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.slider.mas_left).with.offset(0);
        make.top.equalTo(self.slider.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [self.remainLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.slider.mas_right).with.offset(0);
        make.top.equalTo(self.slider.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    // 加到window上面
    [[UIApplication sharedApplication].keyWindow addSubview:self.backView];
    
}

// 缩小到cell
-(void)toCell{
    // 先移除
    [self.backView removeFromSuperview];
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        weakSelf.backView.transform = CGAffineTransformIdentity;
        weakSelf.backView.frame = CGRectMake(40, 50, kScreenWidth-80, 160);
        weakSelf.playerLayer.frame =  weakSelf.backView.bounds;
        // 再添加到View上
        [weakSelf addSubview:weakSelf.backView];
        
        // remark约束
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.backView).with.offset(0);
            make.right.equalTo(weakSelf.backView).with.offset(0);
            make.height.mas_equalTo(50);
            make.bottom.equalTo(weakSelf.backView).with.offset(0);
        }];
    }completion:^(BOOL finished) {
    }];
}

#pragma mark
#pragma mark - 点击全屏
- (void)clickFullScreen:(UIButton *)button
{
    if (!self.isFullScreen){
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
        [self.fullScreenButton setImage:[UIImage imageNamed:@"nonfullscreen"] forState:UIControlStateNormal];
    }else{
        [self toCell];
        [self.fullScreenButton setImage:[UIImage imageNamed:@"fullscreen"] forState:UIControlStateNormal];
    }
    self.isFullScreen = !self.isFullScreen;
}

/**
 *  计算缓冲进度
 *
 *  @return 缓冲进度
 */
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [self.playerItem loadedTimeRanges];
    CMTimeRange timeRange     = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds        = CMTimeGetSeconds(timeRange.start); // 开始的点
    float durationSeconds     = CMTimeGetSeconds(timeRange.duration); // 已缓存的时间点
    NSTimeInterval result     = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

// 调用plaer的对象进行UI更新
- (void)initTimer
{
    // player的定时器
    __weak typeof(self)weakSelf = self;
    // 每秒更新一次UI Slider
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        // 当前时间
        CGFloat nowTime = CMTimeGetSeconds(weakSelf.playerItem.currentTime);
        // 总时间
        CGFloat duration = CMTimeGetSeconds(weakSelf.playerItem.duration);
        // sec 转换成时间点
        weakSelf.nowLabel.text = [weakSelf convertToTime:nowTime];
        weakSelf.remainLabel.text = [weakSelf convertToTime:(duration - nowTime)];
        
        // 不是拖拽中的话更新UI
        if (!weakSelf.isDragSlider)
        {
            weakSelf.slider.value = CMTimeGetSeconds(weakSelf.playerItem.currentTime);
        }
    }];
}

// sec 转换成指定的格式
- (NSString *)convertToTime:(CGFloat)time
{
    // 初始化格式对象
    NSDateFormatter *fotmmatter = [[NSDateFormatter alloc] init];
    // 根据是否大于1H，进行格式赋值
    if (time >= 3600)
    {
        [fotmmatter setDateFormat:@"HH:mm:ss"];
    }
    else
    {
        [fotmmatter setDateFormat:@"mm:ss"];
    }
    // 秒数转换成NSDate类型
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    // date转字符串
    return [fotmmatter stringFromDate:date];
}

-(void)playerItemDidReachEnd:(NSNotification *)noti{
    NSLog(@"播放结束");
    self.playButton.alpha = 1.0;
    self.bottomView.alpha = 1.0;
    [self.playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [self.player pause];
    self.slider.value = 0.0;
    [self.player seekToTime:CMTimeMakeWithSeconds(self.slider.value, self.playerItem.currentTime.timescale)];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    self.titleLab.text = @"视频展示";
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(10);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).with.offset(0);
        make.right.equalTo(self.backView).with.offset(0);
        make.bottom.equalTo(self.backView).with.offset(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bottomView).with.offset(10);
        make.right.equalTo(self.bottomView).with.offset(-45);
        make.centerY.equalTo(self.bottomView);
        
    }];
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_centerX);
        make.centerY.equalTo(self.backView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView).with.offset(-5);
        make.centerY.equalTo(self.bottomView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.slider).with.offset(0);
        make.right.equalTo(self.slider);
        make.height.mas_equalTo(2);
        make.centerY.equalTo(self.slider).with.offset(1);
    }];
    
    [self.nowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.slider.mas_left).with.offset(0);
        make.top.equalTo(self.slider.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [self.remainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.slider.mas_right).with.offset(0);
        make.top.equalTo(self.slider.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = k_UIColorFromRGB(0xffffff);
    }
    return _bgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _titleLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

-(UISlider *)slider{
    if (!_slider) {
        // 底部进度条
        _slider = [[UISlider alloc] init];
        _slider.minimumValue = 0.0;
        _slider.minimumTrackTintColor = [UIColor greenColor];
        _slider.maximumTrackTintColor = [UIColor clearColor];
        _slider.value = 0.0;
        [_slider setThumbImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        [_slider addTarget:self action:@selector(sliderDragValueChange:) forControlEvents:UIControlEventValueChanged];
        [_slider addTarget:self action:@selector(sliderTapValueChange:) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *tapSlider = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSlider:)];
        [_slider addGestureRecognizer:tapSlider];
    }
    return _slider;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        // 底部栏
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    return _bottomView;
}

-(UIButton *)playButton{
    if (!_playButton) {
        // 底部pause或者play
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        _playButton.showsTouchWhenHighlighted = YES;
        [_playButton addTarget:self action:@selector(pauseOrPlay:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

-(UIButton *)fullScreenButton{
    if (!_fullScreenButton) {
        // 底部全屏按钮
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setImage:[UIImage imageNamed:@"fullscreen"] forState:UIControlStateNormal];
        _fullScreenButton.showsTouchWhenHighlighted = YES;
        [_fullScreenButton addTarget:self action:@selector(clickFullScreen:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenButton;
}

-(UIProgressView *)progressView{
    if (!_progressView) {
        // 底部缓存进度条
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.progressTintColor = [UIColor blueColor];
        _progressView.trackTintColor = [UIColor lightGrayColor];
        [_progressView setProgress:0.0 animated:NO];
    }
    return _progressView;
}

-(UILabel *)nowLabel{
    if (!_nowLabel) {
        // 底部左侧时间轴
        _nowLabel = [[UILabel alloc] init];
        _nowLabel.textColor = [UIColor whiteColor];
        _nowLabel.font = [UIFont systemFontOfSize:13];
        _nowLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nowLabel;
}

-(UILabel *)remainLabel{
    if (!_remainLabel) {
        // 底部右侧时间轴
        _remainLabel = [[UILabel alloc] init];
        _remainLabel.textColor = [UIColor whiteColor];
        _remainLabel.font = [UIFont systemFontOfSize:13];
        _remainLabel.textAlignment = NSTextAlignmentRight;
    }
    return _remainLabel;
}

@end
