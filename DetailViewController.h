//
//  DetailViewController.h
//  HTMLParsing
//
//  Created by Solomon Egwu on 22/01/2015.
//  Copyright (c) 2015 Solomon Egwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

