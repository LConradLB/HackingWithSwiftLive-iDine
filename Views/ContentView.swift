//
//  ContentView.swift
//  iDine
//
//  Created by Lewis Luther-Braun on 09/07/2019.
//  Copyright © 2019 HCOM. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let menu = Bundle.main.decode([MenuSection].self,
                                  from: "menu.json")
    
    @EnvironmentObject var order: Order
    
    var body: some View {
        NavigationView {
            List {
                ForEach(menu) { section in
                    Section(header: Text(section.name).font(.subheadline), content: {
                        ForEach(section.items) { item in
                            ItemRow(item: item)
                        }
                    })
                }
            }
            .navigationBarTitle("Menu")
            .listStyle(.grouped)
        }
    }
        
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
