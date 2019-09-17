import XCTest
@testable import RxOptional

final class RxOptionalTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(RxOptional().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
