//
//  StatusHistory.swift
//  Pick and Pack
//
//  Created by BERRADA on 24/11/2021.
//

import Foundation

struct StatusHistoryEntry {
    var status: OrderStatus
    var completedDate: Date?
    var user: String?
}

struct StatusHistory {
    var entries: [StatusHistoryEntry]
    
    var lastHistory: StatusHistoryEntry {
        entries.last!
    }
    
    var lastStatus: OrderStatus {
        lastHistory.status
    }
    
    var lastCompledHistory: StatusHistoryEntry {
        entries.last { statusHistoryEntry in
            statusHistoryEntry.completedDate != nil
        }!
    }
    
    var lastCompledStatus: OrderStatus {
        lastCompledHistory.status
    }
    
    var processingUser: String? {
        lastHistory.user
    }
    
    var isProcessing: Bool {
        lastHistory.user != nil && lastHistory.completedDate == nil
    }
    
    var isCompleted: Bool {
        lastCompledHistory.status == .shipped && lastCompledHistory.completedDate != nil
    }
    
    var allCompletedHistories: [StatusHistoryEntry] {
        entries.filter { statusHistoryEntry in
            statusHistoryEntry.completedDate != nil
        }
    }
    
    init(entries: [StatusHistoryEntry]) {
        self.entries = entries
    }
    
    init() {
        entries = []
        entries.append(StatusHistoryEntry(status: .available, completedDate: Date.now, user: nil))
    }
    
//    func setUserProcessing(user: String) -> StatusHistory {
//        var result = entries
//        result[result.count-1].user = user
//        return StatusHistory(entries: result)
//    }
    
    func startProcessingNextStatus(by: String) -> StatusHistory {
        if lastCompledStatus.hasNext() {
            var result = entries
            result.append(StatusHistoryEntry(status: lastCompledStatus.next()!, completedDate: nil, user: by))
            return StatusHistory(entries: result)
        }
        return self
    }
    
    func finishProcessingStatus(at: Date) -> StatusHistory {
        if isProcessing {
            var result = entries
            result[result.count - 1].completedDate = at
            return StatusHistory(entries: result)
        }
        return self
    }
    
//    func startProcessingNextStatus(user: String) -> StatusHistory {
//        
//    }
    
//    func addHistory(status: OrderStatus, completedDate: Date?, user: String?) -> StatusHistory {
//        var x = entries
//        x.append((status: status, completedDate: completedDate, user: user))
//        return StatusHistory(history: x)
//    }
//    
//    func setLastHistoryDate(newDate: Date) -> StatusHistory {
//        let updatedHistory = entries.map { statusHistoryEntry -> StatusHistoryEntry in
//            if date == nil {
//                return (status, newDate, user)
//            } else {
//                return (status, date, user)
//            }
//        }
//        return StatusHistory(entries: updatedHistory)
//    }
}
