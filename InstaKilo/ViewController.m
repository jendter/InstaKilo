//
//  ViewController.m
//  InstaKilo
//
//  Created by Josh Endter on 6/25/15.
//  Copyright (c) 2015 Josh Endter. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCollectionViewCell.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *imageNames;
//@property (nonatomic, strong) NSMutableDictionary *imagesNamesToProperties;

@property (nonatomic, strong) NSDictionary *imagesToProperties;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // REMEMBER, I ADDED A BACKGROUND TO THE PHOTO VIEW
    
    self.imageNames = @[@"australia", @"bridge", @"california", @"california2", @"california3", @"california4", @"cat", @"cat2", @"coast", @"forest", @"park", @"waiting", @"winter"];
//
//    for (NSString *imageName in self.imageNames) {
//        
//    }
    
    self.imagesToProperties = @{
                                @"australia" : @"travel",
                                @"bridge" : @"park",
                                @"california" : @"travel",
                                @"california2" : @"travel",
                                @"california3" : @"travel",
                                @"california4" : @"travel",
                                @"cat" : @"animal",
                                @"cat2" : @"animal",
                                @"coast" : @"travel",
                                @"forest" : @"hiking",
                                @"park" : @"hiking",
                                @"waiting" : @"animal",
                                @"winter" : @"weather",
                                };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    //cell.imageView.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    
    NSString *imageName = self.imageNames[indexPath.row];
    NSString *imageSubject = [self.imagesToProperties objectForKey:imageName];
    
    NSLog(@"Name: %@, Subject: %@", imageName, imageSubject);
    
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 13; //13
}

@end
