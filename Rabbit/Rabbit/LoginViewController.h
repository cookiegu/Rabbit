//
//  LoginViewController.h
//  Rabbit
//
//  Created by Cookie Gu on 15/12/17.
//  Copyright © 2015年 Cookrin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)login:(id)sender;

@end
