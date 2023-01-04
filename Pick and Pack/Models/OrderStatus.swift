//
//  OrderStatus.swift
//  Pick and Pack
//
//  Created by BERRADA on 22/11/2021.
//

import Foundation

struct OrderStatusDescription {
    let name: String
    let inProgress: String?
    let startProcessing: String?
    let endProcessing: String?
    let imageSystemName: String
}

enum OrderStatus: Int, CaseIterable {
    case available
    case collected
    case packaged
    case shipped
    
    func next() -> OrderStatus? {
        guard self != .shipped else {
            return nil
        }
        return OrderStatus.allCases[self.rawValue + 1]
    }
    
    func hasNext() -> Bool {
        next() != nil
    }
    
    func description() -> OrderStatusDescription {
        switch self {
        case .available:
            return OrderStatusDescription(
                name: "Disponible",
                inProgress: "En collecte",
                startProcessing: "Collecter la commande",
                endProcessing: "Terminer la collection",
                imageSystemName: "checklist")
        case .collected:
            return OrderStatusDescription(
                name: "Collectée",
                inProgress: "En packaging",
                startProcessing: "Packager la commande",
                endProcessing: "Terminer le packaging",
                imageSystemName: "cart")
        case .packaged:
            return OrderStatusDescription(
                name: "Packagée",
                inProgress: "En expédition",
                startProcessing: "Expédier la commande",
                endProcessing: "Terminer l'expédition",
                imageSystemName: "shippingbox")
        case .shipped:
            return OrderStatusDescription(
                name: "Expédiées",
                inProgress: nil,
                startProcessing: nil,
                endProcessing: nil,
                imageSystemName: "paperplane")
        }
    }
}


