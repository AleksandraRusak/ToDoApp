//
//  ToDoAppTests.swift
//  ToDoAppTests
//
//  Created by Aleksandra Rusak on 2023-10-24.
//

import XCTest
@testable import ToDoApp

final class ToDoAppTests: XCTestCase {

    var sut: APIImage!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = APIImage()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    // Create an expectation that must be fulfilled when the completion handler is called, which you expect to happen when the image is fetched.
    func testGetImageWithCompletion() throws {
            let expectation = self.expectation(description: "Completion handler invoked")
            var image: UIImage?
            var responseError: Error?

            sut.getImageWithCompletion { img, error in
                image = img
                responseError = error
                expectation.fulfill()
            }

        
            waitForExpectations(timeout: 5, handler: nil)

        // assertions check if an image is returned and if no error occurred
            XCTAssertNotNil(image, "No image was downloaded.")
            XCTAssertNil(responseError, "An unexpected error occurred: \(responseError?.localizedDescription ?? "")")
        }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
