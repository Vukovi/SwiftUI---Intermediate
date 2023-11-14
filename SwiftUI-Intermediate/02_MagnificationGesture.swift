//
//  02_MagnificationGesture.swift
//  SwiftUI-Intermediate
//
//  Created by Vuk Knezevic on 11.11.23.
//

import SwiftUI

// MARK: - Na simulatoru moras drzati option button malo duze od pokret rotiranja da ne bi element ostao u rotiranoj poziciji

struct MagnificationGestureBootcamp: View {
    
    @State var currenAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    @State var currenAmount2: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            
            Text("Hello, World!")
                .font(.title)
                .padding()
                .background(.red)
                .scaleEffect(1 + currenAmount + lastAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged{ value in
                            currenAmount = value - 1
                        }
                        .onEnded { value in
                            lastAmount += currenAmount
                            currenAmount = 0
                        }
                )
            
            Spacer()
            
            HStack {
                Circle()
                    .frame(width: 35, height: 35)
                Text("Vuk Knezevic")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currenAmount2)
                .gesture(
                    MagnificationGesture()
                        .onChanged{ value in
                            currenAmount2 = value - 1
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                currenAmount2 = 0
                            }
                        }
                )
            
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            
            Text("Ovo je opis fotografije")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    MagnificationGestureBootcamp()
}
