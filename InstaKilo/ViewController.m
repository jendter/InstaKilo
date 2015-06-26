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


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSMutableArray *sectionHeaders;
@property (nonatomic, strong) NSMutableDictionary *photosForSectionHeader;

@property (nonatomic) PhotoSort photoSort; // How the photos are currently sorted on screen (either by subject or location)


@property (weak, nonatomic) IBOutlet UISegmentedControl *photoSortSegmentedControl;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadSamplePhotos];
    
    [self updatePhotoSort:self];    // Triggers a reload, the same way pressing the segmented control in the nav bar would.
                                    // Keeps the segmented control default and the view in sync.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (IBAction)updatePhotoSort:(id)sender {
    if (self.photoSortSegmentedControl.selectedSegmentIndex == 0) {
        self.photoSort = PhotoSortSubject;
    } else if (self.photoSortSegmentedControl.selectedSegmentIndex == 1) {
        self.photoSort = PhotoSortLocation;
    }
    
    [self updatePhotoData];

    [self.collectionView reloadData];
}

-(void)updatePhotoData {
    
    // Get the section headers
    self.sectionHeaders = [NSMutableArray new];
    for (Photo *photo in self.photos) {
        
        NSString *sectionName;
        
        if (self.photoSort == PhotoSortSubject) {
            sectionName = photo.subject;
        } else if (self.photoSort == PhotoSortLocation) {
            sectionName = photo.location;
        }
        
        if (![self.sectionHeaders containsObject:sectionName]) {
            // The section is not yet recorded in the array
            [self.sectionHeaders addObject:sectionName];
        }
    }
    
    // Put the photos into the dictionary based on the key of the section name
    self.photosForSectionHeader = [NSMutableDictionary new];
    
    for (NSString *sectionHeader in self.sectionHeaders) {
        // For each section header
        
        // Make a temporary array to store all the photos that match the header
        NSMutableArray *photosInSection = [NSMutableArray new];

        for (Photo *photo in self.photos) {
            if (self.photoSort == PhotoSortSubject) {
                if ([photo.subject isEqual:sectionHeader]) {
                    [photosInSection addObject:photo];
                }
            } else if (self.photoSort == PhotoSortLocation) {
                if ([photo.location isEqual:sectionHeader]) {
                    [photosInSection addObject:photo];
                }
            }
        }
        
        [self.photosForSectionHeader setObject:[NSArray arrayWithArray:photosInSection] forKey:[NSString stringWithString:sectionHeader]];
    }
    
    
    NSLog(@"%@", self.photosForSectionHeader);
}


#pragma mark - Collection View

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    NSArray *photoArrayForSection = [self.photosForSectionHeader objectForKey:self.sectionHeaders[indexPath.section]];
    
    Photo *photoForIndex = photoArrayForSection[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:photoForIndex.imageName];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSString *sectionName = self.sectionHeaders[section];
    
    NSArray *arrayOfPhotosForSectionName = [self.photosForSectionHeader objectForKey:sectionName];
    
    return arrayOfPhotosForSectionName.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionHeaders.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        PhotoSectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"photoSectionHeader" forIndexPath:indexPath];
        
        headerView.sectionHeaderLabel.text = self.sectionHeaders[indexPath.section];
        
        reusableview = headerView;
    }
    
    /*
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"photoSectionFooter" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
     */
    
    return reusableview;
}


#pragma mark - Load data

-(void)loadSamplePhotos {
    
    Photo *photo1 = [Photo new];
    photo1.imageName = @"australia";
    photo1.subject = @"Travel";
    photo1.location = @"Australia";
    
    Photo *photo2 = [Photo new];
    photo2.imageName = @"bridge";
    photo2.subject = @"Hiking";
    photo2.location = @"Philadelphia";
    
    Photo *photo3 = [Photo new];
    photo3.imageName = @"california";
    photo3.subject = @"Travel";
    photo3.location = @"California";
    
    Photo *photo4 = [Photo new];
    photo4.imageName = @"california2";
    photo4.subject = @"Travel";
    photo4.location = @"California";
    
    Photo *photo5 = [Photo new];
    photo5.imageName = @"california3";
    photo5.subject = @"Travel";
    photo5.location = @"California";
    
    Photo *photo6 = [Photo new];
    photo6.imageName = @"california4";
    photo6.subject = @"Travel";
    photo6.location = @"California";
    
    Photo *photo7 = [Photo new];
    photo7.imageName = @"cat";
    photo7.subject = @"Animal";
    photo7.location = @"The Internet";
    
    Photo *photo8 = [Photo new];
    photo8.imageName = @"cat2";
    photo8.subject = @"Animal";
    photo8.location = @"The Internet";
    
    Photo *photo9 = [Photo new];
    photo9.imageName = @"coast";
    photo9.subject = @"Travel";
    photo9.location = @"Oregon";
    
    Photo *photo10 = [Photo new];
    photo10.imageName = @"forest";
    photo10.subject = @"Hiking";
    photo10.location = @"Philadelphia";
    
    Photo *photo11 = [Photo new];
    photo11.imageName = @"park";
    photo11.subject = @"Hiking";
    photo11.location = @"Philadelphia";
    
    Photo *photo12 = [Photo new];
    photo12.imageName = @"waiting";
    photo12.subject = @"Animal";
    photo12.location = @"The Internet";
    
    Photo *photo13 = [Photo new];
    photo13.imageName = @"winter";
    photo13.subject = @"Weather";
    photo13.location = @"Philadelphia";
    
    self.photos = @[photo1, photo2, photo3, photo4, photo5, photo6, photo7, photo8, photo9, photo10, photo11, photo12, photo13];
}

@end
