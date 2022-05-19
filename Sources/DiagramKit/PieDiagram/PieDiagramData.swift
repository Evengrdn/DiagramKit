//
//  PieDiagramData.swift
//  
//
//  Created by Maksim Kuznecov on 16.05.2022.
//

import Foundation
import SwiftUI

@available(macOS 10.15, *)
struct PieDiagramData: Identifiable, Equatable {
    
    static func == (lhs: PieDiagramData, rhs: PieDiagramData) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: UUID = UUID()
    var startAngle: Angle
    var endAngle: Angle
    var percent: String
    
    var sourceData: DiagramData
    
    
}
