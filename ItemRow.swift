//
//  ItemRow.swift
//  iDine
//
//  Created by Lewis Luther-Braun on 09/07/2019.
//  Copyright © 2019 HCOM. All rights reserved.
//

import SwiftUI

struct ItemRow: View {
    @EnvironmentObject var order: Order
    static let colors: [String : Color] = ["D": .purple,
                                           "G": .blue,
                                           "N": .red,
                                           "V": .green,
                                           "S": .orange]
    
    var item: MenuItem
    var body: some View {
        NavigationLink(destination: ItemDetail(item: item).environmentObject(order)) {
            HStack {
                Image(item.thumbnailImage)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text("$\(item.price)")
                }
                
                Spacer()
                
                ForEach(item.restrictions.identified(by: \.self)) { restriction in
                    Text(restriction)
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(5)
                        .background(Self.colors[restriction])
                        .clipShape(Circle())
                        .foregroundColor(.white)

                }
            }
        }
    }
}

#if DEBUG
struct ItemRow_Previews : PreviewProvider {
    static let order = Order()
    static var previews: some View {
        ItemRow(item: MenuItem.example)
    }
}
#endif
