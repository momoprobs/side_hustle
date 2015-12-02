//
//  ProfileVC.m
//  SideHustle
//
//  Created by Andrew Molina on 11/29/15.
//  Copyright © 2015 annayelizarova. All rights reserved.
//

#import "ProfileVC.h"

@interface ProfileVC () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    UIImage *newImage = [UIImage imageNamed:self.currentProfileUser.profileName];
    self.profileImage.image = newImage;
    
    float scaleFactor = self.profileImage.frame.size.width / newImage.size.width;
    self.profileImage.frame = CGRectMake(0, -75, self.profileImage.frame.size.width, newImage.size.height * scaleFactor);
    self.scrollView.contentSize = self.profileImage.frame.size;
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
