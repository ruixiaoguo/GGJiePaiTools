//
//  ViewController.m
//  GGJiePaiTools
//
//  Created by GRX on 2021/9/9.
//

#import "ViewController.h"

#import "GGSlider.h"
#import "QuartzCore/QuartzCore.h"

#define DegreesToRadians(x) (M_PI * x / 180.0)

@interface ViewController (){
    GGSlider *slider1;
}
@property (nonatomic,strong)UILabel *textLable;
@property (nonatomic ,strong)dispatch_source_t timer;//  注意:此处应该使用强引用 strong

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];   
    [self addVerticalReverseSlider];
    
    _textLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
//    [self.view addSubview:_textLable];
    UIButton *kaiBtn = [[UIButton alloc]initWithFrame:CGRectMake(150, 500, 100, 40)];
    [kaiBtn setTitle:@"开始" forState:UIControlStateNormal];
    [kaiBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:kaiBtn];
    kaiBtn.layer.borderWidth = 1;
    [kaiBtn addTarget:self action:@selector(kaiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *zantBtn = [[UIButton alloc]initWithFrame:CGRectMake(150, 600, 100, 40)];
    [zantBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [zantBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:zantBtn];
    zantBtn.layer.borderWidth = 1;
    [zantBtn addTarget:self action:@selector(zantBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)kaiBtnClick{
  [self tranceAnimations:slider1 withTransform:30 withSpeed:0.5];
}

-(void)zantBtnClick{
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer=nil;
    }
}
- (void)addVerticalReverseSlider{
     slider1 = [[GGSlider alloc] initWithFrame:CGRectMake(180, 400, 30, 300)];
    slider1.directionType = DirectionVertical;
    slider1.center = self.view.center;
    slider1.sortType = SortReverse;
    slider1.decimalPlaces = 2;
    slider1.minimumValue = 50.0f;
    slider1.maximumValue = 100.0f;
    slider1.value = 60.0f;// 此处注意value要在设置好decimalPlaces，maximumValue和minimumValue以后设置哦！
//    slider1.labelOnThumb.font = [UIFont systemFontOfSize:12];
    slider1.backgroundImageView.image = [UIImage imageNamed:@"11"];
    slider1.thumbImageView.image = [UIImage imageNamed:@"thumb"];
    [self.view addSubview:slider1];
    [slider1 addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    CALayer *layer = [slider1 layer];
    layer.anchorPoint = CGPointMake(0.5, 1.0);
    CGAffineTransform swingTransform =CGAffineTransformMakeRotation(DegreesToRadians(-20));
    slider1.transform = swingTransform;
}

-(void)tranceAnimations:(GGSlider *)image withTransform:(int)Transf withSpeed:(NSTimeInterval)speed{
    __block int  m = Transf;
      dispatch_queue_t queue = dispatch_get_main_queue();
      dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
      dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, speed * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
      dispatch_source_set_event_handler(timer, ^{
          CGAffineTransform swingTransform =CGAffineTransformMakeRotation(DegreesToRadians(m));
          [UIView animateWithDuration:speed animations:^{
              image.transform = swingTransform;
          }completion:^(BOOL finished)
          {}];
          if (m==Transf) {
              m=-Transf;
          }else{
              m=Transf;
          }
      });
      dispatch_resume(timer);
      self.timer = timer;
}
- (void)addVerticalPositiveSlider{
    GGSlider *slider = [[GGSlider alloc] initWithFrame:CGRectMake(200, 100, 30, 300)];
    slider.directionType = DirectionVertical;
    slider.sortType = SortPositive;
   
    slider.minimumValue = 50.0f;
    slider.maximumValue = 100.0f;
    slider.value = 60.0f;
    slider.backgroundImageView.image = [UIImage imageNamed:@"11"];
    slider.thumbImageView.image = [UIImage imageNamed:@"thumb"];
    [self.view addSubview:slider];
    [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];

}
- (void)addHorizontalPositiverSlider{
    GGSlider *slider = [[GGSlider alloc] initWithFrame:CGRectMake(10, 450, 300, 30)];
//    slider.directionType = DirectionVertical;
//    slider.sortType = SortReverse;
   
    slider.minimumValue = 50.0f;
    slider.maximumValue = 100.0f;
    slider.value = 60.0f;
    slider.backgroundImageView.image = [UIImage imageNamed:@"11"];
    slider.thumbImageView.image = [UIImage imageNamed:@"thumb"];
    [self.view addSubview:slider];
}
- (void)addHorizontalReverseSlider{
    GGSlider *slider = [[GGSlider alloc] initWithFrame:CGRectMake(10, 550, 300, 30)];
//    slider.directionType = DirectionVertical;
    slider.sortType = SortReverse;
  
    slider.minimumValue = 50.0f;
    slider.maximumValue = 100.0f;
    slider.value = 60.0f;
    slider.backgroundImageView.image = [UIImage imageNamed:@"11"];
    slider.thumbImageView.image = [UIImage imageNamed:@"thumb"];
    [self.view addSubview:slider];
}
- (void)sliderValueChange:(GGSlider *)slider{
//    NSLog(@"%.2f",slider.value);
    slider1.value = slider.value;
//    _textLable.text = [NSString stringWithFormat:@"%.2f",slider.value];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
