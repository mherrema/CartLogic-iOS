//
//  ServiceTicketsTableViewController.m
//  CartLogic
//
//  Created by Mitch Herrema on 10/10/14.
//  Copyright (c) 2014 Mitch Herrema. All rights reserved.
//

#import "ServiceTicketsTableViewController.h"
#import "TicketDetailViewController.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

static NSString * const BaseURLString = @"http://www.raywenderlich.com/demos/weather_sample/";

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
////    // Create the request.
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://stage1.gocartlogic.com/api/2/ticket/list/?format=json"]];
//    
//    // 1

    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://stage1.gocartlogic.com/api/2/ticket/list/?format=json"]];
    
    NSString *accessKey = @"e2071ffb20017a8482a232617a2282a74005dc96";
    NSString *authHeader = [NSString stringWithFormat:@"Token %@", accessKey];
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    [mutableRequest addValue:authHeader forHTTPHeaderField:@"Authorization"];
    
    // Now set our request variable with an (immutable) copy of the altered request
    request = [mutableRequest copy];
    
    [__activityIndicator setHidden:NO];
    [__activityIndicator startAnimating];
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [__activityIndicator setHidden:YES];
        [__activityIndicator stopAnimating];
        // 3
        NSDictionary *jsonObject = (NSDictionary *)responseObject;
//        self.title = @"JSON Retrieved";
        self.tickets = [jsonObject objectForKey:@"results"];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [__activityIndicator setHidden:YES];
        [__activityIndicator stopAnimating];
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Tickets"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
    
    
//
//    // Create url connection and fire request
//    
//    
//    // Create a mutable copy of the immutable request and add more headers
//    NSMutableURLRequest *mutableRequest = [request mutableCopy];
//    [mutableRequest addValue:authHeader forHTTPHeaderField:@"Authorization"];
//    
//    // Now set our request variable with an (immutable) copy of the altered request
//    request = [mutableRequest copy];
//    
//    // Log the output to make sure our new headers are there
//    NSLog(@"%@", request.allHTTPHeaderFields);
//    
//    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//
    
    
    
//    
//    NSURL* url = [NSURL URLWithString:@"http://stage1.gocartlogic.com/api/2/ticket/list/?format=json"];
//    NSMutableURLRequest* urlRequest = [NSURLRequest requestWithURL:url];
//    NSString *accessKey = @"e2071ffb20017a8482a232617a2282a74005dc96";
//    NSString *authHeader = [NSString stringWithFormat:@"Token %@", accessKey];
//    [urlRequest addValue:authHeader forHTTPHeaderField:@"Authorization"];
////    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
//    
//    [NSURLConnection sendAsynchronousRequest:urlRequest
//                                       queue:queue
//                           completionHandler:^(NSURLResponse* response,
//                                               NSData* data,
//                                               NSError* error)
//    {
//        if (data) {
//            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
//            // check status code and possibly MIME type (which shall start with "application/json"):
//            NSRange range = [response.MIMEType rangeOfString:@"application/json"];
//            
//            if (httpResponse.statusCode == 200 /* OK */ && range.length != 0) {
//                NSError* error;
//                id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//                if (jsonObject) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        // self.model = jsonObject;
//                        NSLog(@"jsonObject: %@", jsonObject);
//                    });
//                } else {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        //[self handleError:error];
//                        NSLog(@"ERROR: %@", error);
//                    });
//                }
//            }
//            else {
//                // status code indicates error, or didn't receive type of data requested
//                NSString* desc = [[NSString alloc] initWithFormat:@"HTTP Request failed with status code: %d (%@)",
//                                  (int)(httpResponse.statusCode),
//                                  [NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode]];
//                NSError* error = [NSError errorWithDomain:@"HTTP Request"
//                                                     code:-1000
//                                                 userInfo:@{NSLocalizedDescriptionKey: desc}];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //[self handleError:error];  // execute on main thread!
//                    NSLog(@"ERROR: %@", error);
//                });
//            }
//        }
//        else {
//            // request failed - error contains info about the failure
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //[self handleError:error]; // execute on main thread!
//                NSLog(@"ERROR: %@", error);
//            });
//        }
//    }];
//    
//
//    
//    
//    // Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//    
//    NSURL *url = [NSURL URLWithString:@"http://stage1.gocartlogic.com/api/2/ticket/list/?format=json"];
//    NSString *accessKey = @"e2071ffb20017a8482a232617a2282a74005dc96";
//    NSError *myError = nil;
//    
//    // create the contents of the header
//    NSString *authHeader = [NSString stringWithFormat:@"Token %@", accessKey];
//    
//    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL: url
//                                                           cachePolicy: NSURLRequestReloadIgnoringCacheData
//                                                       timeoutInterval: 3];
//    
//    // add the header to the request.  Here's the $$$!!!
//    [request2 addValue:authHeader forHTTPHeaderField:@"Authorization"];
//    
//    // perform the reqeust
//    NSURLResponse *response;
//    
//    NSData *data = [NSURLConnection
//                    sendSynchronousRequest: request2
//                    returningResponse: &response
//                    error: &myError];
//    // POW, here's the content of the webserver's response.
//    if(data == nil){
//        
//    }
//    else{
//    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    self.tickets = [jsonObject objectForKey:@"results"];
//    }
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

//#pragma mark NSURLConnection Delegate Methods

//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    // A response has been received, this is where we initialize the instance var you created
//    // so that we can append data to it in the didReceiveData method
//    // Furthermore, this method is called each time there is a redirect so reinitializing it
//    // also serves to clear it
//    __responseData = [[NSMutableData alloc] init];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    // Append the new data to the instance variable you declared
//    
//    [__responseData appendData:data];
//    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    self.tickets = [jsonObject objectForKey:@"results"];
//}
//
//- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
//                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
//    // Return nil to indicate not necessary to store a cached response for this connection
//    return nil;
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    // The request is complete and data has been received
//    // You can parse the stuff in your instance variable now
//    
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    // The request has failed for some reason!
//    // Check the error var
//}

@end
