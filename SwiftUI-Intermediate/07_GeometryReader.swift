//
//  07_GeometryReader.swift
//  SwiftUI-Intermediate
//
//  Created by Vuk Knezevic on 11.11.23.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    var body: some View {
//        GeometryReader { geometry in
//            HStack(spacing: 0) {
//               Rectangle()
//                    .fill(.red)
//                    .frame(width: geometry.size.width * 0.667)
//                Rectangle()
//                     .fill(.blue)
//            }
//            .ignoresSafeArea()
//        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: 40 * getPercentage(geo: geometry)),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(width: 300, height: 200)
                    .padding()
                }
            }
        }
    }
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        // MARK: - .global je koordinatni sistem telefona
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX/maxDistance))
    }
}

#Preview {
    GeometryReaderBootcamp()
}
