//
//  ProfileVC.m
//  SideHustle
//
//  Created by Andrew Molina on 11/29/15.
//  Copyright © 2015 annayelizarova. All rights reserved.
//

#import "ProfileVC.h"

@interface ProfileVC ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.profileImage.image = [UIImage imageNamed:self.currentProfileUser.profileName];
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
