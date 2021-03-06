//
//  ViewController.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/10.
//

#import "WWQTableViewController.h"
#import "ViewController.h"
#import "UIColor+Utils.h"


typedef ViewController *(^backBlock)(int);

typedef backBlock(^TestBlock)(BOOL);



@interface ViewController ()

@property (nonatomic, assign) NSInteger result;

@property (nonatomic, copy) ViewController *(^add)(int);

@property (nonatomic, copy) TestBlock testBlock;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubviews];
    [self addButton];
    [self test];
    
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
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(index % column * (margin + wh) + margin, index / column * (margin + wh) + 100, wh, wh)];
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


- (void)addButton {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.view.bounds.size.height - 78, 100, 44)];
    btn.backgroundColor = UIColor.u_bloodOrange;
    [btn setTitle:@"JumpToVC" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(jumpToVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)jumpToVC {
    WWQTableViewController *wwqVC = [[WWQTableViewController alloc] init];
    [self.navigationController pushViewController:wwqVC animated:YES];
}




- (void)test {
    
    void (^block)(void) = ^(void) {
        NSLog(@"??????????????????");
    };
    void (^block1)(int) = ^(int n) {
        NSLog(@"??????????????????--%@", @(n));
    };
    
    int (^block2)(int) = ^(int n) {
        NSLog(@"??????????????????--%@", @(n));
        return n;
    };
    
    block();
    block1(100);
    block2(200);

    self.add(1).add(2).add(3);
    [self add](1);
    NSLog(@"%@", @(self.result));
    // ???????????????????????????,??????????????????block?????????
    self.testBlock(YES)(20).testBlock(NO)(60).testBlock(YES);
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
            NSLog(@"YES??????????????? %@", @(n));
            return weakSelf;
        } : ^ViewController *(int n){
            NSLog(@"NO??????????????? %@", @(n));
            return weakSelf;
        };
    };
}


@end
