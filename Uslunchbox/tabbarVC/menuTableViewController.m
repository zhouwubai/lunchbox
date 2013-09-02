//
//  menuTableViewController.m
//  Uslunchbox
//
//  Created by Wubai Zhou on 9/1/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import "menuTableViewController.h"
#import "Dish.h"

@interface menuTableViewController ()

@end

@implementation menuTableViewController


@synthesize date = _date;
@synthesize dateStr = _dateStr;
@synthesize dishes = _dishes;


-(NSMutableArray *)dishes
{
    if(_dishes == nil){
        _dishes = [self fetchDishes];
    }
    
    return _dishes;
}



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self test];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self dishes] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"menu cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Dish *tmpDish = [[self dishes] objectAtIndex:indexPath.row];
    cell.textLabel.text = [tmpDish dishName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"price: %f",[tmpDish dishPrice]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


-(void)test
{
//    NSURL *url = [NSURL URLWithString:@"http://uslunchbox.com/uslunchbox/OnlineOrderScheduleServlet"];
    NSString *url = @"http://uslunchbox.com/uslunchbox/OnlineOrderScheduleServlet";
    NSString *dateStr = @"2013-08-29";
//    [self postRequestDishMenuTo:url withSiteID:1 withCategory:0 inDay:dateStr];
    [Dish executeDishFetch:url withSiteID:1 withCategory:0 inDay:dateStr];
}



-(NSMutableArray *) fetchDishes
{
    NSString *url = @"http://uslunchbox.com/uslunchbox/OnlineOrderScheduleServlet";
    NSString *dateStr = @"2013-08-29";
    
    NSArray *dishes = [[Dish executeDishFetch:url withSiteID:1 withCategory:0 inDay:dateStr] objectForKey:@"dishes"];
    NSMutableArray *rtnDishes = [NSMutableArray array];
    for(NSDictionary *dish in dishes){
        Dish *tmpDish = [[Dish alloc] init];
        NSLog(@"%@",tmpDish);
        int dishID = [[dish objectForKey:@"id"] integerValue];
        [tmpDish setDishID:dishID];
        double price = [[dish objectForKey:@"price"] doubleValue];
        [tmpDish setDishPrice:price];
        NSString *dishName = [dish objectForKey:@"name"];
        [tmpDish setDishName:dishName];
        [rtnDishes addObject:tmpDish];
    }
    
    return rtnDishes;
}



-(NSMutableArray *) postRequestDishMenuTo:(NSURL *)url withSiteID:(int)siteID withCategory:(int)cID inDay:(NSString *)dateStr
{

//    NSString *post = [[NSString alloc] initWithFormat:@"siteid=%d&date=%@&categoryid=%d",siteID,dateStr,cID];
    NSString *post = @"siteid=1&date=2013-08-29&categoryid=0";
    NSLog(@"%@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"get"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];

    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    
    NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"Response code: %d",[response statusCode]);
    
    if ([response statusCode] >= 200 && [response statusCode] < 300) {
        NSLog(@"success");
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
        
        NSLog(@"%@",json);
        NSLog(@"%@",urlData);
        return nil;
        
    }else{
        if(error) NSLog(@"Error: %@",error);
        return nil;
    }
    
    
}











































@end
