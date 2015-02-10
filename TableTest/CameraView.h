//
//  CameraView.h
//  TableTest
//
//  Created by Pablo coco on 2015. 2. 9..
//  Copyright (c) 2015년 Pablo coco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface CameraView : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate;

@end
