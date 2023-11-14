//
//  09_Mask.swift
//  SwiftUI-Intermediate
//
//  Created by Vuk Knezevic on 13.11.23.
//

import SwiftUI

// MARK: - Dva view-a, jedan donji drugi gornji, Mask ce uciniti da se gornji view prilagodi obliku donjeg view-a

struct Mask: View {
    
    @State var rating: Int = 0
    
    var body: some View {
        ZStack {
            starsView
                .overlay {
                    overlayView
                        .mask(starsView)
                }
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundStyle(.yellow)
                    .frame(width: Double(rating) / 5 * geometry.size.width)
            }
        }
        // MARK: - Propusta klik, inace bi overlayView blokirao klikove koju su manji od trenutnog rating-a
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { value in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundStyle(rating >= value ? Color.yellow : Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = value
                        }
                    }
            }
            
        }
    }
}

#Preview {
    Mask()
}
