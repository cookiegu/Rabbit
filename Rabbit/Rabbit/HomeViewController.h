//
//  HomeViewController.h
//  Rabbit
//
//  Created by Cookie Gu on 15/12/12.
//  Copyright © 2015年 Cookrin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface HomeViewController : UITableViewController

@property (nonatomic, strong) NSArray *allUsers;
@property (nonatomic, strong) NSArray *allAvailableItems;
@property (nonatomic, strong) PFUser *currentUser;

@end
