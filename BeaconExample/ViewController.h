//
//  ViewController.h
//  BeaconExample
//
//  Created by Luis Arias on 1/18/18.
//  Copyright © 2018 Luis Arias. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MTBeaconPlus/MTBeaconPlus.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController {
  IBOutlet UILabel *nameLabel;
  IBOutlet UILabel *rssiLabel;
  IBOutlet UILabel *batteryLabel;
  IBOutlet UILabel *macLabel;
  IBOutlet UILabel *framesLabel;
//  CBCentralManager *centralManager;
  MTCentralManager *centralManager;
  MTFrameHandler *aFrameHandler;
  MTPeripheral *aMTPeripheral;
}


@end

