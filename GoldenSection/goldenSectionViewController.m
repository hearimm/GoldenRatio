//
//  goldenSectionViewController.m
//  GoldenSection
//
//  Created by 최 혁 on 2013. 12. 21..
//  Copyright (c) 2013년 최 혁. All rights reserved.
//

#import "goldenSectionViewController.h"
#import "GAITrackedViewController.h"
#import "GAI.h"

@interface UICollectionViewController ()
@end

#define MY_BANNER_UNIT_ID @"a152c57cf08d063"
#define ADVIEW_X_POINT 0
#define ADVIEW_Y_POINT 20

@implementation goldenSectionViewController
const float GOLDEN_RATE = 1.61803398875;
const float SILVER_RATE = 2.4142135623;
float ratio = GOLDEN_RATE;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self pickerDataCreate]; //picker Data Create
    [_picker selectRow:1 inComponent:0 animated:YES]; //picker default row = 1 Golden Ratio


	// Do any additional setup after loading the view, typically from a nib.

    // add iAd
    _adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    [_adView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];

    CGRect adFrame = _adView.frame;
    adFrame.origin.y = self.view.frame.size.height-_adView.frame.size.height;
    _adView.frame = adFrame;
    [self.view addSubview:_adView];
    
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
    
    self.picker.hidden = YES;
    _calcFlag = false;
    _pickerButtonToggle  = false;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.screenName = @"Golden Ratio Main";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)calculateLowTextChanged{
    float lowFloat = [_lowText.text floatValue];
    float highFloat = lowFloat * ratio;
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
    float lowFloat = highFloat / ratio;
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
    float lowFloat = resultFloat / (ratio+1);
    float highFloat = resultFloat - lowFloat;
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
	[_highText resignFirstResponder];
    [_lowText resignFirstResponder];
    [_resultText resignFirstResponder];
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
    _lastInputText = sender;
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
    }
    _calcFlag = false;
}
- (IBAction)pressMorePicker:(id)sender {
    _pickerButtonToggle = !_pickerButtonToggle; // bool value toggle
    if(_pickerButtonToggle){
        [_pickerButton setTitle:@"Hidden Me!" forState:UIControlStateNormal];
        self.picker.hidden = NO;
    }else{
        [self pickerButtonNameChange];  //dynamic Name change
        self.picker.hidden = YES;
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _ratioTypes.count;
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _ratioTypes[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    ratio = [_ratioValues[row] floatValue];
    _highText.placeholder = [NSString stringWithFormat:@"%.3f",ratio];
    [self calculate:_lastInputText];
    [self.view endEditing:YES];
}


-(void)pickerDataCreate{
    _ratioTypes = [[NSMutableArray alloc] init];
    _ratioValues = [[NSMutableArray alloc] init];
    for (int i= 1; i <= 10; i++) {
        NSString *str = @"1:";
        NSString *strRatio = [NSString stringWithFormat:@"%d",i];
        NSString *strResult = [NSString stringWithFormat:@"%@%@",str,strRatio];

        [_ratioTypes addObject:strResult];
        [_ratioValues addObject:[NSNumber numberWithInt:i]];
        if(i == 1){
            [_ratioTypes addObject:@"Golden Rate"];
            [_ratioValues addObject:[NSNumber numberWithFloat:GOLDEN_RATE]];
        }
        if(i == 2){
            [_ratioTypes addObject:@"Silver Rate"];
            [_ratioValues addObject:[NSNumber numberWithFloat:SILVER_RATE]];
        }
    }
//    NSLog(_ratioTypes[0]);
}
-(void)pickerButtonNameChange{
    NSInteger row;
    row = [_picker selectedRowInComponent:0];
    NSString *titleName = [_ratioTypes objectAtIndex:row];
    [_pickerButton setTitle:titleName forState:UIControlStateNormal];
}
@end
