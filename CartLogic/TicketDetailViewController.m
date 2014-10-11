//
//  TicketDetailViewController.m
//  CartLogic
//
//  Created by Mitch Herrema on 10/11/14.
//  Copyright (c) 2014 Mitch Herrema. All rights reserved.
//

#import "TicketDetailViewController.h"

@interface TicketDetailViewController ()

@end

@implementation TicketDetailViewController

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.ticketLocationLabel.text = [self.detailItem objectForKey:@"location" ];
        self.ticketStatusLabel.text = [self.detailItem objectForKey:@"status"];
        NSArray* cartTypeArray = [[self.detailItem objectForKey:@"cart_type"] componentsSeparatedByString: @"-"];
        self.ticketCartSize.text = [cartTypeArray objectAtIndex:0];
        self.ticketCartType.text = [cartTypeArray objectAtIndex:1];
        self.ticketType.text = [self.detailItem objectForKey:@"service_type" ];
    }
}

+(NSString *) fullType:(id)shortType{
    NSString *result;
    if (shortType != nil) {
        if ([shortType  isEqual: @"DEL"]) {
            result = @"Delivery";
        } else if ([shortType  isEqual: @"EX-REM"]) {
            result = @"Exchange Removal";
        } else if ([shortType  isEqual: @"EX-DEL"]) {
            result = @"Exchange Delivery";
        } else if ([shortType  isEqual: @"REM"]) {
            result = @"Removal";
        } else if ([shortType  isEqual: @"REP"]) {
            result = @"Repair";
        }
    }
    return result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
