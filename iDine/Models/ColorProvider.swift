//
//  ColorProvider.swift
//  iDine
//
//  Created by Lewis Luther-Braun on 09/07/2019.
//  Copyright © 2019 HCOM. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ColorProvider: BindableObject {
    
    var didChange = PassthroughSubject<Void, Never>()
    
    let color: [String : Color] = ["D": .purple,
                                           "G": .blue,
                                           "N": .red,
                                           "V": .green,
                                           "S": .orange]
}
