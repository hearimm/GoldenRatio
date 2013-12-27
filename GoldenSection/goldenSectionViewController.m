//
//  goldenSectionViewController.m
//  GoldenSection
//
//  Created by 최 혁 on 2013. 12. 21..
//  Copyright (c) 2013년 최 혁. All rights reserved.
//

#import "goldenSectionViewController.h"

@interface goldenSectionViewController ()

@end

@implementation goldenSectionViewController
const float GOLDEN_RATE = 1.61803398875;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // add iAd
    //_adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    //_adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    //[self.view addSubview:adView];
    
    //Background Image
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bg2.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    _calcFlag = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)calculateLowTextChanged{
    float lowFloat = [_lowText.text floatValue];
    float highFloat = lowFloat * GOLDEN_RATE;
    float resultFloat = lowFloat + highFloat;
    //NSString *lowValue = [NSString stringWithFormat:@"%.3f", lowFloat];
    NSString *highValue = [NSString stringWithFormat:@"%.3f", highFloat];
    NSString *resultValue = [NSString stringWithFormat:@"%.3f", resultFloat];
    
    //_lowText.text = lowValue;
    _highText.text = highValue;
    _resultText.text = resultValue;
}
-(void)calculateHighTextChanged{
    float highFloat = [_highText.text floatValue];
    float lowFloat = highFloat / GOLDEN_RATE;
    float resultFloat = highFloat * GOLDEN_RATE;
    NSString *lowValue = [NSString stringWithFormat:@"%.3f", lowFloat];
    //NSString *highValue = [NSString stringWithFormat:@"%.3f", highFloat];
    NSString *resultValue = [NSString stringWithFormat:@"%.3f", resultFloat];
    
    _lowText.text = lowValue;
    //_highText.text = highValue;
    _resultText.text = resultValue;
}
-(void)calculateResultTextChanged{
    float resultFloat = [_resultText.text floatValue];
    float highFloat = resultFloat / GOLDEN_RATE;
    float lowFloat = resultFloat - highFloat;
    NSString *lowValue = [NSString stringWithFormat:@"%.3f", lowFloat];
    NSString *highValue = [NSString stringWithFormat:@"%.3f", highFloat];
    //NSString *resultValue = [NSString stringWithFormat:@"%.3f", resultFloat];
    
    _lowText.text = lowValue;
    _highText.text = highValue;
    //_resultText.text = resultValue;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.view endEditing:YES];
}

- (IBAction)calculate:(id)sender {
    if(_calcFlag == true){
        return;
    }else{
        _calcFlag = true;
    }
    if (sender ==_lowText) {
        [self calculateLowTextChanged];
    }else if(sender ==_highText){
        [self calculateHighTextChanged];
    }else if(sender ==_resultText){
        [self calculateResultTextChanged];
    }else{
        return;
    }
    _calcFlag = false;
}
@end
