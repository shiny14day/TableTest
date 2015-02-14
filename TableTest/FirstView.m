//
//  FirstView.m
//  TableTest
//
//  Created by Pablo coco on 2015. 2. 8..
//  Copyright (c) 2015년 Pablo coco. All rights reserved.
//

#import "FirstView.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface FirstView()

@property (strong, nonatomic) UIButton *closeBtn;
@property (strong, nonatomic) UIButton *cameraBtn;
@property (strong, nonatomic) UIButton *albumBtn;
@property (strong, nonatomic) UIButton *settingBtn;


@end

@implementation FirstView



- (void)viewDidLoad {

    [super viewDidLoad];
    //테이블뷰 생성
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    tableView.rowHeight = 120;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:tableView];
    
    
    //menu button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(menuView:) forControlEvents:UIControlEventTouchDown];
    UIImage *menuButton = [UIImage imageNamed:@"menu.png"];
    button.frame = CGRectMake(0.0, 10.0, 60.0, 50.0);
    [button setBackgroundImage:menuButton forState:UIControlStateNormal];
    [self.view addSubview:button];

}

-(IBAction)menuView:(id)sender{
    _menuView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 640, 1136)];
    _menuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_menuView];
    
    //close Button
    _closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_closeBtn addTarget:self action:@selector(viewClose:) forControlEvents:UIControlEventTouchDown];
    UIImage *closeButton = [UIImage imageNamed:@"button_close.png"];
    [_closeBtn setBackgroundImage:closeButton forState:UIControlStateNormal];
    _closeBtn.frame = CGRectMake(0.0, 10.0, 60.0, 50.0);
    [self.view addSubview:_closeBtn];
    
    //camera Button
    _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cameraBtn addTarget:self action:@selector(goCamera:) forControlEvents:UIControlEventTouchDown];
    UIImage *buttonImage = [UIImage imageNamed:@"button_camera"];
    _cameraBtn.frame = CGRectMake(110.0, 110.0, 100.0, 90.0);
    [_cameraBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.view addSubview:_cameraBtn];
    
    //album Button
    _albumBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_albumBtn addTarget:self action:@selector(goAlbum:) forControlEvents:UIControlEventTouchDown];
    UIImage *albumImage = [UIImage imageNamed:@"button_album"];
    _albumBtn.frame = CGRectMake(110.0, 215.0, 100.0, 90.0);
    [_albumBtn setBackgroundImage:albumImage forState:UIControlStateNormal];
    [self.view addSubview:_albumBtn];
    
    //setting Button
    _settingBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_settingBtn addTarget:self action:@selector(goSetting:) forControlEvents:UIControlEventTouchDown];
    UIImage *settingImage = [UIImage imageNamed:@"setting_1.png"];
    _settingBtn.frame = CGRectMake(110.0, 320.0, 100.0, 90.0);
    [_settingBtn setBackgroundImage:settingImage forState:UIControlStateNormal];
    [self.view addSubview:_settingBtn];
    
    
    
     
}

-(IBAction)viewClose:(id)sender{
    [_menuView removeFromSuperview];
    [_closeBtn removeFromSuperview];
    [_cameraBtn removeFromSuperview];
    [_albumBtn removeFromSuperview];
    [_settingBtn removeFromSuperview];
}

-(IBAction)goSetting:(id)sender{
    
}

-(IBAction)goAlbum:(id)sender{
    
}

-(IBAction)goCamera:(id)sender{
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
}

-(BOOL)startCameraControllerFromViewController:(UIViewController*)controller
                                 usingDelegate:(id )delegate {
    // 1 - Validattions
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil)) {
        return NO;
    }
    // 2 - Get image picker
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    // Displays a control that allows the user to choose movie capture
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = delegate;
    cameraUI.videoMaximumDuration = 1;
    // 3 - Display image picker
    [controller presentModalViewController: cameraUI animated: YES];
    return YES;
}


// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    [self dismissModalViewControllerAnimated:NO];
    
    // Handle a movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo) {
        
        NSString *moviePath = [[info objectForKey:
                                UIImagePickerControllerMediaURL] path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum (moviePath,self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
        
        
    }
}

- (void)video:(NSString*)videoPath didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil, nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:@"Saved To Photo Album"  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
}

// Cancel버튼 눌렀을때
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated: YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
//    cell.textLabel.text=[NSString stringWithFormat:@"Cell %d",indexPath.row+1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.books.count;
}

- (BOOL)shouldAutorotate {
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations {
    return (UIInterfaceOrientationMaskPortrait);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
