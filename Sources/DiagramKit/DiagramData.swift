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
    
    public init(id: UUID = UUID(), value: Double, title: String, color: Color, format: @escaping (Double) -> String) {
        self.id = id
        self.value = value
        self.title = title
        self.color = color
        self.format = format
    }
    
    public static func == (lhs: DiagramData, rhs: DiagramData) -> Bool {
        lhs.id == rhs.id
    }
    
    public var id: UUID = UUID()
    public var value: Double
    public var title: String
    public var color: Color
    public var format: (Double) -> String
    
}
