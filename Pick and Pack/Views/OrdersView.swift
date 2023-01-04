//
//  ProcessingOrdersView.swift
//  Pick and Pack
//
//  Created by BERRADA on 22/11/2021.
//

import SwiftUI

extension EditMode {
    var text: String {
        self == .active ? "Active" : "Inactive"
    }
}

struct RowListView: View {
    
    @Binding var order: Order
    @State var showConfirmation = false
    @EnvironmentObject var allOrders: Orders
    
    var body: some View {
        HStack {
            Image(order.client.image)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: 90, height: 90)
                .padding(.trailing)
                .saturation(order.isProcessing ? 0 : 1)
                .opacity(order.isProcessing ? 0.7: 1)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Nombre Produits:")
                        .font(order.isProcessing ? .subheadline : .headline)
                        .opacity(order.isProcessing ? 0.7: 1)
                    Text("\(order.productsCount)")
                        .font(order.isProcessing ? .subheadline : .headline)
                        .foregroundColor(order.isProcessing ? .primary : .accentColor)
                        .opacity(order.isProcessing ? 0.7: 1)
                    
                }
                
                HStack {
                    Text("Nombre Articles:")
                        .font(order.isProcessing ? .subheadline : .headline)
                        .opacity(order.isProcessing ? 0.7: 1)
                    Text("\(order.itemsCount)")
                        .font(order.isProcessing ? .subheadline : .headline)
                        .foregroundColor(order.isProcessing ? .primary : .accentColor)
                        .opacity(order.isProcessing ? 0.7: 1)
                    
                }
                
                if order.isProcessing {
                    HStack {
                        Text("Responsable:")
                            .font(order.isProcessing ? .subheadline : .headline)
                            .opacity(order.isProcessing ? 0.7: 1)
                        Text("\(order.processingUser!)")
                            .font(order.isProcessing ? .subheadline : .headline)
                            .foregroundColor(order.isProcessing ? .primary : .accentColor)
                            .opacity(order.isProcessing ? 0.7: 1)
                        
                    }
                }
            }
            if order.isProcessing {
                Image(systemName: "lock.fill")
                    .padding(.leading)
                    .foregroundColor(.gray)
            }
        }
//        .confirmationDialog("Affecter", isPresented: $showConfirmation, actions: {
//            Button("Affecter", role: .destructive, action: {
//                let resultStatusHistory = order.statusHistory.startProcessingNextStatus(by: Data.currentUser.name)
//                allOrders.updateData(of: order, by: resultStatusHistory)
//            })
//            Button("Annuler", role: .cancel, action: {
//            })
//        })
//        .onLongPressGesture {
//            showConfirmation = true
//        }
    }
}

struct ToolbarView: View {
    
    @Binding var editMode: EditMode
    @Binding var selectedOrders: Set<String>
    @Binding var showConfirmationAlert: Bool
    var orderStatus: OrderStatus
    @EnvironmentObject var allOrders: Orders
    
    var body: some View {
        Text("")
    }
}

struct AlertView: View {
    
    @Binding var editMode: EditMode
    @EnvironmentObject var allOrders: Orders
    @Binding var selectedOrders: Set<String>
    @Binding var orders: [Order]
    
    var body: some View {
        Button("Affecter", role: .destructive, action: {
            selectedOrders.forEach { orderId in
                let order = orders.first { order in
                    order.id == orderId
                }!
                let resultStatusHistory = order.statusHistory.startProcessingNextStatus(by: Data.currentUser.name)
                allOrders.updateData(of: order, by: resultStatusHistory)
            }
            editMode = .inactive
            selectedOrders.removeAll()
            allOrders.revealProcessedOrders()
        })
        Button("Annuler", role: .cancel, action: {
            editMode = .inactive
            selectedOrders.removeAll()
            allOrders.revealProcessedOrders()
        })
    }
}

struct ListView: View {
    
    @Binding var editMode: EditMode
    @EnvironmentObject var allOrders: Orders
    @Binding var selectedOrders: Set<String>
    let orderStatus: OrderStatus
    @Binding var data: [Order]
    
    var body: some View {
        List($data, selection: $selectedOrders) { order in
            NavigationLink {
                OrderDetailsView(order: order)
            } label: {
                RowListView(order: order)
            }
        }
        .listStyle(InsetListStyle())
        .padding(.top)
        .environment(\.editMode, $editMode)
        .navigationTitle(orderStatus.description().name + "s")
    }
}

struct OrdersView: View {
    
    @EnvironmentObject var allOrders: Orders
    
    @State var selectedOrders: Set<String> = Set<String>()
    
    @State var showConfirmationAlert: Bool = false
    
    @Binding var data: [Order]
    
    @State var showToolbar = false
        
    var orderStatus: OrderStatus
    
    @Binding var editMode: EditMode
    
    private func getAlertMessage() -> String {
        "Êtes-vous sûr de vous affecter \(selectedOrders.count > 1 ? "les" : "la") \(selectedOrders.count > 1 ? String(selectedOrders.count) : "") commande\(selectedOrders.count > 1 ? "s" : "") sélectionnée\(selectedOrders.count > 1 ? "s" : "")"
    }
    
    var body: some View {
        NavigationView {
            ListView(editMode: $editMode, selectedOrders: $selectedOrders, orderStatus: orderStatus, data: $data)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if orderStatus != .shipped && data.filter{!$0.isProcessing}.count > 0 {
                            Button {
                                if editMode == .active {
                                    //Bouton Annuler
                                    selectedOrders.removeAll()
                                    allOrders.revealProcessedOrders()
                                    editMode = .inactive
                                } else {
                                    allOrders.hideProcessedOrders()
                                    editMode = .active
                                }
//                                editMode = editMode == .inactive ? .active : .inactive
                            } label: {
                                Text(editMode == .inactive ? "Affectation" : "Annuler")
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if editMode == .inactive {
                            Menu {
                                Button {
                                    
                                } label: {
                                    HStack {
                                        Image(systemName: "power")
                                        Text("Se déconnecter")
                                    }
                                }
                                Button {
                                    
                                } label: {
                                    HStack {
                                        Image(systemName: "clock")
                                        Text("Mon historique")
                                    }
                                }
                            } label: {
                                Image(systemName: "ellipsis.circle")
                            }
                        } else if selectedOrders.count > 0 {
                            Button {
                                showConfirmationAlert = true
                            } label: {
                                Text("Valider")
                            }
                        }
                    }
                }
                .alert("Affectation", isPresented: $showConfirmationAlert) {
                    AlertView(editMode: $editMode, selectedOrders: $selectedOrders, orders: $data)
                } message: {
                    Text(getAlertMessage())
                }
        }
        .onAppear {
            showToolbar = true
        }
    }
}

struct ProcessingOrdersView_Previews: PreviewProvider {
    
    struct StatefulPreviewContent: View {
        
        @EnvironmentObject var orders: Orders
        
        var body: some View {
            OrdersView(data: $orders.data, orderStatus: .available, editMode: .constant(.inactive))
        }
    }
    
    static var previews: some View {
        StatefulPreviewContent()
    }
}
