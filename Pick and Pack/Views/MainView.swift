//
//  MainView.swift
//  Pick and Pack
//
//  Created by BERRADA on 22/11/2021.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var orders: Orders
    @State var editMode: EditMode = .inactive
    
    private func getOrdersBy(orderStatus: OrderStatus) -> Binding<[Order]> {
        switch orderStatus {
        case .available:
            return $orders.available
        case .collected:
            return $orders.collected
        case .packaged:
            return $orders.packaged
        case .shipped:
            return $orders.shipped
        }
    }
    
    var body: some View {
        TabView {
            ForEach(OrderStatus.allCases, id: \.self) { orderStatus in
                OrdersView(data: getOrdersBy(orderStatus: orderStatus), orderStatus: orderStatus, editMode: $editMode)
                    .tabItem {
                        VStack {
                            Image(systemName: orderStatus.description().imageSystemName)
                            Text("\(orderStatus.description().name)s")
                        }
                    }
                    .tag(orderStatus.rawValue + 1)
            }
        }
        .onAppear {
            editMode = .inactive
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
