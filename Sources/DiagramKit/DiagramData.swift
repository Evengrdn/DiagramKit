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
    
    public static func == (lhs: DiagramData, rhs: DiagramData) -> Bool {
        lhs.id == rhs.id
    }
    
    public var id: UUID = UUID()
    public var value: Double
    public var title: String
    public var color: Color
    public var format: (Double) -> String
    
}
