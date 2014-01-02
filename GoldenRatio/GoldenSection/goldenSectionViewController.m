//
//  goldenSectionViewController.m
//  GoldenSection
//
//  Created by 최 혁 on 2013. 12. 21..
//  Copyright (c) 2013년 최 혁. All rights reserved.
//

#import "goldenSectionViewController.h"
#import "iAdmobID.h"
#import "GADAdMobExtras.h"

#define Position_X 0
#define Position_Y 20
@interface goldenSectionViewController ()

@end

@implementation goldenSectionViewController
const float GOLDEN_RATE = 1.61803398875;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Background Image
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bgBlue.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];

    
    //admob start
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner origin:CGPointMake(Position_X,Position_Y)];
    
    // Specify the ad unit ID.
    bannerView_.adUnitID = @"a152c57cf08d063";
    bannerView_.delegate =self;
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];

    
    [bannerView_ loadRequest:[GADRequest request]];
    //admob end
    
    //calcFlag is check calcurate
    _calcFlag = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Input LowTextField calcurate
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

//input HighTextField calcurate
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

//inputResultTextField calcurate
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

//touch outside close editpad
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.view endEditing:YES];
}

//initialize textField
//usage : if any other textField "" then all clear
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

//calculate method
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
