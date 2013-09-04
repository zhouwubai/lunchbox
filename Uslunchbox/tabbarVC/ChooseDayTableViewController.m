//
//  ChooseDayTableViewController.m
//  Uslunchbox
//
//  Created by Wubai Zhou on 9/1/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import "ChooseDayTableViewController.h"
#import "menuTableViewController.h"
#import "NSDate+format.h"

@interface ChooseDayTableViewController ()

@end

@implementation ChooseDayTableViewController

@synthesize weekDates = _weekDates;


-(NSArray *)weekDates
{
    if(_weekDates == nil){
        _weekDates = [NSMutableArray array];
        _weekDates = [self calculateWeekDates]; // compute once
        //        NSLog(@"someting happens");
    }
    //    NSLog(@"nothing happens");
    return _weekDates;
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
    
    //    [self setTitle:@"choose day"];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self weekDates] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"weekday cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE,yyyy-MM-dd"];
    NSDate *date =[[self weekDates] objectAtIndex:indexPath.row];
    //    NSLog(@"%d",indexPath.section);
    //    NSLog(@"%d",indexPath.row);
    NSArray *dateInfos = [[dateFormatter stringFromDate:date] componentsSeparatedByString:@","];
    
    cell.textLabel.text = [dateInfos objectAtIndex: 0];
    cell.detailTextLabel.text = [dateInfos objectAtIndex: 1];
    
    //    NSLog(@"table");
    
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




#pragma mark - User Defined

-(NSMutableArray*) calculateWeekDates
{
    NSDate *today = [NSDate date];
    NSLog(@"Today date is %@",today);
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    //begining day of week which includes today
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    //consistent with system preference.
    int dayOfweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:today] weekday];
    //first day(sunday of a week)
    NSDateComponents *componentsToSubstract = [[NSDateComponents alloc] init];
    [componentsToSubstract setDay:0 - (dayOfweek - 1)];
    NSDate *nextDay = [gregorian dateByAddingComponents:componentsToSubstract toDate:today options:0];
    
    // add monday to friday
    NSMutableArray *daysOfWholeWeek = [NSMutableArray array];
    [componentsToSubstract setDay:1];
    
    for(int i = 0; i < 5; i++){
        nextDay = [gregorian dateByAddingComponents:componentsToSubstract toDate:nextDay options:0];
        [daysOfWholeWeek addObject:nextDay];
    }
    
    return daysOfWholeWeek;
    
}



- (IBAction)backToChooseSite:(UIBarButtonItem *)sender {
    
    [[[self navigationController] navigationController] popViewControllerAnimated:YES];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NSDate *weekDate = [self.weekDates objectAtIndex:indexPath.row];
    
    
    if ([segue.destinationViewController isMemberOfClass:[menuTableViewController class]]) {
        NSLog(@"TRUE");
    }
    
    [segue.destinationViewController performSelector:@selector(setDate:) withObject:weekDate];
    [segue.destinationViewController performSelector:@selector(setDateStr:) withObject:[[weekDate class] formatWeekDate:weekDate ToFormat:@"yyyy-MM-dd"]];
}



@end
