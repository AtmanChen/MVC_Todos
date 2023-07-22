//
//  ToDosListServiceTest.swift
//  MVC-MyToDosTests
//
//  Created by Anderson  on 2023/7/21.
//

import XCTest

@testable import MVC_MyToDos

final class ToDosListServiceTest: XCTestCase {
	
	var sut: ToDosListServiceProtocol!
	var list: ToDosListModel!
	
	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
		sut = ToDosListService(coreDataManager: InMemoryCoreDataManager())
		list = ToDosListModel(id: "12345-67890", title: "Test List", icon: "test.icon", todos: [], createdAt: Date())
		
		// In UI tests it is usually best to stop immediately when a failure occurs.
		continueAfterFailure = false
		
		// In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
	}
	
	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		sut = nil
		list = nil
		super.tearDown()
	}
	
	func testSaveOnDB_whenSavesAList_shouldBeOneOnDatabase() {
		sut.saveToDosList(list)
		XCTAssertEqual(sut.fetchList().count, 1)
	}
	
	func testDeleteOnDB_whenSavesAListAndThenDeleted_shouldBeNoneOnDatabase() {
		sut.saveToDosList(list)
		XCTAssertNotNil(sut.fetchListWithId("12345-67890"))
		sut.deleteList(list)
		XCTAssertEqual(sut.fetchList().count, 0)
	}
	
	func testExample() throws {
		// UI tests must launch the application that they test.
		let app = XCUIApplication()
		app.launch()
		
		// Use XCTAssert and related functions to verify your tests produce the correct results.
	}
	
	func testLaunchPerformance() throws {
		if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
			// This measures how long it takes to launch your application.
			measure(metrics: [XCTApplicationLaunchMetric()]) {
				XCUIApplication().launch()
			}
		}
	}
}
