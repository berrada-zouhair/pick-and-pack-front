//
//  DraftTest.swift
//  Pick and PackTests
//
//  Created by BERRADA on 26/11/2021.
//

import XCTest
@testable import Pick_and_Pack

class StatusHistoryTest: XCTestCase {

    func test_status_history_shoud_have_available_state_and_no_user_processing_when_created() throws {
        let statusHistory = StatusHistory()
        XCTAssertEqual(statusHistory.lastStatus, OrderStatus.available)
        XCTAssertNil(statusHistory.lastHistory.user)
    }
    
//    func test_status_history_shoud_keep_same_state_when_order_is_processed_by_a_user() throws {
//        let statusHistory = StatusHistory()
//        XCTAssertEqual(statusHistory.lastStatus, OrderStatus.available)
//        let result = statusHistory.setUserProcessing(user: "Zouhair")
//        XCTAssertEqual(result.lastStatus, result.lastStatus)
//    }
//    
//    func test_processing_user_shoud_get_user_name_when_processed_by_a_user() throws {
//        let statusHistory = StatusHistory()
//        XCTAssertEqual(statusHistory.lastStatus, OrderStatus.available)
//        let result = statusHistory.setUserProcessing(user: "Zouhair")
//        XCTAssertEqual(result.processingUser, "Zouhair")
//    }
//    
//    func test_processing_user_shoud_get_nil_as_user_name_when_not_processed() throws {
//        let statusHistory = StatusHistory()
//        XCTAssertEqual(statusHistory.processingUser, nil)
//    }
//    
//    func test_is_processing_shoud_get_true_when_processed() throws {
//        let statusHistory = StatusHistory()
//        let result = statusHistory.setUserProcessing(user: "Zouhair")
//        XCTAssertEqual(result.isProcessing, true)
//    }
//    
//    func test_is_processing_shoud_get_false_when_not_processed() throws {
//        let statusHistory = StatusHistory()
//        XCTAssertEqual(statusHistory.isProcessing, false)
//    }
//    
//    func test_process_order_should_add_new_entry_with_a_user_and_nil_completed_date() throws {
//        let statusHistory = StatusHistory()
//        var result = statusHistory.startProcessingNextStatus(by: "Zouhair")
//        XCTAssertEqual(statusHistory.isProcessing, true)
//        XCTAssertEqual(statusHistory.processingUser, "Zouhair")
//        XCTAssertEqual(statusHistory.lastStatus, .collected)
//        XCTAssertEqual(statusHistory.lastCompletedStatus, .available)
//    }

}
