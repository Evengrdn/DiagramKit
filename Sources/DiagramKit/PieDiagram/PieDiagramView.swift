//
//  PieDiagramView.swift
//  
//
//  Created by Maksim Kuznecov on 16.05.2022.
//

import SwiftUI

@available(macOS 12.0, *)
public struct PieDiagramView: View {
    
    private var pieData: [PieDiagramData] = []
    
    private let step = 0.5
    
    private let widthFraction = 0.75
    
    var summValueFormatter: (Double) -> String
    
    var innerCircleRadiusPercentFromMain: Double
    
    @State var selectedPieSlice: PieDiagramData? = nil
    
    private var pieDataSum: Double {
        return pieData.reduce(0, { result, entity in
            return result + entity.sourceData.value
        })
    }
    
    
    public init(data: [DiagramData], summValueFormatter: @escaping (Double) -> String = {String(format: "$%.2f", $0)},  innerCircleRadiusPercentFromMain: Double = 0.65) {
        
        self.innerCircleRadiusPercentFromMain = innerCircleRadiusPercentFromMain
        self.summValueFormatter = summValueFormatter
        
        let sum =  data.reduce(0, { result, entity in
            return result + entity.value
        })
        var endDeg: Double = 0
        
        
        data.forEach { entity in
            let degrees: Double = entity.value * 360 / sum
            let data = PieDiagramData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), percent: String(format: "%.0f%%", entity.value * 100 / sum), sourceData: entity)
            endDeg += degrees
            
            self.pieData.append(data)
        }
    }
    
    
    public var body: some View {
        
            GeometryReader{ geometry in
                VStack(alignment: .leading, spacing: 0){
                    HStack{
                        
                    
                        ZStack {
                            ForEach(pieData) { entity in
                                PieDiagramSliceView(pieDiagramData: entity)
                                    .scaleEffect(selectedPieSlice == entity ? 1.04 : 1.0)
                                    .frame(width: widthFraction * geometry.size.width, height: widthFraction * geometry.size.width)
                                    .gesture(
                                        DragGesture(minimumDistance: 0)
                                            .onChanged { value in
                                                let radius = step * widthFraction * geometry.size.width
                                                let diff = CGPoint(x: value.location.x - radius, y: radius - value.location.y)
                                                let dist = pow(pow(diff.x, 2.0) + pow(diff.y, 2.0), step)
                                                if (dist > radius || dist < radius * innerCircleRadiusPercentFromMain) {
                                                    selectedPieSlice = nil
                                                    return
                                                }
                                                var radians = Double(atan2(diff.x, diff.y))
                                                if (radians < 0) {
                                                    radians = 2 * Double.pi + radians
                                                }
                                                
                                                for entity in pieData {
                                                    if (radians < entity.endAngle.radians ) {
                                                        selectedPieSlice = entity
                                                        break
                                                    }
                                                }
                                                
                                            }
                                            .onEnded { _ in
                                                selectedPieSlice = nil
                                            })
                            }.overlay(
                                ZStack{
                                    ZStack{
                                        Circle()
                                            .fill(.black)
                                            .frame(width: widthFraction * geometry.size.width * innerCircleRadiusPercentFromMain, height: widthFraction * geometry.size.width * innerCircleRadiusPercentFromMain)
                                        
                                        VStack {
                                            Text(selectedPieSlice?.sourceData.title ?? "Total")
                                                .font(.title)
                                                .foregroundColor(Color.gray)
                                            Text(selectedPieSlice?.sourceData.format(selectedPieSlice?.sourceData.value ?? 0.0) ?? summValueFormatter(pieDataSum))
                                                .font(.title)
                                                .foregroundColor(Color.gray)
                                        }
                                    }
                                })
                        }
                        Spacer()
                    
                    }
                    PieDiagramHistoty(data: pieData).padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))

                }
//                Spacer()
                //            PieDiagramHistoty(data: pieData)
            }.frame(width: 800, height: 800)
        
        
        
        
    }
    
    @available(macOS 12.0, *)
    struct PieDiagramView_Previews: PreviewProvider {
        
        static var previews: some View {
            Group {
                PieDiagramView(data: [
                    DiagramData(value: 1500, title: "Rent", color: .blue, format: { String(format: "$%.2f", $0) }),
                    DiagramData(value: 500, title: "Transport", color: .green, format: { String(format: "$%.2f", $0) }),
                    DiagramData(value: 300, title: "Education", color: .orange, format: { String(format: "$%.2f", $0) })
                ])
            }
        }
    }
}
