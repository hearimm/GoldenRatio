//
//  goldenSectionViewController.h
//  GoldenSection
//
//  Created by 최 혁 on 2013. 12. 21..
//  Copyright (c) 2013년 최 혁. All rights reserved.
//스터디시작

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "GADBannerView.h"
#import "GAITrackedViewController.h"

@interface goldenSectionViewController : GAITrackedViewController<UIPickerViewDataSource,UIPickerViewDelegate>{
    ADBannerView *adview;
    GADBannerView *bannerView_;
    GAITrackedViewController *screenName;
}

@property (strong, nonatomic) IBOutlet ADBannerView *adView;
@property (strong, nonatomic) NSMutableArray *ratioTypes;
@property (strong, nonatomic) NSMutableArray *ratioValues;
@property BOOL bannerIsVisible;
@property BOOL calcFlag;
@property BOOL pickerButtonToggle;

@property (strong, nonatomic) IBOutlet UITextField *lastInputText;

@property (strong, nonatomic) IBOutlet UITextField *highText;
@property (strong, nonatomic) IBOutlet UITextField *lowText;
@property (strong, nonatomic) IBOutlet UITextField *resultText;
- (IBAction)calculate:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
- (IBAction)pressMorePicker:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *pickerButton;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *arrayText;

@end
