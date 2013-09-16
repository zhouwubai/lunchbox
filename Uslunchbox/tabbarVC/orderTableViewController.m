//
//  orderTableViewController.m
//  Uslunchbox
//
//  Created by Wubai Zhou on 8/31/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import "orderTableViewController.h"
#import "MainLunchTabBarController.h"
#import "DishOrder.h"

@interface orderTableViewController ()


- (IBAction)placeOrders:(UIBarButtonItem *)sender;

@end

@implementation orderTableViewController

@synthesize dishOrderDatabase = _dishOrderDatabase;


-(void)setDishOrderDatabase:(UIManagedDocument *)dishOrderDatabase
{
    if(_dishOrderDatabase != dishOrderDatabase){
        _dishOrderDatabase = dishOrderDatabase;
        [self useDocument];
    }
}




#pragma mark - FetchRequest


//attaches an NSFetchRequest to this UITableView Controller
-(void)setupFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DishOrder"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"dishName"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    //we gonna change this request, we just want to fetch todays order
    //Also before this, we gonna delete all order that miss order time.
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.dishOrderDatabase.managedObjectContext sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    
}



-(void)useDocument
{
    if(![[NSFileManager defaultManager] fileExistsAtPath:[self.dishOrderDatabase.fileURL path]]){
        //Does not exist on disk, so create it
        [self.dishOrderDatabase saveToURL:self.dishOrderDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success){
            [self setupFetchedResultsController];
            
        }];
        
    }else if (self.dishOrderDatabase.documentState == UIDocumentStateClosed){
        [self.dishOrderDatabase openWithCompletionHandler:^(BOOL success){
            [self setupFetchedResultsController];
        }];
    }else if(self.dishOrderDatabase.documentState == UIDocumentStateNormal){
        [self setupFetchedResultsController];
    }
}


#pragma mark - Table life cycle
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //get dishOrderDatabase from parent TabBarController
    self.dishOrderDatabase = [(MainLunchTabBarController *)self.tabBarController dishOrderDatabase];
    NSLog(@"dishOrderDatabase equal? %d",self.dishOrderDatabase == [(MainLunchTabBarController *)self.tabBarController dishOrderDatabase]);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.title = @"Shopping Cart";
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"order cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    DishOrder *dishOrder = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = dishOrder.dishName;
    float chargedFee = [dishOrder.dishPrice floatValue] * [dishOrder.quantity intValue];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Quantity: %d, Total Price: %f ", [dishOrder.quantity intValue], chargedFee];
    
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error;
        if(![context save:&error]){
            NSLog(@"Unresolved error %@,  %@", error, [error userInfo]);
            abort();
        }
    }
}


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
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
 
}
*/


- (IBAction)placeOrders:(UIBarButtonItem *)sender {
    
    NSLog(@"placeOrder");
    
}







@end
