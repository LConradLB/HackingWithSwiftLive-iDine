//
//  TabView.swift
//  iDine
//
//  Created by Lewis Luther-Braun on 09/07/2019.
//  Copyright © 2019 HCOM. All rights reserved.
//

import SwiftUI

struct TabView: View {
    @EnvironmentObject var order: Order
    
    var body: some View {
        TabbedView {
            ContentView()
                .tabItem {
                    VStack {
                        Image("system-list")
                    }
                    Text("Menu")
                }.tag(0)
            
            OrderView().environmentObject(order)
                .tabItem {
                    VStack {
                        Image("system-compose")
                    }
                    Text("Order")
            }.tag(1)
        }
    }
}

#if DEBUG
struct TabView_Previews : PreviewProvider {
    static var previews: some View {
        TabView()
    }
}
#endif
