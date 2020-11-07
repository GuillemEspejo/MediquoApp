//
//  CompanyListInteractorTests.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 07/11/2020.
//
//  This file was generated by the Guillem Espejo Clean Swift Xcode Templates
//

@testable import MediquoApp
import XCTest

class CompanyListInteractorTests: XCTestCase{
	
    // MARK: Subject under test
    var sut: CompanyListInteractor!
    var worker = CompanyListWorkerSpy()

    override func setUp(){
        super.setUp()
        setupCompanyListInteractor()
    }
  
    override func tearDown(){
        super.tearDown()
    }
  
	// ------------------------------------------------------------
	// TEST SETUP
	// ------------------------------------------------------------
	// MARK: - Test Setup
    func setupCompanyListInteractor(){
        sut = CompanyListInteractor(presenter: nil, worker: worker )
    }
  
	// ------------------------------------------------------------
	// TESTS
	// ------------------------------------------------------------
	// MARK: - Tests
    func testLoadBaseNetwork(){
        // Given
        let expectation = self.expectation(description: "LoadDataExpectation")
        let spy = CompanyListPresentationLogicSpy(expectation: expectation)
        sut.presenter = spy
        
        self.worker.shouldFailOperations = false
        let request = CompanyList.LoadBaseNetworkData.Request()

        // When
        sut.loadBaseNetworkData(request: request)

        // Then
        waitForExpectations(timeout: 10.0)
        XCTAssertTrue(spy.presentBaseNetworkWasCalled,
                      "loadBaseNetworkData(request:) should ask the presenter to format the result")
        
    }
    
    func testLoadBaseNetworkFail(){
        // Given
        let expectation = self.expectation(description: "LoadDataExpectation")
        let spy = CompanyListPresentationLogicSpy(expectation: expectation)
        sut.presenter = spy
        
        self.worker.shouldFailOperations = true
        
        let request = CompanyList.LoadBaseNetworkData.Request()

        // When
        sut.loadBaseNetworkData(request: request)

        // Then
        waitForExpectations(timeout: 10.0)
        XCTAssertTrue(spy.presentBaseNetworkErrorWasCalled,
                      "loadBaseNetworkData(request:) should ask the presenter to show an error")
        
    }
}
