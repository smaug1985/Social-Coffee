//
//  preparationSteps.m
//  CoffeeAPP
//
//  Created by gali on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PreparationSteps.h"


@implementation PreparationSteps
@synthesize stepsArray, imgDetail;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor colorWithRed:214/255.0 green:195/255.0 blue:113/255.0 alpha:1.0];
	
	//[self.navigationItem setTitle:@""];
	UIBarButtonItem *button =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"photo2.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(takePhoto)];
	[self.navigationItem setRightBarButtonItem:button];
	/*
	self.stepsArray = [[NSMutableArray alloc] initWithObjects:
					   @"Lorem ipsum dolor sit amet triki triki bum bum grijander de todos los santos y demas...",
					   @"Lorem ipsum dolor sit amet triki triki bum bum grijander de todos los santos y demas...",
					   @"Lorem ipsum dolor sit amet triki triki bum bum grijander de todos los santos y demas...",
					   nil];
	self.imgDetail = @"cafeHeladoDetail.png";
	*/
}

#pragma mark -
#pragma mark Table view data source

/*
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 15;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	return [[[CustomFooter alloc] init] autorelease];
}
*/

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 180;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	//CoffeeTableHeader *header = [[[CoffeeTableHeader alloc] initWithNibName:@"CoffeeTableHeader" bundle:[NSBundle mainBundle]] autorelease];
	CoffeeTableHeader *header = [[[CoffeeTableHeader alloc] init] autorelease];
	//[header.lblCoffee setText:@"Café"];
	header.strCoffee = self.navigationItem.title;
	header.strImgCoffee = self.imgDetail;
	return header.view;
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
	return ([self.stepsArray count]*2)-1;
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
		
		static NSString *CellIdentifier2 = @"stepCell";
	
		StepsCellViewController *cellstep = (StepsCellViewController *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
		if (cellstep == nil) {
			[[NSBundle mainBundle] loadNibNamed:@"StepsCellView" owner:self options:nil];
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
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 
 
 
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
 #pragma mark -
 #pragma mark Table view delegate
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 }
 */



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(void)takePhoto {
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"photo" object:@""];
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[self.stepsArray release];
	[self.imgDetail release];
    [super dealloc];
}


@end
