//
//  ProfileDetailViewController.m
//  InstaProfile
//
//  Created by meliot on 01/08/2019.
//  Copyright © 2019 meliot. All rights reserved.
//

#import "ProfileDetailViewController.h"

@interface ProfileDetailViewController ()

@end

@implementation ProfileDetailViewController

@synthesize user;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Filling labels
    self.title = user.username;
    self.nameLabel.text = user.fullname;
    self.highResImage.image = user.image;
    self.biographyLabel.text = user.description;
    self.highResImage.layer.cornerRadius = (self.highResImage.frame.size.width - 40 )/2;
    self.highResImage.clipsToBounds = YES;
    [self setHighResolutionImage:user.userid];
    self.biographyLabel.text = user.biography;
}

- (void) setHighResolutionImage:(NSString *)userid {
    // Thanks to: https://github.com/rarcega/instagram-scraper/issues/193

    NSString *url = [NSString stringWithFormat:@"https://i.instagram.com/api/v1/users/%@/info/", userid];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          //NSLog(@"Data: %@", data);
          if (data == nil) {
              //[self printCannotLoad];
              NSLog(@"Error with data (is nil)");
          } else {
              NSError *error = nil;
              id object = [NSJSONSerialization
                           JSONObjectWithData:data
                           options:0
                           error:&error];
              
              if(error) {
                  NSLog(@"Error: JSONSerialization");
                  return;
              }
              if ([object isKindOfClass:[NSDictionary class]]) {
                  // Getting user array with all data from "info" api.
                  NSArray *userArray = [object valueForKey:@"user"];
                  
                  
                  
                  // Setting HD image on ImageView
                  //NSLog(@"User: %@", userArray);
                  NSArray *hdProfileInfo = [userArray valueForKey:@"hd_profile_pic_url_info"];
                  
                  NSString *finalUrl =[hdProfileInfo valueForKey:@"url"];
                  
                  // Updating biography label
                  NSString *biography = [userArray valueForKey:@"biography"];

                  dispatch_async(dispatch_get_main_queue(), ^{
                      self.biographyLabel.text = biography;
                  });
                  self.user.biography = biography;
                  
                  UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:finalUrl]]];
                  self.user.image = image;
                  dispatch_async(dispatch_get_main_queue(), ^{
                      self.highResImage.image = image;
                      self.highResImage.layer.cornerRadius = self.highResImage.frame.size.width/2;
                      self.highResImage.clipsToBounds = YES;
                  });
                  self.fullResolutionURL = finalUrl;
                  return;
              }
          }
      }] resume];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)clickDownloadButton:(UIButton *)sender {
    NSArray *shareItems = @[user.image];
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    [self presentViewController:avc animated:YES completion:nil];
    
}
@end
