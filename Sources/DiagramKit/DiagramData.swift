//
//  DiagramData.swift
//  
//
//  Created by Maksim Kuznecov on 16.05.2022.
//

import Foundation
import SwiftUI


@available(macOS 10.15, *)
public struct DiagramData: Identifiable, Equatable {
    
    static func == (lhs: DiagramData, rhs: DiagramData) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: UUID = UUID()
    var value: Double
    var title: String
    var color: Color
    var format: (Double) -> String
    
}
