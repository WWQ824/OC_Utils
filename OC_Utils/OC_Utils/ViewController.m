//
//  ViewController.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/10.
//

#import "ViewController.h"


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
    int n = block2(200);

    self.add(1).add(2).add(3);
    [self add](1);
    NSLog(@"%@", @(self.result));
    // 最后一个不会有打印,是因为返回的block为调用
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
            NSLog(@"YES走这个回调 %@", @(n));
            return weakSelf;
        } : ^ViewController *(int n){
            NSLog(@"NO走这个回调 %@", @(n));
            return weakSelf;
        };
    };
}


@end
