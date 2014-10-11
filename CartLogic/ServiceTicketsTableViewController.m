//
//  ServiceTicketsTableViewController.m
//  CartLogic
//
//  Created by Mitch Herrema on 10/10/14.
//  Copyright (c) 2014 Mitch Herrema. All rights reserved.
//

#import "ServiceTicketsTableViewController.h"
#import "TicketDetailViewController.h"

@interface ServiceTicketsTableViewController ()

@end

@implementation ServiceTicketsTableViewController


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showTicketDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = self.tickets[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    NSURL *url = [NSURL URLWithString:@"http://stage1.gocartlogic.com/api/2/ticket/list/?format=json"];
    NSString *accessKey = @"e2071ffb20017a8482a232617a2282a74005dc96";
    NSError *myError = nil;
    
    // create the contents of the header
    NSString *authHeader = [NSString stringWithFormat:@"Token %@", accessKey];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url
                                                           cachePolicy: NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval: 3];
    
    // add the header to the request.  Here's the $$$!!!
    [request addValue:authHeader forHTTPHeaderField:@"Authorization"];
    
    // perform the reqeust
    NSURLResponse *response;
    
    NSData *data = [NSURLConnection
                    sendSynchronousRequest: request
                    returningResponse: &response
                    error: &myError];
    // POW, here's the content of the webserver's response.
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.tickets = [jsonObject objectForKey:@"results"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.tickets count];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *ticket = [self.tickets objectAtIndex:indexPath.row];
    NSString *ticketID = [ticket objectForKey:@"location" ];
    cell.textLabel.text = ticketID;
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
