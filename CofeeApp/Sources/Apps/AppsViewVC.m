//
//  appsViewVC.m
//  appsView
//
//  Created by Fran on 03/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppsViewVC.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"
#import "CustomFooter.h"


@implementation AppsViewVC

@synthesize arrayApps;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.view.backgroundColor = [UIColor colorWithRed:214/255.0 green:195/255.0 blue:113/255.0 alpha:1.0];
	//[self.view setBackgroundColor:[UIColor colorWithRed:130/255.0 green:103/255.0 blue:42/255.0 alpha:255/255.0]];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	//Listado de ingredientes
	NSString *filepath = [[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"];
	self.arrayApps = [[NSMutableArray alloc] initWithContentsOfFile:filepath];
	
	//[self.tableView setFrame:CGRectMake(0, 80, self.view.frame.size.width, 400)];
	
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
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	CustomHeader *header = [[[CustomHeader alloc] init] autorelease];
	header.titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    return header;

}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	return 72;
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Our Apps";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.arrayApps count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"AppCell";
	
	AppCell *cell = (AppCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if(cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"appCell" owner:self options:nil];
		cell = appCell;
		
		//Custom background
		cell.backgroundView = [[[CustomCellBackground alloc] init] autorelease];
		cell.selectedBackgroundView = [[[CustomCellBackground alloc] init] autorelease];
		
		//Clear label background
		cell.nameLabel.backgroundColor = [UIColor clearColor];
	}
	
	cell.nameLabel.text = [[self.arrayApps objectAtIndex:indexPath.row] objectForKey:@"name"];
	cell.iconImage.image = [UIImage imageNamed:[[self.arrayApps objectAtIndex:indexPath.row] objectForKey:@"icon"]];
	
	return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[[CustomFooter alloc] init] autorelease];
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	*/
	NSString *link = [NSString stringWithString:[[self.arrayApps objectAtIndex:indexPath.row] objectForKey:@"link"]];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[arrayApps release];
    [super dealloc];
}


@end

