//
//  CallViewController.h
//  Respoke
//
//  Created by Jason Adams on 7/9/14.
//  Copyright (c) 2014 Ninjanetic Design Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RespokeEndpoint.h"


@interface CallViewController : UIViewController

@property (weak) IBOutlet UIView *remoteView;
@property (weak) IBOutlet UIView *localView;
@property (weak) IBOutlet UIButton *endCallButton;
@property (weak) IBOutlet UIButton *muteAudioButton;
@property (weak) IBOutlet UIButton *muteVideoButton;
@property RespokeEndpoint *endpoint;
@property RespokeCall *call;

- (IBAction)endCall;
- (IBAction)muteVideo;
- (IBAction)muteAudio;

@end
