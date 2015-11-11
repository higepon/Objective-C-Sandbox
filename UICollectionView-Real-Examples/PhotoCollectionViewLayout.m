//
//  PhotoCollectionViewLayout.m
//  UICollectionView-Real-Examples
//
//  Created by Taro Minowa on 11/8/15.
//  Copyright © 2015 Higepon Taro Minowa. All rights reserved.
//

#import "PhotoCollectionViewLayout.h"

static const int kNumberOfColumns = 2;
static const CGFloat kCellPadding = 6.0;

@interface PhotoCollectionViewLayout ()

@property (nonatomic) NSMutableArray *cache;
@property (nonatomic) CGFloat contentHeight;

@end

@implementation PhotoCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache = [[NSMutableArray alloc] init];
        _contentHeight = 0.0;
    }
    return self;
}


- (CGFloat)_contentWidth
{
    UIEdgeInsets inset = self.collectionView.contentInset;
    return CGRectGetWidth(self.collectionView.bounds) - (inset.left + inset.right);
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake([self _contentWidth], self.contentHeight);
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes* attributes  in self.cache) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [layoutAttributes addObject:attributes];
        }
    }
    return layoutAttributes;
}

- (void)prepareLayout
{
    if (!self.cache) {
        _cache = [[NSMutableArray alloc] init];
        _contentHeight = 0.0;
    }

    if (self.cache.count != 0) {
        return;
    }

    CGFloat columnWidth = [self _contentWidth] / kNumberOfColumns;
    NSMutableArray *xOffset = [[NSMutableArray alloc] init];
    for (int column = 0; column < kNumberOfColumns; column++) {
        [xOffset addObject:@(columnWidth * column)];
    }
    NSUInteger column = 0;
    NSMutableArray *yOffset = [NSMutableArray new];
    [yOffset addObject:@(0)];
    [yOffset addObject:@(0)];


    for (NSUInteger itemIndex = 0; itemIndex < [self.collectionView numberOfItemsInSection:0]; itemIndex++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:0];
        CGFloat width = columnWidth - kCellPadding * 2;
        CGFloat photoHeight = [self.delegate collectionview:self.collectionView hightForPhotoAtIndexPath:indexPath withWiddth:width];
        CGFloat descHeight = [self.delegate collectionview:self.collectionView hightForDescriptionAtIndexPath:indexPath withWiddth:width];
        CGFloat height = kCellPadding + photoHeight + descHeight + kCellPadding;
        CGRect frame = CGRectMake([xOffset[column] floatValue], [yOffset[column] floatValue], columnWidth, height);
        CGRect insetFrame = CGRectInset(frame, kCellPadding, kCellPadding);

        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = insetFrame;
        [self.cache addObject:attributes];

        self.contentHeight =MAX(self.contentHeight, CGRectGetMaxY(frame));
        yOffset[column]  = @([yOffset[column] floatValue] + height);
        column = column >= (kNumberOfColumns - 1) ? 0 : ++column;

    }
}

@end
