//
//  HomeViewController.m
//  Rabbit
//
//  Created by Cookie Gu on 15/12/12.
//  Copyright © 2015年 Cookrin. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    PFQuery *itemQuery = [PFQuery queryWithClassName:@"Item"];
    [itemQuery whereKey:@"isAvailable" equalTo:@"true"];
    //[itemQuery orderByDescending:@"createdAt"];
    [itemQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@, %@", error, [error userInfo]);
        } else {
            self.allAvailableItems = objects;
            // get current user
            self.currentUser = [PFUser currentUser];
            // do not forget reload data!
            [self.tableView reloadData];
        }
    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source
//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.allAvailableItems count];
}

// setup tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    PFObject *item = [self.allAvailableItems objectAtIndex:indexPath.row];

    cell.textLabel.text = [item objectForKey:@"name"];
    // Configure the cell...

    return cell;
}

// did select cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // enter the item detail view controller
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;

    PFRelation *likeRelaton = [self.currentUser relationForKey:@"likeRelation"];
    PFObject *item = [self.allAvailableItems objectAtIndex:indexPath.row];
    [likeRelaton addObject:item];
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"saving currentUser succeeded");
        } else {
            NSLog(@"Error %@ %@", error, [error userInfo]);
        }
    }];
    //[self performSegueWithIdentifier:@"showItemDetail" sender:self];
    
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation

// hide bottom bar

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"showLogin"]) {
//        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
//    }
//}

@end
