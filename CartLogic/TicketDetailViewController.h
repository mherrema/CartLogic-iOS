//
//  TicketDetailViewController.h
//  CartLogic
//
//  Created by Mitch Herrema on 10/11/14.
//  Copyright (c) 2014 Mitch Herrema. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketCartSize;
@property (weak, nonatomic) IBOutlet UILabel *ticketCartType;
@property (weak, nonatomic) IBOutlet UILabel *ticketType;

@end
