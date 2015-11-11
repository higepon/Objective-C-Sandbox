//
//  PhotoCollectionViewLayout.h
//  UICollectionView-Real-Examples
//
//  Created by Taro Minowa on 11/8/15.
//  Copyright © 2015 Higepon Taro Minowa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PinterestLayoutDelegate

- (CGFloat)collectionview:(UICollectionView *)collectionView hightForPhotoAtIndexPath:(NSIndexPath *)indexPath withWiddth:(CGFloat)withWidth;

- (CGFloat)collectionview:(UICollectionView *)collectionView hightForDescriptionAtIndexPath:(NSIndexPath *)indexPath withWiddth:(CGFloat)withWidth;

@end

@interface PhotoCollectionViewLayout : UICollectionViewLayout

@end
