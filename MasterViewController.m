//
//  MasterViewController.m
//  HTMLParsing
//
//  Created by Solomon Egwu on 22/01/2015.
//  Copyright (c) 2015 Solomon Egwu. All rights reserved.
//
#import "TFHpple.h"
#import "Tutorial.h"
#import "Contributor.h"

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)loadTutorials {
    
    NSMutableArray *newTutorials = [[NSMutableArray alloc] initWithCapacity:0];
    Timetable_Cell *cells = [[Timetable_Cell alloc] init];
    [newTutorials addObject:cells];
    
    
   

    // 1
    NSURL *tutorialsUrl = [NSURL URLWithString:@"file:///Users/solomonegwu/Documents/%20CMIS%20data/Timetable-for-EgwuSolomon.html"];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    
  // NSString *message = [[NSString alloc] initWithData:tutorialsHtmlData encoding:NSASCIIStringEncoding];
    
    // 2
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:tutorialsHtmlData];
    
    // 3
    
    NSString *myId;
    
    NSString *contents = @"scrollContent";
    
    
    
    NSString *nodes = [NSString stringWithFormat:@"//div[@id= '%@']/div", contents];
    
    NSArray *nodesArray = [tutorialsParser searchWithXPathQuery:nodes];
    
    NSArray *tabletds;
    
    
    
    // 4
   // NSLog(@"%@", nodesArray);
    
    for (TFHppleElement *node in nodesArray) {
        
        //tutorial.title = [[element firstChild] content];
        

       myId = [node objectForKey:@"id"];
        
        if ([myId isEqual:@"r1"]) {
            
            NSLog(@"I am r1");
            
            }
        
        else {
          
            NSString *tutorialsXpathQueryString = [NSString stringWithFormat:@"//div[@id= '%@']/table/tr/td", myId];
            tabletds = [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString];
            NSLog(@"%@", tabletds);                    }
        
        
    }
   
    //NSLog(@"%@", tabletds);
    // 8
    _objects = newTutorials;
    [self.tableView reloadData];
        
    }
    
    
    


- (void)viewDidLoad {
    
    
    
        [super viewDidLoad];
        
        [self loadTutorials];
    
    
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Timetable_Cell *thisTutorial = [_objects objectAtIndex:indexPath.row];
    cell.textLabel.text = thisTutorial.title;
    cell.detailTextLabel.text = thisTutorial.ids;
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
