//
//  ProfileDetailViewController.h
//  InstaProfile
//
//  Created by meliot on 01/08/2019.
//  Copyright © 2019 meliot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileDetailViewController : UIViewController
@property (weak, nonatomic) UserProfile *user;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIImageView *highResImage;
@property (weak, nonatomic) IBOutlet UILabel *biographyLabel;
- (IBAction)clickDownloadButton:(UIButton *)sender;
@property NSString *fullResolutionURL;

@end

NS_ASSUME_NONNULL_END
