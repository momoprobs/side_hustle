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
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (assign, nonatomic) BOOL didConnect;


@end

@implementation BrowserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initProfiles];
    
    
    //Set up discoverable button
    self.discoveryButton.enabled = NO;
    [self.discoveryButton setImage:[UIImage imageNamed:@"images/discoverable_button.png"] forState:UIControlStateNormal];
    
    self.historyTableView.dataSource = self;
    self.historyTableView.delegate = self;
    
    self.service = [[ServiceManager alloc] init];
    self.service.delegate = self;
    
    self.didConnect = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didClickResetButton:(id)sender {
    
    [self initProfiles];
    
    self.discoveryButton.enabled = NO;
    [self.discoveryButton setImage:[UIImage imageNamed:@"images/discoverable_button.png"] forState:UIControlStateNormal];
    
    self.service = [[ServiceManager alloc] init];
    self.service.delegate = self;
    
    self.didConnect = NO;
    
    [self.historyTableView reloadData];
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
    self.currentUser.imageName = @"images/me_photo.png";
    self.currentUser.blurb = @"Write a blurb";
    self.currentUser.profileName = @"images/Group.png";
    self.currentUser.daysAgo = @"3 days ago";
    self.currentUser.cellImageName = @"images/Jordan_cell.png";
    self.currentUser.locationSeen = @"Mission Street";
    
    self.connectedUser = [[User alloc] init];
    self.connectedUser.name = @"Anna Y";
    self.connectedUser.imageName = @"images/anna_photo.png";
    self.connectedUser.profileName = @"images/anna_profile.png";
    self.connectedUser.blurb = @"Aspiring fashion designer";
    self.connectedUser.cellImageName = @"images/Anna_cell.png";
    self.connectedUser.daysAgo = @"2 days ago";
    self.connectedUser.locationSeen = @"Mission Street";
    
    
    //TURN THIS ON FOR OTHER USER
    /*
    User *temp = self.currentUser;
    self.currentUser = self.connectedUser;
    self.connectedUser = temp;
    */
    
    //Set up own profile
    self.nameLabel.text = self.currentUser.name;
    self.blurbLabel.text = self.currentUser.blurb;
    [self.profileImage setImage:[UIImage imageNamed:self.currentUser.imageName]];
    
    self.historyArray = [[NSMutableArray alloc] init];
    
    User *newUser0 = [[User alloc] init];
    newUser0.name = @"Katie";
    newUser0.imageName = @"images/katie_phto.png";
    newUser0.blurb = @"Singer Songwriter";
    newUser0.daysAgo = @"2 days ago";
    newUser0.locationSeen = @"Market Street";
    newUser0.cellImageName = @"images/Katie_cell.png";
    newUser0.profileName = @"images/katie_profile.png";
    [self.historyArray addObject:newUser0];
    
    User *newUser1 = [[User alloc] init];
    newUser1.name = @"John";
    newUser1.imageName = @"images/john_photo.png";
    newUser1.blurb = @"Indie Filmmaker";
    newUser1.daysAgo = @"5 days ago";
    newUser1.locationSeen = @"Mission Street";
    newUser1.cellImageName = @"images/John_cell.png";
    newUser1.profileName = @"images/john_profile.png";
    [self.historyArray addObject:newUser1];
    
    User *newUser2 = [[User alloc] init];
    newUser2.name = @"Matt";
    newUser2.imageName = @"images/matt_photo.png";
    newUser2.blurb = @"I paint";
    newUser2.daysAgo = @"7 days ago";
    newUser2.locationSeen = @"Van Ness Street";
    newUser2.cellImageName = @"images/Matt_cell.png";
    newUser2.profileName = @"images/matt_profile.png";
    [self.historyArray addObject:newUser2];
    
    User *newUser3 = [[User alloc] init];
    newUser3.name = @"Jordan";
    newUser3.imageName = @"images/jordan_photo.png";
    newUser3.blurb = @"Master Puppeteer";
    newUser3.daysAgo = @"8 days ago";
    newUser3.locationSeen = @"Embarcadero Street";
    newUser3.cellImageName = @"images/Jordan_cell.png";
    newUser3.profileName = @"images/jordan_profile.png";
    [self.historyArray addObject:newUser3];
    
}

#pragma mark - ServiceManagerDelegate Methods

- (void)connectedDevicesChanged:(ServiceManager *)manager connectedDevices:(NSArray<NSString *> *)connectedDevices {
    
    
    
    if (self.didConnect == NO) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.discoveryButton.enabled = YES;
            [self.discoveryButton setImage:[UIImage imageNamed:@"images/replace_button.png"] forState:UIControlStateNormal];
            [self.historyArray insertObject:self.connectedUser atIndex:0];
            [self.historyTableView reloadData];
            self.didConnect = YES;
        });
    }
}

- (void)profileChanged:(ServiceManager *)manager contentString:(NSString *)contentString {
    
    return;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HistoryCellIdentifier];
    
    User *cellUser = self.historyArray[indexPath.row];
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
