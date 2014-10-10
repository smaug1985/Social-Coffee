//
//  DrawsTableViewController.m
//  CofeeApp
//
//  Created by Fran Estrada on 14/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DrawsTableViewController.h"


@implementation DrawsTableViewController
@synthesize drawsArray;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	self.view.backgroundColor = [UIColor colorWithRed:214/255.0 green:195/255.0 blue:113/255.0 alpha:1.0];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"draws" ofType:@"plist"];
	self.drawsArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
	
	self.navigationItem.title = NSLocalizedString(@"dibujos",@"dibujos");
	
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 55;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.drawsArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"drawCell";
	
	CoffeeCellViewController *cell = (CoffeeCellViewController *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"DrawCellView" owner:self options:nil];
		cell = coffeeCell;
		
	}
	
	cell.lblCell.text = [[self.drawsArray objectAtIndex:indexPath.row] objectForKey:@"name"];
	cell.imgCell.image = [UIImage imageNamed:[[self.drawsArray objectAtIndex:indexPath.row] objectForKey:@"photoTable"]];
	
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
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
	DrawDetailViewController *steps = [[DrawDetailViewController alloc] initWithNibName:@"DrawDetailViewController" bundle:[NSBundle mainBundle]];
	
	steps.stepsArray = [[self.drawsArray objectAtIndex:indexPath.row] objectForKey:@"steps"];
	steps.imgDetail = [[self.drawsArray objectAtIndex:indexPath.row] objectForKey:@"photoDetail"];
	steps.navigationItem.title = [[self.drawsArray objectAtIndex:indexPath.row] objectForKey:@"name"];
	
	[self.navigationController pushViewController:steps animated:YES];
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[drawsArray release];
    [super dealloc];
}


@end

