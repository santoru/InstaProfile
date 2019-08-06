//
//  UserProfile.m
//  InstaProfile
//
//  Created by meliot on 01/08/2019.
//  Copyright © 2019 meliot. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile
- (id)initWithId:(NSString *)userid
     andFullname:(NSString *)fullname
        andImage:(UIImage *)image
     andUsername:(NSString *)username;
{
    if( self = [super init] )
    {
        self.userid = userid;
        self.fullname = fullname;
        self.username = username;
        self.image = image;
        
    }
    
    return self;
}
@end
