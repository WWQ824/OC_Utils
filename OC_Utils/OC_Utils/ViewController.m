//
//  ViewController.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/10.
//

#import "ViewController.h"
#import "UIColor+Utils.h"


typedef ViewController *(^backBlock)(int);

typedef backBlock(^TestBlock)(BOOL);



@interface ViewController ()

@property (nonatomic, assign) int result;

@property (nonatomic, copy) ViewController *(^add)(int);
@property (nonatomic, copy) TestBlock testBlock;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    void (^block)(void) = ^(void) {
        NSLog(@"无返回值无参");
    };
    void (^block1)(int) = ^(int n) {
        NSLog(@"无返回值有参--%@", @(n));
    };
    
    int (^block2)(int) = ^(int n) {
        NSLog(@"有返回值有参--%@", @(n));
        return n;
    };
    
    block();
    block1(100);
    block2(200);

    self.add(1).add(2).add(3);
    [self add](1);
    NSLog(@"%@", @(self.result));
    // 最后一个不会有打印,是因为返回的block未调用
    self.testBlock(YES)(20).testBlock(NO)(60).testBlock(YES);
 
    [self configSubviews];
}


- (void)configSubviews {
    
    NSArray *colors = @[UIColor.u_salmon,
                        UIColor.u_bloodOrange,
                        UIColor.u_orangeYellow,
                        UIColor.u_greyish,
                        UIColor.u_warmGrey,
                        UIColor.u_paleGrey,
                        UIColor.u_fadedBlue,
                        UIColor.u_pinkishGrey,
                        UIColor.u_purpleBrown,
                        UIColor.u_carolinaBlue,
                        UIColor.u_backgroundGrey,
                        UIColor.u_barTintColor,
                        UIColor.u_clayBrown,
                        UIColor.u_dirtBrown,
                        UIColor.u_shallowGrey,
                        UIColor.u_black_alpha_40,
                        UIColor.u_selectedCellColor,
                        UIColor.u_mostlyWhite,
                        UIColor.u_silver,
                        UIColor.u_baseYellow,
                        UIColor.u_blackColor,
                        UIColor.u_titleRagularColor];
   
    NSArray *colorNames = @[@"salmon",
                        @"bloodOrange",
                        @"orangeYellow",
                        @"greyish",
                        @"warmGrey",
                        @"paleGrey",
                        @"fadedBlue",
                        @"pinkishGrey",
                        @"purpleBrown",
                        @"carolinaBlue",
                        @"backgroundGrey",
                        @"barTintColor",
                        @"clayBrown",
                        @"dirtBrown",
                        @"shallowGrey",
                        @"black_alpha_40",
                        @"selectedCellColor",
                        @"mostlyWhite",
                        @"silver",
                        @"baseYellow",
                        @"blackColor",
                        @"titleRagularColor"];

    NSInteger column = 4;
    CGFloat margin = 5;
    CGFloat wh = (self.view.bounds.size.width - (column + 1) * margin) / column;
    
    for (NSInteger index = 0; index < colors.count; index++) {
        UIColor *color = colors[index];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(index % column * (margin + wh) + margin, index / column * (margin + wh) + 50, wh, wh)];
        label.layer.cornerRadius = 5;
        label.layer.borderWidth = 2;
        label.layer.borderColor = color.CGColor;
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = color;
        label.text = colorNames[index];
        label.numberOfLines = 0;
        [self.view addSubview:label];
    }
    
}


- (ViewController *(^)(int))add {
    __weak typeof(self) weakSelf = self;
    return ^ViewController * (int n) {
        self.result += n;
        return weakSelf;
    };
}

- (TestBlock)testBlock {
    __weak typeof(self) weakSelf = self;
    return ^backBlock(BOOL on_off){
        return on_off ? ^ViewController *(int n){
            NSLog(@"YES走这个回调 %@", @(n));
            return weakSelf;
        } : ^ViewController *(int n){
            NSLog(@"NO走这个回调 %@", @(n));
            return weakSelf;
        };
    };
}


@end
