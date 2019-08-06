//
//  CustomTableViewCell.m
//  InstaProfile
//
//  Created by meliot on 06/08/2019.
//  Copyright © 2019 meliot. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _profileImageView.layer.cornerRadius = 30;
    _profileImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
