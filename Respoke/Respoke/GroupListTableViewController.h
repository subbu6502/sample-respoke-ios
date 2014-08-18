//
//  GroupListTableViewController.h
//  Respoke
//
//  Created by Jason Adams on 8/17/14.
//  Copyright (c) 2014 Digium, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RespokeClient.h"


@interface GroupListTableViewController : UITableViewController <RespokeClientDelegate>

- (IBAction)logoutAction;
- (IBAction)joinAction;

@end
