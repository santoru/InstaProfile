//
//  ProfilesTableViewController.h
//  InstaProfile
//
//  Created by meliot on 01/08/2019.
//  Copyright © 2019 meliot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"
#import "ProfileDetailViewController.h"
NS_ASSUME_NONNULL_BEGIN

extern const double USERLIST_SIZE;

@interface ProfileTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *profileTableView;
@property (weak, nonatomic) NSMutableArray *profiles;
- (void) tocLoad;

@end

NS_ASSUME_NONNULL_END
