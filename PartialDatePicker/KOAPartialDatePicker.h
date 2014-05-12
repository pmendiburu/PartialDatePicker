//
//  KOAPartialDatePicker.h
//  PartialDatePicker
//
//  Created by Sharon Amram on 5/7/14.
//  Copyright (c) 2014 KindOfApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KOAPartialDatePicker : UIControl <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, copy, readwrite) NSDate *date;
@property (nonatomic, readonly) IBOutlet UIPickerView* picker;


@end
