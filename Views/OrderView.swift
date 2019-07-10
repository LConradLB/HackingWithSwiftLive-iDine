//
//  OrderView.swift
//  iDine
//
//  Created by Lewis Luther-Braun on 09/07/2019.
//  Copyright © 2019 HCOM. All rights reserved.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order
    @EnvironmentObject var colors: ColorProvider
    
    func removeItemFromOrder(index: IndexSet){
        if let itemToRemove = index.first {
            order.items.remove(at: itemToRemove)
        }
    }
    
    func retrieveUniqueRestrictions() -> [String]{
        let uniqueItems: [MenuItem] = order.items.unique()
        var restrictions: [String] = []
        uniqueItems.forEach { (menuItem) in
            restrictions += menuItem.restrictions
        }

        return restrictions.unique()
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Order")) {
                    
                    HStack{
                        Text("Food Infomation:")
                        ForEach(retrieveUniqueRestrictions().identified(by: \.self)) { restriction in
                            Text(restriction)
                                .font(.caption)
                                .fontWeight(.black)
                                .padding(5)
                                .background(self.colors.color[restriction])
                                .clipShape(Circle())
                                .foregroundColor(.white)
                            
                        }
                    }
                    
                    ForEach(order.items.unique()) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                            Text("Quantity: \(((self.order.items).filter({filterItem in return item.name == filterItem.name})).count)")
                            Button(action: {
                                self.order.add(item: item)
                            }){
                              Text("+")
                                .padding(3)
                                .background(Color.green)
                                .clipShape(Circle())
                                .foregroundColor(Color.white)
                            }
                        }
                    }.onDelete(perform: removeItemFromOrder(index:))
                }
                
                Section{
                    NavigationLink(destination: CheckoutView().environmentObject(order)) {
                        Text("Place Order")
                    }
                }
            }
            .navigationBarTitle("Order")
            .listStyle(.grouped)
        }
    }
    
}

#if DEBUG
struct OrderView_Previews : PreviewProvider {
    static let order = Order()
    static var previews: some View {
        OrderView().environmentObject(order)
    }
}
#endif

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}
