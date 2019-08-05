//
//  ProfileSearchViewController.h
//  InstaProfile
//
//  Created by meliot on 05/08/2019.
//  Copyright © 2019 meliot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UserProfile.h"
#import "ProfileTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileSearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITextField *searchProfileField;
@property (strong, nonatomic) NSMutableArray *profiles;

- (IBAction)searchProfileClick:(id)sender;

@end

NS_ASSUME_NONNULL_END
