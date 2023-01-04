//
//  Order.swift
//  Pick and Pack
//
//  Created by BERRADA on 24/11/2021.
//

import Foundation

struct Order: Identifiable {
    var id: String
    
    var client: Client
    
    var items: [Product:Int]
    
    var statusHistory: StatusHistory
    
    var productsCount: Int {
        get {
            items.count
        }
        set {}
    }
    
    var itemsCount: Int {
        get {
            items.values.reduce(0, +)
        }
        set {}
    }
    
    var status: OrderStatus {
        statusHistory.lastCompledStatus
    }
    
    var nextStatus: OrderStatus? {
        status.next()
    }
    
    var processingUser: String? {
        statusHistory.processingUser
    }
    
    var isCompleted: Bool {
        statusHistory.isCompleted
    }
    
    var isProcessing: Bool {
        statusHistory.isProcessing
    }
}
