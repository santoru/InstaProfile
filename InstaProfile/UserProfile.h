//
//  UserProfile.h
//  InstaProfile
//
//  Created by meliot on 01/08/2019.
//  Copyright © 2019 meliot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserProfile : NSObject
@property UIImage *image;
@property NSString *fullname;
@property(nonatomic, readwrite) NSString *username;
@property(nonatomic, readwrite) NSString *userid;
@property(nonatomic, readwrite) NSString *biography;
- (id)initWithId:(NSString *)userid
       andFullname:(NSString *)fullname
        andImage:(UIImage *)image
     andUsername:(NSString *)username;
@end

NS_ASSUME_NONNULL_END
