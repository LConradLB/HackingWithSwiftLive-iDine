//
//  CheckoutView.swift
//  iDine
//
//  Created by Lewis Luther-Braun on 09/07/2019.
//  Copyright © 2019 HCOM. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    @State private var paymentType = 0
    @State private var addLoyaltyDetails = false
    @State private var loyalityNumber = ""
    @State private var tipAmount = 1
    
    static let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    static let tipAmounts = [0, 5, 10, 15, 20, 25]
    
    var totalPrice: Double {
        let total = Double(order.total)
        let tip =  total / 100 * Double(Self.tipAmounts[tipAmount])
        
        return total + tip
    }
    
    var body: some View {
        Form {
            Section {
                Picker(selection: $paymentType, label: Text("How do you want to pay?")){  ForEach(0 ..< Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
                
                Toggle(isOn: $addLoyaltyDetails) {
                    Text("Add iDine Loyality Card")
                }
                
                if addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: $loyalityNumber)
                }
        
            }
            
            Section(header: Text("Add A Tip")) {
                SegmentedControl(selection: $tipAmount){
                    ForEach( 0 ..< Self.tipAmounts.count) {
                        Text("\(Self.tipAmounts[$0])%")
                    }
                }
            }
            
            Section(header: Text("Order Total: $\(totalPrice, specifier: "%.2f")")) {
                Button(action: {
                    //place order
                }) {
                    Text("Confirm Order")
                }
            }
        }
    }
}


#if DEBUG
struct CheckoutView_Previews : PreviewProvider {
    static let order = Order()
    static var previews: some View {
        CheckoutView().environmentObject(order)
    }
}
#endif
