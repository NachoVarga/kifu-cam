//
//  SettingsVC.m
//  KifuCam
//
//  Created by Andreas Hauenstein on 2018-01-30.
//  Copyright © 2018 AHN. All rights reserved.
//

#import "SettingsVC.h"
#import "Globals.h"

@interface SettingsVC ()
@property UIImage *imgChecked;
@property UIImage *imgUnChecked;

@property UIButton *btnUploadYes;
@property UILabel *lbUploadYes;

@property UIButton *btnUploadNo;
@property UILabel *lbUploadNo;

@property UIButton *btnDefaultPhoto;
@property UILabel *lbDefaultPhoto;

@property UIButton *btnDefaultVideo;
@property UILabel *lbDefaultVideo;
@end

@implementation SettingsVC
//-----------------------
- (id)init
{
    self = [super init];
    if (self) {
        //CGRect frame = self.view.bounds;
        self.title = @"Settings";
        self.view.backgroundColor = BGCOLOR;
    }
    return self;
} // init()

// Allocate UI elements.
//---------------------------
- (void) loadView
{
    self.view = [UIView new];
    UIView *v = self.view;
    v.autoresizesSubviews = NO;
    v.opaque = YES;
    v.backgroundColor = BGCOLOR;

    // Instantiate stuff
    _imgChecked = [UIImage imageNamed:@"checked.png"];
    _imgUnChecked = [UIImage imageNamed:@"unchecked.png"];
    _btnUploadYes = [UIButton new];
    _btnUploadNo = [UIButton new];
    _lbUploadYes = [UILabel new];
    _lbUploadNo = [UILabel new];
    _btnDefaultVideo = [UIButton new];
    _btnDefaultPhoto = [UIButton new];
    _lbDefaultVideo = [UILabel new];
    _lbDefaultPhoto = [UILabel new];

    // Config upload radio button
    [_btnUploadYes setImage:_imgUnChecked forState:UIControlStateNormal];
    [_btnUploadYes setImage:_imgChecked forState:UIControlStateSelected];
    [_btnUploadNo setImage:_imgUnChecked forState:UIControlStateNormal];
    [_btnUploadNo setImage:_imgChecked forState:UIControlStateSelected];
    _lbUploadYes.text = @"Upload images to help developers";
    _lbUploadNo.text = @"I don't want to help";
    [_btnUploadYes addTarget:self action:@selector(btnUploadYes:) forControlEvents: UIControlEventTouchUpInside];
    [_btnUploadNo addTarget:self action:@selector(btnUploadNo:) forControlEvents: UIControlEventTouchUpInside];


    // Config mode radio button
    [_btnDefaultPhoto setImage:_imgUnChecked forState:UIControlStateNormal];
    [_btnDefaultPhoto setImage:_imgChecked forState:UIControlStateSelected];
    [_btnDefaultVideo setImage:_imgUnChecked forState:UIControlStateNormal];
    [_btnDefaultVideo setImage:_imgChecked forState:UIControlStateSelected];
    _lbDefaultVideo.text = @"Default to video vode";
    _lbDefaultPhoto.text = @"Default to photo mode";
    [_btnDefaultPhoto addTarget:self action:@selector(btnDefaultPhoto:) forControlEvents: UIControlEventTouchUpInside];
    [_btnDefaultVideo addTarget:self action:@selector(btnDefaultVideo:) forControlEvents: UIControlEventTouchUpInside];

    // Add controls as subviews
    [v addSubview: _btnUploadYes];
    [v addSubview: _btnUploadNo];
    [v addSubview: _lbUploadYes];
    [v addSubview: _lbUploadNo];
    [v addSubview: _btnDefaultVideo];
    [v addSubview: _btnDefaultPhoto];
    [v addSubview: _lbDefaultVideo];
    [v addSubview: _lbDefaultPhoto];
} // loadView

//------------------------------------------
- (void) viewWillAppear:(BOOL) animated
{
    [super viewWillAppear: animated];
    [self doLayout];
}

//----------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
}

 //----------------------------------------
 - (void) viewDidAppear: (BOOL) animated
 {
     [super viewDidAppear: animated];
 }

//----------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// Layout
//=========

// Put UI elements into the right place
//----------------------------------------
- (void) doLayout
{
    // Get saved state of settings
    NSString *optMode =  getProp( @"opt_mode", @"video");
    NSString *optUpload =  getProp( @"opt_upload", @"yes");

    // Set button states accordingly
    if ([optMode isEqualToString:@"video"]) {
        _btnDefaultVideo.selected = YES;
        _btnDefaultPhoto.selected = NO;
    }
    else {
        _btnDefaultVideo.selected = NO;
        _btnDefaultPhoto.selected = YES;
    }
    if ([optUpload isEqualToString:@"yes"]) {
        _btnUploadYes.selected = YES;
        _btnUploadNo.selected = NO;
    }
    else {
        _btnUploadYes.selected = NO;
        _btnUploadNo.selected = YES;
    }
    
    // Layout
    float H = SCREEN_HEIGHT;
    float W = SCREEN_WIDTH;
    UIView *v = self.view;
    CGRect bounds = v.bounds;
    bounds.origin.y = g_app.navVC.navigationBar.frame.size.height;
    bounds.size.height = H - bounds.origin.y;
    v.bounds = bounds;
    
    int checkBoxSize = 30;
    float y = H * 0.3;
    int lmarg = W * 0.1;
    
    // Upload option
    _btnUploadYes.frame = CGRectMake( lmarg, y, checkBoxSize, checkBoxSize);
    _lbUploadYes.frame = CGRectMake( lmarg + checkBoxSize*1.5, y, W - lmarg, checkBoxSize);
    y += checkBoxSize * 1.5;
    _btnUploadNo.frame = CGRectMake( lmarg, y, checkBoxSize, checkBoxSize);
    _lbUploadNo.frame = CGRectMake( lmarg + checkBoxSize*1.5, y, W - lmarg, checkBoxSize);

    // Default mode
    y += checkBoxSize * 3;
    _btnDefaultVideo.frame = CGRectMake( lmarg, y, checkBoxSize, checkBoxSize);
    _lbDefaultVideo.frame = CGRectMake( lmarg + checkBoxSize*1.5, y, W - lmarg, checkBoxSize);
    y += checkBoxSize * 1.5;
    _btnDefaultPhoto.frame = CGRectMake( lmarg, y, checkBoxSize, checkBoxSize);
    _lbDefaultPhoto.frame = CGRectMake( lmarg + checkBoxSize*1.5, y, W - lmarg, checkBoxSize);
} // doLayout()

// Button Callbacks
//====================

//--------------------------------
- (void) btnUploadYes:(id)sender
{
    _btnUploadYes.selected = YES;
    _btnUploadNo.selected = NO;
    setProp( @"opt_upload", @"yes");
} // btnUploadYes()

//-------------------------------
- (void) btnUploadNo:(id)sender
{
    _btnUploadYes.selected = NO;
    _btnUploadNo.selected = YES;
    setProp( @"opt_upload", @"no");
} // btnUploadNo()

//-----------------------------------
- (void) btnDefaultPhoto:(id)sender
{
    _btnDefaultPhoto.selected = YES;
    _btnDefaultVideo.selected = NO;
    setProp( @"opt_mode", @"photo");
} // btnDefaultPhoto()

//-----------------------------------
- (void) btnDefaultVideo:(id)sender
{
    _btnDefaultPhoto.selected = NO;
    _btnDefaultVideo.selected = YES;
    setProp( @"opt_mode", @"video");
} // btnDefaultVideo()



@end





























