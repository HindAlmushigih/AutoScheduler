//
//  AutoSchedulerUITests.m
//  AutoSchedulerUITests
//
//  Created by Hind Almushigih on 20/1/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface AutoSchedulerUITests : XCTestCase

@end

@implementation AutoSchedulerUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTheloginAndTheMenueAndViewAndAddNewProject{
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.

    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.textFields[@"UserName"] typeText:@"admin"];
    
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"admin"];
    [app.buttons[@"Login"] tap];
    
    XCUIElement *revealIconButton = app.navigationBars[@"HomeView"].buttons[@"reveal icon"];
    [revealIconButton tap];
    [revealIconButton tap];
    [revealIconButton tap];
    
    XCUIElementQuery *tablesQuery2 = app.tables;
    XCUIElementQuery *tablesQuery = tablesQuery2;
    [tablesQuery.staticTexts[@"Home"] tap];
    [app.staticTexts[@"Welcom: Redmine Admin"] tap];
    [app.staticTexts[@"Email: autoschedulerapp@gmail.com"] tap];
    [app.staticTexts[@"Last connection: 2016-02-24T17:16:11Z"] tap];
    [revealIconButton tap];
    
    XCUIElement *projectsStaticText = tablesQuery.staticTexts[@"Projects"];
    [projectsStaticText tap];
    [[tablesQuery2.cells containingType:XCUIElementTypeStaticText identifier:@"test"].staticTexts[@"View Project..."] tap];
    
    XCUIElement *element2 = [[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element;
    XCUIElement *element = [element2 childrenMatchingType:XCUIElementTypeOther].element;
    [[[[element childrenMatchingType:XCUIElementTypeStaticText] matchingIdentifier:@"test"] elementBoundByIndex:0] tap];
    [[[[element childrenMatchingType:XCUIElementTypeStaticText] matchingIdentifier:@"test"] elementBoundByIndex:1] tap];
    [[[[element childrenMatchingType:XCUIElementTypeStaticText] matchingIdentifier:@"2016-02-17T23:07:02Z"] elementBoundByIndex:0] tap];
    [[[[element childrenMatchingType:XCUIElementTypeStaticText] matchingIdentifier:@"2016-02-17T23:07:02Z"] elementBoundByIndex:1] tap];
    [[[[app.navigationBars[@"Project Details"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    XCUIElement *projectstableviewNavigationBar = app.navigationBars[@"ProjectsTableView"];
    XCUIElement *addButton = projectstableviewNavigationBar.buttons[@"Add"];
    [addButton tap];
    
    XCUIElement *newprojectviewNavigationBar = app.navigationBars[@"NewProjectView"];
    [newprojectviewNavigationBar.buttons[@"Cancel"] tap];
    [addButton tap];
    
    XCUIElement *textField = [[element2 childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:0];
    [textField tap];
    [textField typeText:@"TestProject"];
    
    XCUIElement *textView = [element2 childrenMatchingType:XCUIElementTypeTextView].element;
    [textView tap];
    [textView typeText:@"This is to test the adding feature for project in the iOS app for redmine web-app."];
    
    XCUIElement *textField2 = [[element2 childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:1];
    [textField2 tap];
    [textField2 tap];
    [textField2 typeText:@"thisID"];
    [newprojectviewNavigationBar.buttons[@"Save"] pressForDuration:1.6];
    XCUIElement *revealIconButton2 = projectstableviewNavigationBar.buttons[@"reveal icon"];
    [revealIconButton2 tap];
    [projectsStaticText tap];
    [revealIconButton2 tap];
    [revealIconButton2 tap];
    [tablesQuery.staticTexts[@"Issues"] tap];
    [[[[app.navigationBars[@"Issue Details"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
}

- (void)testTheGanttChart
{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.navigationBars[@"GanttChartView"].buttons[@"reveal icon"] tap];
    [app.tables.staticTexts[@"GanntChart"] tap];
    
    
}




@end
