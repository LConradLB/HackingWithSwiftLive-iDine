//
//  ItemDetail.swift
//  iDine
//
//  Created by Lewis Luther-Braun on 09/07/2019.
//  Copyright © 2019 HCOM. All rights reserved.
//

import SwiftUI

struct ItemDetail : View {
    let item: MenuItem
    @EnvironmentObject var order: Order
    @EnvironmentObject var colors: ColorProvider
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                ZStack(alignment: .bottomTrailing) {
                    Image(item.mainImage)
                    Text("Photo: \(item.photoCredit)")
                        .padding(4)
                        .background(Image(item.mainImage)
                            .blur(radius: 10)
                            .saturation(0.3)
                            .brightness(-0.2))
                        .font(.caption)
                        .foregroundColor(.white)
                        .cornerRadius(5, antialiased: true)
                        .offset(x: -5, y: -5)
                }
            }
                VStack(alignment: .center){
                    HStack(alignment: .center){
                        ForEach(item.restrictions.identified(by: \.self)) { restriction in
                            Text(restriction)
                                .font(.caption)
                                .fontWeight(.black)
                                .padding(5)
                                .background(self.colors.color[restriction])
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(50)
                
                Text(item.description)
                    .lineLimit(nil)
                    .padding()
            }
            
            VStack(alignment: .center){
                
                Button(action: {
                    self.order.add(item: self.item)
                    
                }) {
                        Text("Order This")
                            .padding()
                }
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10, antialiased: true)
                
                
                Spacer()
            }
        }
        .navigationBarTitle(Text(item.name), displayMode: .inline)
    }
}

#if DEBUG
struct ItemDetail_Previews : PreviewProvider {
    static var previews: some View {
        ItemDetail(item: MenuItem.example)
    }
}
#endif
