//
//  TestDemoUITests.m
//  TestDemoUITests
//
//  Created by Jack on 2018/1/16.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface TestDemoUITests : XCTestCase

@end

@implementation TestDemoUITests

- (void)setUp {
    [super setUp];
    //在这里放设置代码。在类中调用每个测试方法之前调用此方法
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

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testLogin{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    /*@START_MENU_TOKEN@*/[app.tables.staticTexts[@"PhotoViewController"] pressForDuration:1.2];/*[["app.tables",".cells.staticTexts[@\"PhotoViewController\"]","["," tap];"," pressForDuration:1.2];",".staticTexts[@\"PhotoViewController\"]"],[[[-1,0,1]],[[-1,5,2],[-1,1,2]],[[2,4],[2,3]]],[0,0,0]]@END_MENU_TOKEN@*/
    
    XCUIElementQuery *collectionViewsQuery = app.collectionViews;
    XCUIElement *albumaddbtnElement = [collectionViewsQuery.cells.otherElements containingType:XCUIElementTypeImage identifier:@"AlbumAddBtn"].element;
    [albumaddbtnElement tap];
    
    XCUIElement *photoDefPhotopickervcButton = [[collectionViewsQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:0].buttons[@"photo def photoPickerVc"];
    [photoDefPhotopickervcButton tap];
    [[[collectionViewsQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:1].buttons[@"photo def photoPickerVc"] tap];
    [[[collectionViewsQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:2].buttons[@"photo def photoPickerVc"] tap];
    [[[collectionViewsQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:3].buttons[@"photo def photoPickerVc"] tap];
    
    XCUIElement *button = app.buttons[@"\U5b8c\U6210"];
    [button tap];
    [albumaddbtnElement tap];
    [photoDefPhotopickervcButton tap];
    [[[collectionViewsQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:4].buttons[@"photo def photoPickerVc"] tap];
    [button tap];
    
    XCUIElement *collectionView = [[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"PhotoView"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeCollectionView].element;
    [collectionView tap];
    /*@START_MENU_TOKEN@*/[collectionView pressForDuration:0.8];/*[["collectionView","["," tap];"," pressForDuration:0.8];"],[[[-1,0,1]],[[1,3],[1,2]]],[0,0]]@END_MENU_TOKEN@*/
    [app.navigationBars[@"PhotoView"].buttons[@"testDemo"] tap];
    
}

@end
