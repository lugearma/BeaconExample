//
//  ViewController.m
//  BeaconExample
//
//  Created by Luis Arias on 1/18/18.
//  Copyright © 2018 Luis Arias. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *rssiLabel;
@property (nonatomic, weak) IBOutlet UILabel *batteryLabel;
@property (nonatomic, weak) IBOutlet UILabel *macLabel;
@property (nonatomic, weak) IBOutlet UILabel *framesLabel;

@property (nonatomic, strong) MTCentralManager *centralManager;
@property (nonatomic, strong) MTFrameHandler *aFrameHandle;
@property (nonatomic, strong) MTPeripheral *aMTPeripheral;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  centralManager = [MTCentralManager sharedInstance];
  
  centralManager.stateBlock = ^(PowerState state) {
    if (state == PowerStatePoweredOn){
      NSLog(@"🐶🐶🐶🐶🐶🐶🐶🐶🐶🐶");
    }
  };
  
  [centralManager startScan:^(NSArray<MTPeripheral *> *peris) {
    MTPeripheral *peri = peris[0];
    NSLog(@"MAC: %@", peri.framer.mac);
  }];
}

@end

