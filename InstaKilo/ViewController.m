//
//  ViewController.m
//  InstaKilo
//
//  Created by Josh Endter on 6/25/15.
//  Copyright (c) 2015 Josh Endter. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCollectionViewCell.h"
#import "Photo.h"
#import "PhotoSectionHeader.h"

typedef enum {
    PhotoSortSubject,
    PhotoSortLocation
} PhotoSort;

@interface ViewController ()

//@property (nonatomic, strong) NSArray *imageNames;
//@property (nonatomic, strong) NSDictionary *imagesToProperties;

@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSMutableArray *sections;

@property (nonatomic) PhotoSort photoSort; // How the photos are currently sorted on screen (either by subject or location)


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.photoSort = PhotoSortSubject;
    
    // TODO: Seperate out into new method (setupPhotoData:)
    Photo *photo1 = [Photo new];
    photo1.imageName = @"australia";
    photo1.subject = @"travel";
    photo1.location = @"Australia";

    Photo *photo2 = [Photo new];
    photo2.imageName = @"bridge";
    photo2.subject = @"hiking";
    photo2.location = @"Australia";
    
    Photo *photo3 = [Photo new];
    photo3.imageName = @"california";
    photo3.subject = @"travel";
    photo3.location = @"Australia";
    
    Photo *photo4 = [Photo new];
    photo4.imageName = @"california2";
    photo4.subject = @"travel";
    photo4.location = @"Australia";
    
    Photo *photo5 = [Photo new];
    photo5.imageName = @"california3";
    photo5.subject = @"travel";
    photo5.location = @"Australia";
    
    Photo *photo6 = [Photo new];
    photo6.imageName = @"california4";
    photo6.subject = @"travel";
    photo6.location = @"Australia";
    
    Photo *photo7 = [Photo new];
    photo7.imageName = @"cat";
    photo7.subject = @"animal";
    photo7.location = @"Australia";
    
    Photo *photo8 = [Photo new];
    photo8.imageName = @"cat2";
    photo8.subject = @"animal";
    photo8.location = @"Australia";
    
    Photo *photo9 = [Photo new];
    photo9.imageName = @"coast";
    photo9.subject = @"travel";
    photo9.location = @"Australia";
    
    Photo *photo10 = [Photo new];
    photo10.imageName = @"forest";
    photo10.subject = @"hiking";
    photo10.location = @"Australia";
    
    Photo *photo11 = [Photo new];
    photo11.imageName = @"park";
    photo11.subject = @"hiking";
    photo11.location = @"Australia";
    
    Photo *photo12 = [Photo new];
    photo12.imageName = @"waiting";
    photo12.subject = @"animal";
    photo12.location = @"Australia";
    
    Photo *photo13 = [Photo new];
    photo13.imageName = @"winter";
    photo13.subject = @"weather";
    photo13.location = @"Philadelphia";
    
    self.photos = @[photo1, photo2, photo3, photo4, photo5, photo6, photo7, photo8, photo9, photo10, photo11, photo12, photo13];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    NSString *sectionNameOfIndex = self.sections[indexPath.section];
    
    NSInteger counter = 0;
    Photo *photoAtCurrentIndex;
    for (Photo *photo in self.photos) {
        
        if (self.photoSort == PhotoSortSubject) {
            if ([photo.subject isEqual:sectionNameOfIndex]) {
                if (counter == indexPath.row) {
                    photoAtCurrentIndex = photo;
                }
                
                counter++;
            }
        } else if (self.photoSort == PhotoSortLocation) {
            if ([photo.location isEqual:sectionNameOfIndex]) {
                if (counter == indexPath.row) {
                    photoAtCurrentIndex = photo;
                }
                
                counter++;
            }
        }
        
    }
    
    //Photo *photo = self.photos[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:photoAtCurrentIndex.imageName];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSString *sectionNameToTest = self.sections[section];
    
    NSLog(@"sectionNameToTest: %@", sectionNameToTest);
    
    NSInteger numOfPhotosInSection = 0;
    
    for (Photo *photo in self.photos) {
        
        NSString *sectionName;
        
        if (self.photoSort == PhotoSortSubject) {
            sectionName = photo.subject;
        } else if (self.photoSort == PhotoSortLocation) {
            sectionName = photo.location;
        }
        
        if ([sectionName isEqual:sectionNameToTest]) {
            // The section name to test
            // is equal to the current photo's sectionName - example: travel (if a subject) OR Australia (if a location)
            numOfPhotosInSection++;
        }
    }
    
    NSLog(@"Number of photos in section: %li", numOfPhotosInSection);
    
    return numOfPhotosInSection;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    self.sections = [NSMutableArray new];
    for (Photo *photo in self.photos) {
        
        NSString *sectionName;
        
        if (self.photoSort == PhotoSortSubject) {
            sectionName = photo.subject;
        } else if (self.photoSort == PhotoSortLocation) {
            sectionName = photo.location;
        }
        
        if (![self.sections containsObject:sectionName]) {
            // The section is not yet recorded in the array
            [self.sections addObject:sectionName];
        }
    }
    
    NSLog(@"Number of sections: %li", self.sections.count);
    NSLog(@"\n");
    
    return self.sections.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        PhotoSectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"photoSectionHeader" forIndexPath:indexPath];
        
        headerView.sectionHeaderLabel.text = self.sections[indexPath.section];
        
        reusableview = headerView;
    }
    
//    if (kind == UICollectionElementKindSectionFooter) {
//        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
//        
//        reusableview = footerview;
//    }
    
    return reusableview;
}

@end
