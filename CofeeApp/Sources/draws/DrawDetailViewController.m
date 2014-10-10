//
//  DrawDetailViewController.m
//  CofeeApp
//
//  Created by Fran Estrada on 14/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DrawDetailViewController.h"


@implementation DrawDetailViewController
@synthesize stepsArray, imgDetail;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	self.view.backgroundColor = [UIColor colorWithRed:214/255.0 green:195/255.0 blue:113/255.0 alpha:1.0];
	UIBarButtonItem *button =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"photo2.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(takePhoto)];
	[self.navigationItem setRightBarButtonItem:button];
}

-(void)takePhoto {
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"photo2" object:@""];
	
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

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 216;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIImageView *header = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imgDetail]] autorelease];
	return header;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.row%2!=0) {
		return 15;
	}else {
		return 100;
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.stepsArray count]*2-1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
	
	if (indexPath.row%2!=0) {
		
		static NSString *CellIdentifier1 = @"customSeparator";
		
		cell = (CustomSeparatorViewController *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (cell == nil) {
			[[NSBundle mainBundle] loadNibNamed:@"CustomSeparatorView" owner:self options:nil];
			cell = separatorCell;
		}
		
	}else{
		
		static NSString *CellIdentifier2 = @"drawStepCell";
		
		StepsCellViewController *cellstep = (StepsCellViewController *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
		if (cellstep == nil) {
			[[NSBundle mainBundle] loadNibNamed:@"DrawStepsCellView" owner:self options:nil];
			cellstep = stepsCell;
		}
		
		cellstep.lblNumber.textColor = [UIColor colorWithRed:123/255.0 green:80/255.0 blue:45/255.0 alpha:1.0];
		cellstep.tvStep.textColor = [UIColor colorWithRed:61/255.0 green:42/255.0 blue:5/255.0 alpha:1.0];
		
		cellstep.lblNumber.text = [NSString stringWithFormat:@"%d",indexPath.row/2+1];
		cellstep.tvStep.text = [self.stepsArray objectAtIndex:indexPath.row/2];
		
		cell = cellstep;
	}
	
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
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
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
	[self.stepsArray release];
	[self.imgDetail release];
    [super dealloc];
}


@end

