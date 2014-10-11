//
//  ServiceTicketsTableViewController.h
//  CartLogic
//
//  Created by Mitch Herrema on 10/10/14.
//  Copyright (c) 2014 Mitch Herrema. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceTicketsTableViewController : UITableViewController<NSURLConnectionDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *_activityIndicator;
@property (strong,nonatomic) NSMutableArray *tickets;
@property (strong,nonatomic) NSMutableData *_responseData;
@end
