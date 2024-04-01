//
//  22_VisualEffect & GeometryReader.swift
//  SwiftUI-Intermediate
//
//  Created by Vuk Knezevic on 04.03.24.
//

import SwiftUI

// MARK: - iOS 17 - moze da se koristi umesto GeometryReader-a i to za UI element sa kog se poziva

struct VisualEffect___GeometryReader: View {
    
    @State private var showSpacer: Bool = false
    
    var body: some View {
        // MARK: - Primer 1
//        VStack {
//            Text("Hello world, hello world")
//                .padding()
//                .background(Color.red)
//                .visualEffect { content, geometryProxy in
//                    content
//    //                    .grayscale(geometryProxy.size.width >= 200 ? 1 : 0)
//                        .grayscale(geometryProxy.frame(in: .global).minY < 300 ? 1 : 0)
//            }
//            
//            if showSpacer {
//                Spacer()
//            }
//            
//        }
//        .animation(.easeIn, value: showSpacer)
//        .onTapGesture {
//            showSpacer.toggle()
//        }
        
        // MARK: - Primer 2
        ScrollView {
            VStack(spacing: 30, content: {
                ForEach(0..<100) { index in
                    Rectangle()
                        .frame(width: 300, height: 200)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .visualEffect { content, geometryProxy in
                            content
                                .offset(x: geometryProxy.frame(in: .global).minY * 0.05)
                        }
                }
            })
        }
    }
    
    
}

#Preview {
    VisualEffect___GeometryReader()
}
