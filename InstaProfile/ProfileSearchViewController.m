//
//  ProfileSearchViewController.m
//  InstaProfile
//
//  Created by meliot on 05/08/2019.
//  Copyright © 2019 meliot. All rights reserved.
//

#import "ProfileSearchViewController.h"

@interface ProfileSearchViewController ()

@end

@implementation ProfileSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _profiles = [[NSMutableArray alloc] init];
    
    _searchButton.layer.borderWidth = 1.5f;
    _searchButton.layer.borderColor = [UIColor blackColor].CGColor;
    _searchButton.layer.cornerRadius = 12.0f;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"SEE YA THERE");
    
    // Fetching the correct segue :)
    if ([[segue identifier] isEqualToString:@"searchProfileSegue"]) {
        NSLog(@"AAAAA CHE BELLO");
        [self.view endEditing:YES]; // FIXME: ?
        //_usersData = [NSMutableArray array];
        
        NSString *username = [_searchProfileField text];
        if ([username isEqual: @""]) {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Error!"
                                         message:@"Username can't be empty"
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"Ok"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           //Handle your yes please button action here
                                           return;
                                       }];
            [alert addAction:okButton];
            
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            NSLog(@"Letta la stringa %@", username);
            NSString *searchUrl = [NSString stringWithFormat:@"https://www.instagram.com/web/search/topsearch/?&query=%@", username];
            
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setHTTPMethod:@"GET"];
            [request setURL:[NSURL URLWithString:searchUrl]];
            
            [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
              ^(NSData * _Nullable data,
                NSURLResponse * _Nullable response,
                NSError * _Nullable error) {
                  if (data == nil) {
                      NSLog(@"Nessun dato");
                      //[self printCannotLoad];
                  } else {
                      self.profiles = [[NSMutableArray alloc] init];
                      [self parseProfiles:data];
                      ProfileTableViewController *tableViewController = [segue destinationViewController];
                      tableViewController.profiles = self.profiles;
                      //NSLog(@"A: %d", [tableViewController.profiles count]);
                      //NSLog(@"B: %d", [_profiles count]);
                      [tableViewController tocLoad];
                      //NSLog(@"Just refreshed");
                  }
                  
              }] resume];
        }
        
        

    }
}

- (void) parseProfiles:(NSData *) jsonData {
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:jsonData
                 options:0
                 error:&error];
    
    if(error) {
        //[self printCannotLoad];
        NSLog(@"Nessun dato");
        //[self printCannotLoad];
        return;
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        
        NSArray *users = [object valueForKey:@"users"];
        // NSLog(@"Users: %@", users);
        
        int i = 0;
        for (NSDictionary *userContainer in users) {
            NSDictionary *user = userContainer[@"user"];
            i++;
            
            // Fetching data from dictionary
            NSString *imageurl = user[@"profile_pic_url"];
            NSString *fullname = user[@"full_name"];
            NSString *username = user[@"username"];
            NSString *userid = user[@"pk"];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageurl]]];
            
            UserProfile *p = [UserProfile alloc];
            p = [p initWithId:userid andFullname:fullname andImage:image andUsername:username];
            
            NSLog(@"%@ (%@)", p.fullname, p.username);
            
            [_profiles addObject:p];
            
            if (i == USERLIST_SIZE) break;
        }
        
    } else {
        NSLog(@"Nessun dato");
        //[self printCannotLoad];
    }
    
}

- (IBAction)searchProfileClick:(id)sender {
     
}

@end
