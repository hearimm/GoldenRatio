//
//  goldenSectionViewController.m
//  GoldenSection
//
//  Created by 최 혁 on 2013. 12. 21..
//  Copyright (c) 2013년 최 혁. All rights reserved.
//

#import "goldenSectionViewController.h"
#import "GAI.h"

@interface UICollectionViewController ()

@end

#define MY_BANNER_UNIT_ID @"a152c57cf08d063"
#define ADVIEW_X_POINT 0
#define ADVIEW_Y_POINT 20

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
    [[UIImage imageNamed:@"bgBlue.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    //Admob start
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner origin:(CGPointMake(ADVIEW_X_POINT, ADVIEW_Y_POINT))];
    
    // Specify the ad unit ID.
    bannerView_.adUnitID = MY_BANNER_UNIT_ID;
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];
    
    // Initiate a generic request to load it with an ad.
    [bannerView_ loadRequest:[GADRequest request]];
    
    //Admob end
    
    _calcFlag = false;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    screenName_ = @"Golden Ratio Main";
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
    float resultFloat = highFloat + lowFloat;
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
 
-(BOOL) initCalcTextField:(UITextField*)sender{
        if([sender.text isEqual:@""]){
            
            NSMutableArray *arrayTextField = [[NSMutableArray alloc ] initWithObjects: _lowText,_highText,_resultText, nil];
            for (int i=0; i< arrayTextField.count; i++) {
                [(UITextField *)arrayTextField[i] setText:@""];
            }
            return false;
        }
    return true;
}
- (IBAction)calculate:(id)sender {
    if(_calcFlag == true){ // prevent double calcurate data
        return;
    }else{
        _calcFlag = true;
    }
    if(![self initCalcTextField:sender]){

    }else if(sender ==_lowText) {
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
