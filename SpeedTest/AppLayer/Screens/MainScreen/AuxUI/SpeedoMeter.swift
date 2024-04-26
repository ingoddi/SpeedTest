//
//  SpeedoMeter.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 25.04.2024.
//

import SwiftUI

struct SpeedoMeter: View {
    @Binding var progress : Float
    
    let colors: [Color]
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        
        ZStack{
            ZStack{
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(Color.black.opacity(0.1), lineWidth: 55)
                    .frame(width: width, height: height)
                
                Circle()
                    .trim(from: 0, to: self.setProgress())
                    .stroke(AngularGradient(gradient: .init(colors: self.colors), center: .center, angle: .init(degrees: 180)), lineWidth: 55)
                    .frame(width: width, height: height)
            }
            .rotationEffect(.init(degrees: 180))
        }
        .padding(.bottom, -140)
    }
    
    func setProgress() -> CGFloat {
        let temp = self.progress / 2
        return CGFloat(temp)
    }
}

