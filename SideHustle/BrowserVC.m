//
//  BrowserVC.m
//  SideHustle
//
//  Created by Andrew Molina on 11/29/15.
//  Copyright © 2015 annayelizarova. All rights reserved.
//

#import "BrowserVC.h"
#import "User.h"
#import "ProfileVC.h"

#define ProfileSegueIdentifier @"profileSegue"
#define HistoryCellIdentifier @"historyCellID"


@interface BrowserVC () <UITableViewDataSource, UITableViewDelegate, ServiceManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *blurbLabel;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *discoveryButton;
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;
@property (strong, nonatomic) User *currentUser;
@property (strong, nonatomic) User *connectedUser;
@property (strong, nonatomic) User *profileToDisplay;
@property (strong, nonatomic) NSMutableArray *historyArray;
@property (strong, nonatomic) ServiceManager *service;


@end

@implementation BrowserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initProfiles];
    
    
    //Set up discoverable button
    self.discoveryButton.enabled = NO;
    [self.discoveryButton setImage:[UIImage imageNamed:@"discoverable_button.png"] forState:UIControlStateNormal];
    
    self.historyTableView.dataSource = self;
    self.historyTableView.delegate = self;
    
    self.service = [[ServiceManager alloc] init];
    self.service.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didClickEditButton:(id)sender {
    
    NSLog(@"EDit");
    self.profileToDisplay = self.currentUser;
    [self performSegueWithIdentifier:ProfileSegueIdentifier sender:self];
}

- (IBAction)didClickDiscoveryButton:(id)sender {
    
    NSLog(@"Discover");
    self.profileToDisplay = self.connectedUser;
    [self performSegueWithIdentifier:ProfileSegueIdentifier sender:self];
}

- (void)initProfiles {
    
    self.currentUser = [[User alloc] init];
    self.currentUser.name = @"Me";
    self.currentUser.imageName = @"anna_profile.png";
    self.currentUser.blurb = @"Write a blurb";
    self.currentUser.daysAgo = @"3 days ago";
    self.currentUser.locationSeen = @"Mission Street";
    
    self.connectedUser = [[User alloc] init];
    self.connectedUser.name = @"Anna Y";
    self.connectedUser.imageName = @"anna_profile.png";
    self.connectedUser.blurb = @"Aspiring fashion designer";
    self.connectedUser.daysAgo = @"2 days ago";
    self.connectedUser.locationSeen = @"Mission Street";
    
    //Set up own profile
    self.nameLabel.text = self.currentUser.name;
    self.blurbLabel.text = self.currentUser.blurb;
    [self.profileImage setImage:[UIImage imageNamed:self.currentUser.imageName]];
    
    self.historyArray = [[NSMutableArray alloc] init];
    
    User *newUser0 = [[User alloc] init];
    newUser0.name = @"Katie";
    newUser0.imageName = @"katie_profile.png";
    newUser0.blurb = @"Singer Songwriter";
    newUser0.daysAgo = @"2 days ago";
    newUser0.locationSeen = @"Market Street";
    newUser0.cellImageName = @"images/Katie_cell.png";
    [self.historyArray addObject:newUser0];
    
    User *newUser1 = [[User alloc] init];
    newUser1.name = @"John";
    newUser1.imageName = @"john_profile.png";
    newUser1.blurb = @"Indie Filmmaker";
    newUser1.daysAgo = @"5 days ago";
    newUser1.locationSeen = @"Mission Street";
    newUser1.cellImageName = @"images/John_cell.png";
    [self.historyArray addObject:newUser1];
    
    User *newUser2 = [[User alloc] init];
    newUser2.name = @"Matt";
    newUser2.imageName = @"matt_profile.png";
    newUser2.blurb = @"I paint";
    newUser2.daysAgo = @"7 days ago";
    newUser2.locationSeen = @"Van Ness Street";
    newUser2.cellImageName = @"images/Matt_cell.png";
    [self.historyArray addObject:newUser2];
    
    User *newUser3 = [[User alloc] init];
    newUser3.name = @"Jordan";
    newUser3.imageName = @"jordan_profile.png";
    newUser3.blurb = @"Master Puppeteer";
    newUser3.daysAgo = @"8 days ago";
    newUser3.locationSeen = @"Embarcadero Street";
    newUser3.cellImageName = @"images/Jordan_cell.png";
    [self.historyArray addObject:newUser3];
    
}

#pragma mark - ServiceManagerDelegate Methods

- (void)connectedDevicesChanged:(ServiceManager *)manager connectedDevices:(NSArray<NSString *> *)connectedDevices {
    
    self.discoveryButton.enabled = YES;
    [self.discoveryButton setBackgroundImage:[UIImage imageNamed:self.connectedUser.imageName] forState:UIControlStateNormal];
    [self.historyArray insertObject:self.connectedUser atIndex:0];
    [self.historyTableView reloadData];
}

- (void)profileChanged:(ServiceManager *)manager contentString:(NSString *)contentString {
    
    return;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HistoryCellIdentifier];
    
    User *cellUser = self.historyArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:cellUser.cellImageName];
    UIImageView *cellImage = (UIImageView *)[cell viewWithTag:1];
    cellImage.image = [UIImage imageNamed:cellUser.cellImageName];
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.historyArray.count;
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.profileToDisplay = (User *)self.historyArray[indexPath.row];
    NSLog(@"Table");
    [self performSegueWithIdentifier:ProfileSegueIdentifier sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    ProfileVC *profile = (ProfileVC *)[segue destinationViewController];
    profile.currentProfileUser = self.profileToDisplay;
}


@end
