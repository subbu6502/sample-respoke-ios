//
//  LoginTests.m
//  Respoke
//
//  Copyright 2015, Digium, Inc.
//  All rights reserved.
//
//  This source code is licensed under The MIT License found in the
//  LICENSE file in the root directory of this source tree.
//
//  For all details and documentation:  https://www.respoke.io
//

#import <KIF/KIF.h>
#import "KIFUITestActor+Respoke.h"
#import "AppDelegate.h"


#define TEST_GROUP          @"test group"
#define TEST_APP_ID         @"REPLACE_ME"
#define TEST_BAD_APP_ID     @"bad app id"


@interface LoginTests : KIFTestCase
@end


@implementation LoginTests


#pragma mark - Pre and Post Test Methods


- (void)beforeEach
{
    [super beforeEach];
    [tester initializeLoginScreen];
}


- (void)afterEach
{
    [super afterEach];
    [tester resetLoginScreen];
}


#pragma mark - UI Tests


- (void)testSuccessfulLogin
{
    [tester loginEndpoint:[KIFUITestActor generateTestEndpointID] groupName:TEST_GROUP appID:nil];
    [tester logout];
}


 - (void)testSuccessfulLoginWithValidAppID
{
    [tester loginEndpoint:[KIFUITestActor generateTestEndpointID] groupName:TEST_GROUP appID:TEST_APP_ID];
    [tester logout];
}


- (void)testFailedLoginWithBadAppID
{
    // supply endpoint, group, and appID
    [tester enterText:[KIFUITestActor generateTestEndpointID] intoViewWithAccessibilityLabel:LOGIN_ENDPOINT_ID_TEXTFIELD];
    [tester enterText:TEST_GROUP intoViewWithAccessibilityLabel:LOGIN_GROUP_TEXTFIELD];
    [tester enterText:TEST_BAD_APP_ID intoViewWithAccessibilityLabel:LOGIN_APP_ID_TEXTFIELD];

    // hit connect button
    [tester tapViewWithAccessibilityLabel:LOGIN_CONNECT_BUTTON];

    // verify we get the expected error
    UILabel *errorLabel = (UILabel *) [tester waitForViewWithAccessibilityLabel:LOGIN_ERROR_LABEL];
    XCTAssertTrue([errorLabel.text isEqualToString:@"API authentication error"], @"Should not authenticate");
}


- (void)testFailedLoginWithBlankEndpoint
{
    [tester tapViewWithAccessibilityLabel:LOGIN_CONNECT_BUTTON];
    UILabel *errorLabel = (UILabel *) [tester waitForViewWithAccessibilityLabel:LOGIN_ERROR_LABEL];
    XCTAssertTrue([errorLabel.text isEqualToString:@"Username may not be blank"], @"Should not connect");
}


- (void)testBrokeredAuth
{
    [tester setOn:YES forSwitchWithAccessibilityLabel:LOGIN_BROKERED_SWITCH];
    [tester waitForAbsenceOfViewWithAccessibilityLabel:LOGIN_CHANGE_APP_ID_BUTTON];

    // TODO: Test brokered authentication

    // reset the brokered auth switch
    [tester setOn:NO forSwitchWithAccessibilityLabel:LOGIN_BROKERED_SWITCH];
    [tester waitForViewWithAccessibilityLabel:LOGIN_CHANGE_APP_ID_BUTTON];

    // if we don't show the appID text field then reset will fail
    [tester tapViewWithAccessibilityLabel:LOGIN_CHANGE_APP_ID_BUTTON];
}


#pragma mark - Helper Methods


@end
