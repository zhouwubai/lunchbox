//
//  menuTableViewController.m
//  Uslunchbox
//
//  Created by Wubai Zhou on 9/1/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import "menuTableViewController.h"
#import "Dish.h"
#import "DishIconDownloader.h"

#define kCustomRowCount     5

@interface menuTableViewController ()
// the set of DishIconDownloader objects for each dish
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;
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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
    
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    
    [self.imageDownloadsInProgress removeAllObjects];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSUInteger count = [self.dishes count];
    
    // Return the number of rows in the section.
//    if(count == 0)
//    {
//        return kCustomRowCount;
//    }
    return [[self dishes] count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"menu cell";
    static NSString *PlaceholderCellIdentifier = @"PlaceholderCell";
    
    //add a placeholder cell while waiting on table data
    NSUInteger nodeCount = [self.dishes count];
    
    if (nodeCount == 0 && indexPath.row == 0){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PlaceholderCellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PlaceholderCellIdentifier];
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if(nodeCount > 0){
        Dish *tmpDish = [[self dishes] objectAtIndex:indexPath.row];
        cell.textLabel.text = [tmpDish dishName];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"price: $ %.01f",[tmpDish dishPrice]];
        
        if(!tmpDish.dishIcon){
            
            if(self.tableView.dragging == NO && self.tableView.decelerating == NO)
            {
                [self startIconDownload:tmpDish forIndexPath:indexPath];
            }
            
            //if a download is deferred or in progress, return a placeholder image
            cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        }
        else
        {
            cell.imageView.image = tmpDish.dishIcon;
        }
    }
    
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


-(NSMutableArray *) fetchDishes
{
    
    NSArray *dishes = [[Dish executeDishFetch:[Dish returnDishOnlineOrderScheduleUrl] withSiteID:1 withCategory:0 inDay:[self dateStr]] objectForKey:@"dishes"];
    NSMutableArray *rtnDishes = [NSMutableArray array];
    for(NSDictionary *dish in dishes){
        Dish *tmpDish = [[Dish alloc] init];
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




#pragma mark - Table cell image support

-(void)startIconDownload:(Dish *)dish forIndexPath:(NSIndexPath *)indexPath
{
    DishIconDownloader *dishIconDownloader = [self.imageDownloadsInProgress objectForKey:indexPath];
    if (dishIconDownloader == nil) {
        dishIconDownloader = [[DishIconDownloader alloc] init];
        dishIconDownloader.dish = dish;
        [dishIconDownloader setCompletionHandler:^{
            
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            
            //Display the newly loaded image
            cell.imageView.image = dish.dishIcon;
            
            //Remove the iconDownloader from the in progress list
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        
        [self.imageDownloadsInProgress setObject:dishIconDownloader forKey:indexPath];
        [dishIconDownloader startDownload];
    }
}




// -------------------------------------------------------------------------------
//	loadImagesForOnscreenRows
//  This method is used in case the user scrolled into a set of cells that don't
//  have their app icons yet.
// -------------------------------------------------------------------------------

-(void)loadImagesForOnscreenRows
{
    if([self.dishes count] > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for(NSIndexPath *indexPath in visiblePaths)
        {
            Dish *dish = [self.dishes objectAtIndex:indexPath.row];
            
            if(!dish.dishIcon) //Avoid the app icon download if the app already has an icon
            {
                [self startIconDownload:dish forIndexPath:indexPath];
            }
        }
    }
}




#pragma mark - UIScrollViewDelegate

// -------------------------------------------------------------------------------
//	scrollViewDidEndDragging:willDecelerate:
//  Load images for all onscreen rows when scrolling is finished.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Dish* dish = [self.dishes objectAtIndex:indexPath.row];
    if([segue.identifier isEqualToString:@"show dish detail"])
    {
        [segue.destinationViewController performSelector:@selector(setDish:) withObject:dish];
    }
}






@end
