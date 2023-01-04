//
//  OrderDetailsView.swift
//  Pick and Pack
//
//  Created by BERRADA on 23/11/2021.
//

import SwiftUI

struct OrderDetailsView: View {
    
    @Binding var order: Order
    
    @EnvironmentObject var allOrders: Orders
    
    func getDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter
    }
    
    private func showStartProcessOrderButton() -> Bool {
        !order.isCompleted && !order.isProcessing
    }
    
    private func showFinishProcessOrderButton() -> Bool {
        order.isProcessing
    }
    
    var body: some View {
        Form {
            Section("Infos générales") {
                HStack {
                    Text("Commande")
                    Spacer()
                    Text("\(order.id)")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Nombre de produits")
                    Spacer()
                    Text("\(order.productsCount)")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Nombre d'articles")
                    Spacer()
                    Text("\(order.itemsCount)")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Client")
                    Spacer()
                    Text("\(order.client.name)")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Statut")
                    Spacer()
                    Text("\(order.status.description().name)")
                        .foregroundColor(.secondary)
                }
            }
            
            Section(header: Text("Historique Statuts")) {
                ForEach(order.statusHistory.allCompletedHistories, id: \.status) { entry in
                    HStack {
                        Text("\(entry.status.description().name)")
                            .frame(width: 115, alignment: .leading)
                        Spacer()
                        Text("\(getDateFormatter().string(from: entry.completedDate!))")
                            .foregroundColor(.secondary)
                            .frame(width: 60, alignment: .center)
                        Spacer()
                        Text("\(entry.user ?? "-")")
                            .foregroundColor(.secondary)
                            .frame(width: 115, alignment: .trailing)
                    }
                }
                
                if order.isProcessing {
                    HStack {
                        Text("\(order.status.description().inProgress!)")
                            .frame(width: 115, alignment: .leading)
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(width: 60, alignment: .center)
                        Spacer()
                        Text("\(order.processingUser!)")
                            .foregroundColor(.secondary)
                            .frame(width: 115, alignment: .trailing)
                    }
                }
                
                if showStartProcessOrderButton() {
                    Button(order.status.description().startProcessing!) {
                        let resultStatusHistory = order.statusHistory.startProcessingNextStatus(by: Data.currentUser.name)
                        allOrders.updateData(of: order, by: resultStatusHistory)
                    }
                    .foregroundColor(.red)
                }
                if showFinishProcessOrderButton() {
                    Button(order.status.description().endProcessing!) {
                        let resultStatusHistory = order.statusHistory.finishProcessingStatus(at: Date.now)
                        allOrders.updateData(of: order, by: resultStatusHistory)
                    }
                    .foregroundColor(.red)
                }
            }
            
            Section(header: Text("Articles")) {
                ForEach(order.items.sorted(by: { pair1, pair2 in
                    pair1.key < pair2.key
                }), id: \.key) { element in
                    HStack {
                        Text("\(element.key.name)")
                        Spacer()
                        Text("\(element.value)")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }.navigationTitle("Détails")
    }
}

struct OrderDetailsView_Previews: PreviewProvider {
    
    struct StatefulPreviewContent: View {
        var body: some View {
            OrderDetailsView(order: .constant(Data.data[0]))
        }
    }
    
    static var previews: some View {
        StatefulPreviewContent()
    }
}
