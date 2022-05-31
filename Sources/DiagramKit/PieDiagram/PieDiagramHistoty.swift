//
//  PieDiagramHistoty.swift
//  
//
//  Created by Maksim Kuznecov on 22.05.2022.
//

import SwiftUI

@available(macOS 11, *)
struct PieDiagramHistoty: View {
    
    var data: [PieDiagramData]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView{
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data) { entity in
                    
                    HStack{
                        Spacer()
                        RoundedRectangle(cornerRadius: 6)
                            .fill(entity.sourceData.color)
                            .frame(width: 40, height: 20, alignment: .leading)
                        Spacer()
                        HStack{
                            Spacer()
                            Text(entity.sourceData.title)
                            Text(entity.sourceData.format(entity.sourceData.value))
                            Spacer()
                        }
                        Spacer()
                    }
                    
                }
            }
            .padding(.horizontal)
            
            //            HStack{
            //                VStack{
            //                    ForEach(data) { entity in
            //                        HStack{
            //                            RoundedRectangle(cornerRadius: 6)
            //                                .fill(entity.sourceData.color)
            //                                .frame(width: 40, height: 20, alignment: .leading)
            //                            Text(entity.sourceData.title)
            //                            Text(entity.sourceData.format(entity.sourceData.value))
            //                            Spacer()
            //                        }
            //                    }
            //                }
            //            }
        }
        
    }
}
