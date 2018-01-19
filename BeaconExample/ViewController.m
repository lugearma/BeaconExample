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
@property (nonatomic, strong) MTConnectionHandler *aConnectionHandler;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  centralManager = [MTCentralManager sharedInstance];
  
  centralManager.stateBlock = ^(PowerState state) {
    if (state == PowerStatePoweredOn){
      NSLog(@"Bluethooth ✅");
    } else {
      NSLog(@"Bluethooth ❌");
    }
  };
  
  [centralManager startScan:^(NSArray<MTPeripheral *> *peris) {
    if (aMTPeripheral == nil) {
      NSLog(@"Number of peripherials %d", peris.count);
      aMTPeripheral = peris[0];
      NSLog(@"MAC: %@", aMTPeripheral.framer.mac);
      
      [centralManager connectToPeriperal:aMTPeripheral passwordRequire:^(MTPasswordBlock passwordBlock) {
        NSString *password = @"minew123";
        passwordBlock(password);
      }];
      
      aMTPeripheral.connector.statusChangedHandler = ^(ConnectionStatus status, NSError *error) {
        if (status == StatusCompleted) {
          NSLog(@"Connection ✅");
          MTConnectionHandler *con = aMTPeripheral.connector;
          ConnectionStatus conSte = con.status;  // current connection status
          NSLog(@"Conectionc Status %d", conSte);
        } else {
          NSLog(@"Connection ❌");
        }
      };
    }
 }];
}
@end

