//
//  03_RotаtionGesture.swift
//  SwiftUI-Intermediate
//
//  Created by Vuk Knezevic on 11.11.23.
//

import SwiftUI

// MARK: - Na simulatoru moras drzati option button malo duze od pokret rotiranja da ne bi element ostao u rotiranoj poziciji

struct RotationGestureBootcamp: View {
    
    @State var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        Text("Hello, World!")
            .font(.title)
            .padding()
            .background(.red)
            .rotationEffect(angle)
            .gesture(
                RotateGesture()
                    .onChanged { value in
                        angle = value.rotation
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            angle = Angle(degrees: 0)
                        }
                        
                    }
            )
    }
}

#Preview {
    RotationGestureBootcamp()
}
