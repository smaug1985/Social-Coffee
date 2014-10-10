//
//  Recipes.m
//  CoffeeAPP
//
//  Created by gali on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Recipes.h"


@implementation Recipes
@synthesize recipesArray;

- (void) viewDidLoad{

	self.view.backgroundColor = [UIColor colorWithRed:214/255.0 green:195/255.0 blue:113/255.0 alpha:1.0];

	NSString *path = [[NSBundle mainBundle] pathForResource:@"coffees" ofType:@"plist"];
	self.recipesArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
	/*
	self.recipesArray = [[NSMutableArray alloc] initWithObjects:
						 @"Cappucino",
						 @"Americano",
						 @"Espresso",
						 @"Ristretto",
						 @"Macchiato",
						 @"Café helado",
						 @"Café Bombón",
						 @"Café leche y leche",
						 nil];
	*/
	
	self.navigationItem.title = NSLocalizedString(@"recipe",@"");
	
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

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 50;
}
 
 - (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 CustomHeader *header = [[[CustomHeader alloc] init] autorelease];        
 header.titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
 
 if (section == 0) {
 header.lightColor = [UIColor colorWithRed:255/255.0 green:182/255.0 blue:193/255.0 alpha:1.0];
 header.darkColor = [UIColor colorWithRed:219/255.0 green:112/255.0 blue:147/255.0 alpha:1.0];
 }
 return header;
 }
*/

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 55;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 // Return the number of sections.
 return 1;
 }
 
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 // Return the number of rows in the section.
 return [self.recipesArray count];
 }



 // Customize the appearance of table view cells.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
	 static NSString *CellIdentifier = @"coffeeCell";
	 
	 CoffeeCellViewController *cell = (CoffeeCellViewController *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	 if (cell == nil) {
		 [[NSBundle mainBundle] loadNibNamed:@"CoffeeCellView" owner:self options:nil];
		 cell = coffeeCell;
		 
	 }
 
	 cell.lblCell.text = [[self.recipesArray objectAtIndex:indexPath.row] objectForKey:@"name"];
	 cell.imgCell.image = [UIImage imageNamed:[[self.recipesArray objectAtIndex:indexPath.row] objectForKey:@"photoTable"]];
	 
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


#pragma mark -
#pragma mark Table view delegate

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	 
	 PreparationSteps *steps = [[PreparationSteps alloc] initWithNibName:@"PreparationSteps" bundle:[NSBundle mainBundle]];
	 
	 steps.stepsArray = [[self.recipesArray objectAtIndex:indexPath.row] objectForKey:@"steps"];
	 steps.imgDetail = [[self.recipesArray objectAtIndex:indexPath.row] objectForKey:@"photoDetail"];
	 steps.navigationItem.title = [[self.recipesArray objectAtIndex:indexPath.row] objectForKey:@"name"];
	 
	 [self.navigationController pushViewController:steps animated:YES];
 }

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	[recipesArray release];
    [super dealloc];
}


@end
