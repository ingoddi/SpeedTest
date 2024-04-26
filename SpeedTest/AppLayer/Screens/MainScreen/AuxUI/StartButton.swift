//
//  PulseButton.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 25.04.2024.
//

import SwiftUI

struct StartButton: View {
    @Binding var bool: Bool
    
    var width: CGFloat
    var heght: CGFloat
    
    @State private var animate = false
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: width, height: heght)
                .foregroundColor(.blue)
            Button(action: {
                bool.toggle()
            }, label: {
                Image(systemName: "play.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 50, weight: .semibold))
            })
        }
        .shadow(radius: 20)
    }
}
