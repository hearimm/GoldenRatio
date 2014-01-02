//
//  goldenSectionViewController.h
//  GoldenSection
//
//  Created by 최 혁 on 2013. 12. 21..
//  Copyright (c) 2013년 최 혁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
//Import GADBannerView's definition from the SDK
#import "GADBannerView.h"

@interface goldenSectionViewController :UIViewController{
    GADBannerView *bannerView_;
}

//@property (strong, nonatomic) IBOutlet ADBannerView *adView;
//@property BOOL bannerIsVisible;
@property BOOL calcFlag;

@property (strong, nonatomic) IBOutlet UITextField *highText;
@property (strong, nonatomic) IBOutlet UITextField *lowText;
@property (strong, nonatomic) IBOutlet UITextField *resultText;
- (IBAction)calculate:(id)sender;


@end
