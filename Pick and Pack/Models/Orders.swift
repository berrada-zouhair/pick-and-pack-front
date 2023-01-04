//
//  Orders.swift
//  Pick and Pack
//
//  Created by BERRADA on 26/11/2021.
//

import Foundation

class Orders: ObservableObject {
    
    init() {}
    
    @Published var data = Data.data
    var buffer: [Order] = []
    
    private var x: (Order, Order) -> Bool = {o1, o2 in
        if o1.isProcessing && !o2.isProcessing {
            return false
        }
        else if !o1.isProcessing && o2.isProcessing {
            return true
        }
        else if !o1.isProcessing && !o2.isProcessing {
            return false
        }
        else { // o1.isProcessing && o2.isProcessing {
            return false
        }
    }
    
    func getOrdersBy(status: OrderStatus) -> [Order] {
        data.filter { order in
            order.status == status
        }
    }
    
    var available: [Order] {
        get {
            return data.filter { order in
                order.status == .available
            }.sorted(by: x)
        }
        set {}
    }
    
    var collected: [Order] {
        get {
            data.filter { order in
                order.status == .collected
            }
        }
        set {}
    }
    
    var packaged: [Order] {
        get {
            data.filter { order in
                order.status == .packaged
            }
        }
        set {}
    }
    
    var shipped: [Order] {
        get {
            data.filter { order in
                order.status == .shipped
            }
        }
        set {}
    }
    
    func updateData(of: Order, by: StatusHistory) {
        data = data.map { order in
            var result = order
            if order.id == of.id {
                result.statusHistory = by
            }
            return result
        }
    }
    
    func hideProcessedOrders() {
        buffer = data.filter{ order in
            order.isProcessing
        }
        data = data.filter{ order in
            !order.isProcessing
        }
    }
    
    func revealProcessedOrders() {
        data += buffer
        buffer = []
    }
    
    
    
}
