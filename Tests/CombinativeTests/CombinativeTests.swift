import XCTest
import Combine
@testable import Combinative


final class CombinativeTests: XCTestCase {
  func testButton() {
    let expect = expectation(description: "testButton")
    
    let button = UIButton()
    _ = button.cmb.tap.sink(receiveValue: { _ in
      expect.fulfill()
    })
    let notification = Notification.Name(for: .primaryActionTriggered)
    NotificationCenter.combinative.post(name: notification, object: button)
    
    waitForExpectations(timeout: 1) { (error) in
      if let error = error {
        print(error)
        XCTFail("ExpectaionTimeOut")
      }
    }
  }

  static var allTests = [
    ("testButton", testButton),
  ]
}

