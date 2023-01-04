//
//  Orders.swift
//  Pick and Pack
//
//  Created by BERRADA on 24/11/2021.
//

import Foundation


struct Data {
    
    private init() {}
    
    static var users: [User] = [
        .init(id: "Antoine", name: "Antoine"),
        .init(id: "Sophie", name: "Sophie"),
        .init(id: "Jean-Marc", name: "Jean-Marc"),
        .init(id: "Fronçois", name: "Fronçois"),
        .init(id: "Christophe", name: "Christophe"),
        .init(id: "Zouhair", name: "Zouhair")
    ]
    
    static var currentUser = users[users.count-1]
    
    static var clients: [Client] = [
        .init(id: "Auchan", name: "Auchan", image: "Auchan"),
        .init(id: "Carrefour", name: "Carrefour", image: "Carrefour"),
        .init(id: "Monoprix", name: "Monoprix", image: "Monoprix"),
        .init(id: "Leclerc", name: "Leclerc", image: "Leclerc"),
        .init(id: "Casino", name: "Casino", image: "Casino"),
        .init(id: "Leader Price", name: "Leader Price", image: "Leader Price")
    ]
    
    static var products: [Product] = [
        .init(id: "Chocolat", name: "Chocolat"),
        .init(id: "Café", name: "Café"),
        .init(id: "Chips", name: "Chips"),
        .init(id: "Jus", name: "Jus"),
        .init(id: "Miel", name: "Miel"),
        .init(id: "Infusions", name: "Infusions")
    ]
    
    private static func createRandomItems() -> [Product:Int] {
        products.shuffled()[0...Int.random(in: 1..<products.count)].reduce([Product:Int]()) { partialResult, product in
            var result = partialResult
            result[product] = Int.random(in: 1...20)
            return result
        }
    }
    
    private static func createStatusHistory() -> StatusHistory {
        .init()
    }
    
    private static func generateUUID() -> String {
        let uuid = UUID().description
        let start = uuid.startIndex
        let end = uuid.index(uuid.startIndex, offsetBy: 8)
        let range = start..<end
        return String(uuid[range])
    }
    
    static var data: [Order] = (1...6).map { index in
        return .init(id: generateUUID(), client: clients[Int.random(in: 0..<6)], items: createRandomItems(), statusHistory: createStatusHistory())
    }
    
    
}
