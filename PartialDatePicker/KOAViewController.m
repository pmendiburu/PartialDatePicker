//
//  KOAViewController.m
//  PartialDatePicker
//
//  Created by Sharon Amram on 5/7/14.
//  Copyright (c) 2014 KindOfApp. All rights reserved.
//

#import "KOAViewController.h"

@interface KOAViewController ()

@end

@implementation KOAViewController

@synthesize datePicker;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    NSDate *date = [NSDate date];
    datePicker.date = date;
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];

}

-(void)dateChanged:(KOAPartialDatePicker *)sender{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy"];
    NSString *dateStr = [dateFormatter stringFromDate:sender.date];

    NSLog(@"date has changed to >> %@", dateStr);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
