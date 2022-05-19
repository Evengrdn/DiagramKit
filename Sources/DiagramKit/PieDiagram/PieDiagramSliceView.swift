//
//  PieDiagramSliceView.swift
//  
//
//  Created by Maksim Kuznecov on 16.05.2022.
//

import SwiftUI

@available(macOS 10.15, *)
struct PieDiagramSliceView: View {
    
    let pieDiagramData: PieDiagramData
    
    var midRadians: Double {
        return Double.pi / 2.0 - (pieDiagramData.startAngle + pieDiagramData.endAngle).radians / 2.0
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                Path { path in
                    let width: CGFloat = min(geometry.size.width, geometry.size.height)
                    let height = width
                    path.move(
                        to: CGPoint(
                            x: width * 0.5,
                            y: height * 0.5
                        )
                    )
                    
                    path.addArc(center: CGPoint(x: width * 0.5, y: height * 0.5), radius: width * 0.5, startAngle: Angle(degrees: -90.0) + pieDiagramData.startAngle, endAngle: Angle(degrees: -90.0) + pieDiagramData.endAngle, clockwise: false)
                    
                }
                .fill(pieDiagramData.sourceData.color)
                
                Text(pieDiagramData.percent)
                    .position(
                        x: geometry.size.width * 0.5 * CGFloat(1.0 + 0.8 * cos(self.midRadians)),
                        y: geometry.size.height * 0.5 * CGFloat(1.0 - 0.8 * sin(self.midRadians))
                    )
                    .foregroundColor(Color.white)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

@available(macOS 10.15, *)
struct PieDiagramSliceView_Previews: PreviewProvider {
    
    static var previews: some View {
        PieDiagramSliceView(pieDiagramData: PieDiagramData(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 100), percent: "65%", sourceData: DiagramData(value: 1500, title: "Rent", color: .blue, format: { String(format: "$%.2f", $0) })))
    }
}
