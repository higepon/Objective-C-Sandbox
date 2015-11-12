//
//  PhotoCollectionViewController.m
//  UICollectionView-Real-Examples
//
//  Created by Taro Minowa on 11/8/15.
//  Copyright © 2015 Higepon Taro Minowa. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "PhotoCollectionViewController.h"

@import AVFoundation;

@interface PhotoCollectionViewController ()

@property (nonatomic) NSArray *photos;
@property (nonatomic) NSArray *texts;

@end

@implementation PhotoCollectionViewController

static NSString * const reuseIdentifier = @"PhotoCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];

    PhotoCollectionViewLayout *layout = (PhotoCollectionViewLayout *)self.collectionView.collectionViewLayout;
    layout.delegate = self;

    self.photos = @[@"terminal.png", @"candy.jpg", @"mexican.jpg", @"goalie.jpg"];
    self.texts = @[@"Hacker", @"Candy, also called sweets or lollies, is a confection that features sugar as a principal ingredient. The category, called sugar confectionery, encompasses any sweet confection, including chocolate, chewing gum, and sugar candy. Vegetables, fruit, or nuts which have been glazed and coated with sugar are said to be candied.", /* https://en.wikipedia.org/wiki/Candy */
                   @"Mexican may refer to: Related to, from, or connected to Mexico, a country in north America", /* https://en.wikipedia.org/wiki/Mexican */
                   @"In many team sports which involve scoring goals, a goalkeeper (termed goaltender, netminder, goalie, or keeper in some sports) is a designated player charged with directly preventing the opposing team from scoring by intercepting shots at goal." /* https://en.wikipedia.org/wiki/Goalkeeper */];

    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.photoImageView.image = [UIImage imageNamed:self.photos[indexPath.row]];
    cell.descLabel.text = self.texts[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (CGFloat)collectionview:(UICollectionView *)collectionView hightForPhotoAtIndexPath:(NSIndexPath *)indexPath withWiddth:(CGFloat)withWidth
{
    UIImage *image = [UIImage imageNamed:self.photos[indexPath.row]];
    CGRect boundingRect = CGRectMake(0, 0, withWidth, MAXFLOAT);
    CGRect rect = AVMakeRectWithAspectRatioInsideRect(image.size, boundingRect);
    return rect.size.height;
}

- (CGFloat)collectionview:(UICollectionView *)collectionView hightForDescriptionAtIndexPath:(NSIndexPath *)indexPath withWiddth:(CGFloat)withWidth
{
    NSString *text = self.texts[indexPath.row];
    UILabel* label = [UILabel new]; // todo
    CGRect rect = [text boundingRectWithSize:CGSizeMake(withWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : label.font} context:nil];
    return rect.size.height;
}


@end
