//
//  ViewController.m
//  BeaconExample
//
//  Created by Luis Arias on 1/18/18.
//  Copyright © 2018 Luis Arias. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  MTCentralManager *manager = [MTCentralManager sharedInstance];
  manager.stateBlock = ^(PowerState state) {
    NSLog(@"current bluetooth state：%lu", (unsigned long)state);
  };
  
  [manager startScan:^(NSArray<MTPeripheral *> *peris){
    for (NSInteger i = 0; i < peris; i++) {
      MTPeripheral *peri = peris[1];
      
      MTFrameHandler *framer = peri.framer;
      NSString *name = framer.name;
      NSInteger rssi = framer.rssi;
      NSInteger battery = framer.battery;
      NSString *mac = framer.mac;
      NSArray *frame = framer.advFrames;
    }
  }];
  
  [manager stopScan];
}
@end
