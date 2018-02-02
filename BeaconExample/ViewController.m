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
    int i = 0;
    while (i<peris.count) {
      
      aMTPeripheral = peris[i];
      MTFrameHandler *framer = aMTPeripheral.framer;
      NSString *name = framer.name;          // name of device, may nil
      NSInteger rssi = framer.rssi;          // rssi
      NSInteger battery = framer.battery;    // battery,may nil
      NSString *mac = framer.mac;            // mac address,may nil
      NSArray *frames = framer.advFrames;    // all data frames of device（such as:iBeacon，UID，URL...）
//      NSLog(@"😈😈😈😈😈 %d", frames.count);
      
      for (NSInteger i = 0; i < frames.count; i ++){
        MinewFrame *frame = frames[i];
        
        
        switch(frame.frameType){
          case FrameAccSensor:{
            MinewAccSensor *bea = (MinewAccSensor *)frame;
            NSLog(@"🍒X:%0.2f, 🐶Y:%0.2f, 🤖Z:%0.2f", bea.XAxis, bea.YAxis, bea.ZAxis);
            //            NSLog(@"iBeacon:%@, %d, %d",bea.uuid, bea.major, bea.minor);
          }
            break;
        }
      }
      
      i = i + 1;
    }
    /*
    for(NSInteger i = 0; i < peris.count; i++){
      aMTPeripheral = peris[i];

      // get FrameHandler of a device.
      // **some properties maybe nil
      MTFrameHandler *framer = aMTPeripheral.framer;
      NSString *name = framer.name;          // name of device, may nil
      NSInteger rssi = framer.rssi;          // rssi
      NSInteger battery = framer.battery;    // battery,may nil
      NSString *mac = framer.mac;            // mac address,may nil
      NSArray *frames = framer.advFrames;    // all data frames of device（such as:iBeacon，UID，URL...）
      NSLog(@"😈😈😈😈😈 %d", frames.count);
    }
    */
    /*if (aMTPeripheral == nil) {
      NSLog(@"Number of peripherials %d", peris.count);
      aMTPeripheral = peris[0];
      NSLog(@"MAC: %@", aMTPeripheral.framer.mac);
      
      NSLog(@"🎃🎃🎃🎃🎃🎃");
      NSArray *frames = aFrameHandler.advFrames;
      NSLog(@"🎃🎃🎃🎃🎃🎃 %d", frames.count);
      for (NSInteger i = 0; i <= frames.count; i ++){
        MinewFrame *frame = frames[i];
        
        
        switch(frame.frameType){
          case FrameAccSensor:{
            MinewAccSensor *bea = (MinewAccSensor *)frame;
            NSLog(@"🍒🍒🍒🍒🍒🍒:%@, %d, %d", bea.XAxis, bea.YAxis, bea.ZAxis);
//            NSLog(@"iBeacon:%@, %d, %d",bea.uuid, bea.major, bea.minor);
          }
            break;
        }
      }
      
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
    }*/
 }];
}
@end

