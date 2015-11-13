//
//  ImagesViewController.m
//  UICollectionView-Real-Examples
//
//  Created by Taro Minowa on 11/12/15.
//  Copyright © 2015 Higepon Taro Minowa. All rights reserved.
//

#import "ImagesViewController.h"

@interface ImagesViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *goalieImage;
@property (weak, nonatomic) IBOutlet UIImageView *candyImage;
@property (nonatomic) CGRect candyStartPlace;
@end

@implementation ImagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.candyStartPlace = self.candyImage.frame;


    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)panAction:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (CGRectIntersectsRect(self.candyImage.frame, self.goalieImage.frame)) {

            [UIView animateWithDuration:1.0 animations:^{
                self.candyImage.frame = CGRectMake(self.goalieImage.center.x, self.goalieImage.center.y, 0, 0);
            } completion:nil];

        } else {
            [UIView animateWithDuration:0.2 animations:^{
                self.candyImage.frame = self.candyStartPlace;
            } completion:nil];
        }

        return;
    }

    CGPoint p = [gestureRecognizer translationInView:self.view];
    CGPoint toWhere = CGPointMake(self.candyImage.center.x + p.x, self.candyImage.center.y + p.y);
    self.candyImage.center = toWhere;

    [gestureRecognizer setTranslation:CGPointZero inView:self.view];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
