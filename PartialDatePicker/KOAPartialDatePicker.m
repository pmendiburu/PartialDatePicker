//
//  KOAPartialDatePicker.m
//  PartialDatePicker
//
//  Created by Sharon Amram on 5/7/14.
//  Copyright (c) 2014 KindOfApp. All rights reserved.
//

#import "KOAPartialDatePicker.h"


@interface KOAPartialDatePicker(){
    NSInteger mNumberOfYears;
    NSInteger mStartYear;
    NSInteger mSelectedYear;

}

@end

@implementation KOAPartialDatePicker

@synthesize picker;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
    picker.dataSource = self;
    picker.delegate = self;
    
    mNumberOfYears = 500;
    mStartYear = 1800;
    mSelectedYear = 2012;
    
    
    [picker selectRow:31 * 300 inComponent:0 animated:NO];
    [picker selectRow:12 * 300 inComponent:1 animated:NO];
    [picker selectRow:mSelectedYear - mStartYear inComponent:2 animated:NO];


}

//picker view datasource and delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView; {
    return 3;
}

//Rows in each Column
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component; {
    switch(component){
        case 0:
            return 31 * 600;
        case 1:
            return 12 * 600;
        case 2:
            return mNumberOfYears;

    }
    return 0;
}

- (NSString*) pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    long title = 0;
    switch(component){
        case 0:
            title = row % 31 + 1;
            break;
        case 1:
            title = row % 12 + 1;
            break;
        case 2:
            title = row + mStartYear;
            break;
            
    }
    return [NSString stringWithFormat:@"%ld", title];
    
}

- (void)setDate:(NSDate *)date{
    [self setDate:date animated:NO];
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    NSInteger gotoDay = ([picker selectedRowInComponent:0] - ([picker selectedRowInComponent:0] % 31)) + ((components.day - 1) + 31);
    [picker selectRow:gotoDay inComponent:0 animated:animated];
    
    NSInteger gotoMonth = ([picker selectedRowInComponent:1] - ([picker selectedRowInComponent:1] % 12)) + (components.month - 1);
    [picker selectRow:gotoMonth inComponent:1 animated:animated];
    
    [picker selectRow:components.year - mStartYear inComponent:2 animated:animated];
}


- (NSDate *)date{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = [picker selectedRowInComponent:2] + mStartYear;
    dateComponents.month = [picker selectedRowInComponent:1] % 12 + 1;
    dateComponents.day = [picker selectedRowInComponent:0] % 31 + 1;
    
    NSDate *date = [gregorian dateFromComponents: dateComponents];
    NSDateComponents *dateComponents2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];

    if(dateComponents.month != dateComponents2.month){
        [self fixDate:date];
    }
    return date;
}

- (void)fixDate:date{
    
    [self setDate:date animated:YES];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self sendActionsForControlEvents:UIControlEventValueChanged];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
