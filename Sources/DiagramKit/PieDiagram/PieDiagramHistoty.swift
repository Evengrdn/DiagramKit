//
//  PieDiagramHistoty.swift
//  
//
//  Created by Maksim Kuznecov on 22.05.2022.
//

import SwiftUI

@available(macOS 10.15, *)
struct PieDiagramHistoty: View {
    
    var data: [PieDiagramData]
    
    var body: some View {
        HStack{
            VStack{ 
                ForEach(data) { entity in
                    HStack{
                        RoundedRectangle(cornerRadius: 6)
                            .fill(entity.sourceData.color)
                            .frame(width: 40, height: 20, alignment: .leading)
                        Text(entity.sourceData.title)
                        Text(entity.sourceData.format(entity.sourceData.value))
                        Spacer()
                    }
                }
            }
        }
            
        
    }
}
