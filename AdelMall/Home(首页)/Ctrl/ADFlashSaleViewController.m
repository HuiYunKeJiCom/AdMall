//
//  ADFlashSaleViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/6.
//  Copyright © 2018年 Adel. All rights reserved.
//  首页-限时抢购

#import "ADFlashSaleViewController.h"
#import "ADOrderTopToolView.h"
//#import "orderHeader.h"
#import "ADSallingViewController.h"//正在抢购
#import "ADSallingSoonViewController.h"//即将开始
#import "ADSecondaryHeaderView.h"
#import "ADCountDownActivityModel.h"

@interface ADFlashSaleViewController ()<UIScrollViewDelegate>{
    UIScrollView *_scrollView;
    ADSecondaryHeaderView *_headView;
    BOOL _isup;
    dispatch_source_t _timer;
    dispatch_source_t _nextTimer;
}
/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;
/** 正在抢购 控制器 */
@property(nonatomic,strong)ADSallingViewController *sallingvc;
/** 正在抢购模型 */
@property(nonatomic,strong)ADCountDownActivityModel *sallingModel;
/** 即将开始 控制器 */
@property(nonatomic,strong)ADSallingSoonViewController *sallingSoonvc;
/** 即将开始模型 */
@property(nonatomic,strong)ADCountDownActivityModel *sallingSoonModel;
//@property (nonatomic, strong) NSTimer *countDownTimer;
/** 正在抢购 时 */
@property(nonatomic,strong)UILabel *hourLab;
/** 正在抢购 分 */
@property(nonatomic,strong)UILabel *minuteLab;
/** 正在抢购 秒 */
@property(nonatomic,strong)UILabel *secondLab;
/** 即将开始 时 */
@property(nonatomic,strong)UILabel *hourNextLab;
/** 即将开始 分 */
@property(nonatomic,strong)UILabel *minuteNextLab;
/** 即将开始 秒 */
@property(nonatomic,strong)UILabel *secondNextLab;

@end

@implementation ADFlashSaleViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.view.backgroundColor = kBACKGROUNDCOLOR;
    if (self.index) {
        
        [self changeScrollview:self.index];
        
        //UIScrollViewDecelerationRateFast;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    self.view.userInteractionEnabled = YES;
    [self setUpNavTopView];
    [self createUI];
//    NSLog(@"这里时间字典 = %@",self.timeDict);
    [self loadDataBeingSnappedUp];
    [self loadDataBeginSoon];
    
}

-(void)setUpHeadViewData{
    NSString *minAndSec = nil;
    NSString *minAndSecSoon = nil;
    if(self.sallingModel.startTime){
        NSArray *dateArr = [self.sallingModel.startTime componentsSeparatedByString:@" "];
        NSArray *timeArr = [dateArr[1] componentsSeparatedByString:@":"];
        minAndSec = [NSString stringWithFormat:@"%@:%@",timeArr[0],timeArr[1]];
    }else{
        minAndSec = @"00:00";
    }
    
    if(self.sallingSoonModel.startTime){
        NSArray *dateArr = [self.sallingSoonModel.startTime componentsSeparatedByString:@" "];
        NSArray *timeArr = [dateArr[1] componentsSeparatedByString:@":"];
        minAndSecSoon = [NSString stringWithFormat:@"%@:%@",timeArr[0],timeArr[1]];
    }else{
        minAndSecSoon = @"00:00";
    }
    
    _headView.items = @[@{@"time":minAndSec,@"title":@"正在抢购",@"detail":@"距结束     :     :"},@{@"time":minAndSecSoon,@"title":@"即将开始",@"detail":@"距结束     :     :"}];
}

//加载正在抢购数据
-(void)loadDataBeingSnappedUp{
    [RequestTool getGoodsForFlashSale:@{@"type":@"start"} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"正在抢购result = %@",result);
        if([result[@"code"] integerValue] == 1){
            [self.sallingvc handleTransferResult:result more:NO];
            [self sallingWithNSDictionary:result];
        }
        
    } withFailBlock:^(NSString *msg) {
        NSLog(@"msg = %@",msg);
    }];
}

-(void)sallingWithNSDictionary:(NSDictionary *)dict
{
    NSArray *data = dict[@"data"];
    self.sallingModel = [ADCountDownActivityModel mj_objectWithKeyValues:data];
    [self dateTimeDifferenceWithStartTime:self.sallingModel.currentTime endTime:self.sallingModel.closeTime];
    [self setUpHeadViewData];
}

//加载即将开始数据
-(void)loadDataBeginSoon{
    [RequestTool getGoodsForFlashSale:@{@"type":@"ready"} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"即将开始result = %@",result);
        if([result[@"code"] integerValue] == 1){
            [self.sallingSoonvc handleTransferResult:result more:NO];
            [self sallingSoonWithNSDictionary:result];
        }
        
    } withFailBlock:^(NSString *msg) {
        NSLog(@"msg = %@",msg);
    }];
}

-(void)sallingSoonWithNSDictionary:(NSDictionary *)dict
{
    
    NSArray *data = dict[@"data"];
    self.sallingSoonModel = [ADCountDownActivityModel mj_objectWithKeyValues:data];
    [self NextDateTimeDifferenceWithStartTime:self.sallingSoonModel.currentTime endTime:self.sallingSoonModel.closeTime];
    [self setUpHeadViewData];
}

-(void)createUI{
    //消除强引用
    __weak typeof(self) weakSelf = self;
    _headView = [[ADSecondaryHeaderView alloc]init];
    //    _headView.items = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
    _headView.frame = CGRectMake(0, 65, kScreenWidth, 46);
//    _headView.items = @[@"正在抢购",@"即将开始"];
//    NSLog(@"时间字典 = %@",self.timeDict);
    
    _headView.backgroundColor = k_UIColorFromRGB(0xffffff);
    _headView.itemClickAtIndex = ^(NSInteger index){
        [weakSelf adjustScrollView:index];
    };
    [self.view addSubview:_headView];
    
    self.hourLab = [[UILabel alloc]initWithFrame:CGRectMake(118, 89, 20, 20) FontSize:kFontNum15 TextColor:[UIColor redColor]];
    [self.view addSubview:self.hourLab];
    self.minuteLab = [[UILabel alloc]initWithFrame:CGRectMake(140, 89, 20, 20) FontSize:kFontNum15 TextColor:[UIColor redColor]];
    [self.view addSubview:self.minuteLab];
    self.secondLab = [[UILabel alloc]initWithFrame:CGRectMake(163, 89, 20, 20) FontSize:kFontNum15 TextColor:[UIColor redColor]];
    [self.view addSubview:self.secondLab];
    
    self.hourNextLab = [[UILabel alloc]initWithFrame:CGRectMake(325, 89, 20, 20) FontSize:kFontNum15 TextColor:[UIColor whiteColor]];
    [self.view addSubview:self.hourNextLab];
    self.minuteNextLab = [[UILabel alloc]initWithFrame:CGRectMake(347, 89, 20, 20) FontSize:kFontNum15 TextColor:[UIColor whiteColor]];
    [self.view addSubview:self.minuteNextLab];
    self.secondNextLab = [[UILabel alloc]initWithFrame:CGRectMake(370, 89, 20, 20) FontSize:kFontNum15 TextColor:[UIColor whiteColor]];
    [self.view addSubview:self.secondNextLab];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame),kScreenWidth,kScreenHeight-64-40)];
    _scrollView.backgroundColor = kBACKGROUNDCOLOR;
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*2, _scrollView.bounds.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.directionalLockEnabled = YES;
    [self.view addSubview:_scrollView];
    [self addViewControllsToScrollView];
    
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[ADOrderTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _topToolView.hidden = NO;
    _topToolView.backgroundColor = k_UIColorFromRGB(0xffffff);
    [_topToolView setTopTitleWithNSString:KLocalizableStr(@"限时抢购")];
    WEAKSELF
    _topToolView.leftItemClickBlock = ^{
        NSLog(@"点击了返回");
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    //    _topToolView.rightItemClickBlock = ^{
    //        NSLog(@"点击设置");
    //    };
    
    [self.view addSubview:_topToolView];
    
}

#pragma mark-将4个controller添加到applecontroller上
-(void)addViewControllsToScrollView
{
    //正在抢购
    self.sallingvc = [[ADSallingViewController alloc]init];
    self.sallingvc.view.frame = CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    [_scrollView addSubview:self.sallingvc.view];
    [self addChildViewController:self.sallingvc];

    //即将开始
    self.sallingSoonvc = [[ADSallingSoonViewController alloc]init];
    self.sallingSoonvc.view.frame = CGRectMake(_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    [_scrollView addSubview:self.sallingSoonvc.view];
    [self addChildViewController:self.sallingSoonvc];
    
}
#pragma mark-通过点击button来改变scrollview的偏移量
-(void)adjustScrollView:(NSInteger)index
{
    [UIView animateWithDuration:0.2 animations:^{
        _scrollView.contentOffset = CGPointMake(index*_scrollView.bounds.size.width, 0);
    }];
}

#pragma mark-选中scorllview来调整headvie的选中
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    [_headView setSelectAtIndex:index];
    if(index == 0){
        self.hourLab.textColor = [UIColor redColor];
        self.minuteLab.textColor = [UIColor redColor];
        self.secondLab.textColor = [UIColor redColor];
        self.hourNextLab.textColor = [UIColor whiteColor];
        self.minuteNextLab.textColor = [UIColor whiteColor];
        self.secondNextLab.textColor = [UIColor whiteColor];
    }else{
        self.hourLab.textColor = [UIColor whiteColor];
        self.minuteLab.textColor = [UIColor whiteColor];
        self.secondLab.textColor = [UIColor whiteColor];
        self.hourNextLab.textColor = [UIColor redColor];
        self.minuteNextLab.textColor = [UIColor redColor];
        self.secondNextLab.textColor = [UIColor redColor];
    }
}


#pragma mark 测试用
-(void)changeScrollview:(NSInteger)index{
    
    [UIView animateWithDuration:0 animations:^{
        _scrollView.contentOffset = CGPointMake(index*_scrollView.bounds.size.width, 0);
    }];
    
}

//倒计时
-(void)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-sss"];
    
    NSDate *startDate = [formatter dateFromString:startTime];
    NSDate *endDate = [formatter dateFromString:endTime];
    NSTimeInterval timeInterval =[endDate timeIntervalSinceDate:startDate];
    
    if (_timer==nil) {
        __block int timeout = timeInterval; //倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //                        self.dayLabel.text = @"";
                        self.hourLab.text = @"00";
                        self.minuteLab.text = @"00";
                        self.secondLab.text = @"00";
                    });
                    [self loadDataBeingSnappedUp];
                    [self setUpHeadViewData];
//                    NSDictionary *dict = @{@"countDownTimeOver":@"over"};
//                    //创建 倒计时结束 通知
//                    NSNotification *notification =[NSNotification notificationWithName:@"countDownTimeOver" object:nil userInfo:dict];
//                    //通过通知中心发送通知
//                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    
                }else{
                    
                    int days = (int)(timeout/(3600*24));
                    //                    if (days==0) {
                    //                        self.dayLabel.text = @"";
                    //                    }
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //                        if (days==0) {
                        //                            self.dayLabel.text = @"0天";
                        //                        }else{
                        //                            self.dayLabel.text = [NSString stringWithFormat:@"%d天",days];
                        //                        }
                        if (hours<10) {
                            self.hourLab.text = [NSString stringWithFormat:@"0%d",hours];
                        }else{
                            self.hourLab.text = [NSString stringWithFormat:@"%d",hours];
                        }
                        if (minute<10) {
                            self.minuteLab.text = [NSString stringWithFormat:@"0%d",minute];
                        }else{
                            self.minuteLab.text = [NSString stringWithFormat:@"%d",minute];
                        }
                        if (second<10) {
                            self.secondLab.text = [NSString stringWithFormat:@"0%d",second];
                        }else{
                            self.secondLab.text = [NSString stringWithFormat:@"%d",second];
                        }
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}

//倒计时
-(void)NextDateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-sss"];
    
    NSDate *startDate = [formatter dateFromString:startTime];
    NSDate *endDate = [formatter dateFromString:endTime];
    NSTimeInterval timeInterval =[endDate timeIntervalSinceDate:startDate];
    
    if (_nextTimer==nil) {
        __block int timeout = timeInterval; //倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _nextTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_nextTimer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_nextTimer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_nextTimer);
                    _nextTimer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //                        self.dayLabel.text = @"";
                        self.hourNextLab.text = @"00";
                        self.minuteNextLab.text = @"00";
                        self.secondNextLab.text = @"00";
                    });
                    [self loadDataBeginSoon];
                    [self setUpHeadViewData];
                    //                    NSDictionary *dict = @{@"countDownTimeOver":@"over"};
                    //                    //创建 倒计时结束 通知
                    //                    NSNotification *notification =[NSNotification notificationWithName:@"countDownTimeOver" object:nil userInfo:dict];
                    //                    //通过通知中心发送通知
                    //                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    
                }else{
                    int days = (int)(timeout/(3600*24));
                    //                    if (days==0) {
                    //                        self.dayLabel.text = @"";
                    //                    }
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //                        if (days==0) {
                        //                            self.dayLabel.text = @"0天";
                        //                        }else{
                        //                            self.dayLabel.text = [NSString stringWithFormat:@"%d天",days];
                        //                        }
                        if (hours<10) {
                            self.hourNextLab.text = [NSString stringWithFormat:@"0%d",hours];
                        }else{
                            self.hourNextLab.text = [NSString stringWithFormat:@"%d",hours];
                        }
                        if (minute<10) {
                            self.minuteNextLab.text = [NSString stringWithFormat:@"0%d",minute];
                        }else{
                            self.minuteNextLab.text = [NSString stringWithFormat:@"%d",minute];
                        }
                        if (second<10) {
                            self.secondNextLab.text = [NSString stringWithFormat:@"0%d",second];
                        }else{
                            self.secondNextLab.text = [NSString stringWithFormat:@"%d",second];
                        }
                        
                    });
                    timeout--;
                }
            });
            dispatch_resume(_nextTimer);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
