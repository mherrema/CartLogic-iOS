//
//  NewTicketViewController.m
//  CartLogic
//
//  Created by Mitch Herrema on 10/11/14.
//  Copyright (c) 2014 Mitch Herrema. All rights reserved.
//

#import "NewTicketViewController.h"

@interface NewTicketViewController ()
@property (strong, nonatomic) NSArray *array;
@property (strong,nonatomic) NSArray *results;
@end

@implementation NewTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.array = [[NSArray alloc] initWithObjects:@"Apple", @"Samsung", @"HTC", @"LG", nil];
    self.results = [[NSArray alloc] init];
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

#pragma Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return [self.results count];
        
    }
    else{
        return [self.array count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if(tableView == self.searchDisplayController.searchResultsTableView){
        cell.textLabel.text = [self.results objectAtIndex:indexPath.row];
    }
    else{
        cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    }
    return cell;
}

#pragma Search Methods

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *) scope
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", searchText];
    self.results = [self.array filteredArrayUsingPredicate:predicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

@end
