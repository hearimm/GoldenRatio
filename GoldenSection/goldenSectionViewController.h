//
//  goldenSectionViewController.h
//  GoldenSection
//
//  Created by 최 혁 on 2013. 12. 21..
//  Copyright (c) 2013년 최 혁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface goldenSectionViewController : UIViewController <ADBannerViewDelegate>{
    ADBannerView*adView;
}
@property (strong, nonatomic) IBOutlet ADBannerView *adView;
@property BOOL bannerIsVisible;

@property (strong, nonatomic) IBOutlet UITextField *inputTxt;
@property (strong, nonatomic) IBOutlet UILabel *inputLabel;
@property (strong, nonatomic) IBOutlet UILabel *yLabel;
@property (strong, nonatomic) IBOutlet UILabel *xLabel;
- (IBAction)calculate:(id)sender;

@end
