//
//  FirstView.h
//  TableTest
//
//  Created by Pablo coco on 2015. 2. 8..
//  Copyright (c) 2015년 Pablo coco. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface FirstView : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *books;
@property (nonatomic, strong) UIButton *navBar;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIView *menuView;



- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate;
@end
