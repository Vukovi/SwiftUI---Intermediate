//
//  23_PaginationScrollView.swift
//  SwiftUI-Intermediate
//
//  Created by Vuk Knezevic on 13.03.24.
//

import SwiftUI

struct PaginationScrollView: View {
    
    @State private var scrollToPosition: Int? = nil
    
    var body: some View {
        // MARK: - Vertikalni pager scroll
//        ScrollView {
//            VStack(spacing: 0, content: {
//                ForEach(0..<20) { index in
//                    Rectangle()
////                        .frame(width: 300, height: 300)
//                        .overlay {
//                            Text("\(index)")
//                                .foregroundStyle(.white)
//                        }
//                        .frame(maxWidth: .infinity)
////                        .padding(.vertical, 10)
//                    // MARK: - containerRelativeFrame
//                    // Centrira sadzaj jednog elementa po celom ekranu
//                        .containerRelativeFrame(.vertical, alignment: .center)
//                }
//            })
//        }
//        .ignoresSafeArea()
//        .scrollTargetLayout()
//        // MARK: - scrollTargetBehavior
//        // Ukoliko je opcija - viewAligned - onda se po otpustanju scroll gesture-a pozicionira na prvi vidljivi element
//        // Ukoliko je opcija - paging - onda se ne moze scrollovati po inerciji nego se na svaki scroll fiksira sledeci element
//        .scrollTargetBehavior(.paging)
//        // MARK: - scrollBounceBehavior
//        // Ukoliko je broj elementa manji od velicine ekrana nece se dodavati bounce ili feder efekat, ali ako je broj elementa veci od ekrana onda ce ovaj efekat biti dodat
//        .scrollBounceBehavior(.basedOnSize)
        
        // MARK: - Horizontalni pager scroll
//        ScrollView(.horizontal) {
//            HStack(spacing: 0, content: {
//                ForEach(0..<20) { index in
//                    Rectangle()
//                        .frame(width: 300, height: 300)
//                        .cornerRadius(10)
//                        .overlay {
//                            Text("\(index)")
//                                .foregroundStyle(.white)
//                        }
//                        .frame(maxWidth: .infinity)
//                        .padding(10)
//                    // MARK: - containerRelativeFrame
//                    // Centrira sadzaj jednog elementa po celom ekranu
//                        .containerRelativeFrame(.horizontal, alignment: .center)
//                }
//            })
//        }
//        .ignoresSafeArea()
//        .scrollTargetLayout()
//        // MARK: - scrollTargetBehavior
//        // Ukoliko je opcija - viewAligned - onda se po otpustanju scroll gesture-a pozicionira na prvi vidljivi element
//        // Ukoliko je opcija - paging - onda se ne moze scrollovati po inerciji nego se na svaki scroll fiksira sledeci element
//        .scrollTargetBehavior(.paging)
//        // MARK: - scrollBounceBehavior
//        // Ukoliko je broj elementa manji od velicine ekrana nece se dodavati bounce ili feder efekat, ali ako je broj elementa veci od ekrana onda ce ovaj efekat biti dodat
//        .scrollBounceBehavior(.basedOnSize)
    
        
        // MARK: - Scroll To
        VStack {
            
            Button("Scroll To") {
                scrollToPosition = (0..<20).randomElement()
            }
            
            ScrollView(.horizontal) {
                HStack(spacing: 0, content: {
                    ForEach(0..<20) { index in
                        Rectangle()
                            .frame(width: 300, height: 300)
                            .cornerRadius(10)
                            .overlay {
                                Text("\(index)")
                                    .foregroundStyle(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .id(index)
                            .containerRelativeFrame(.horizontal, alignment: .center)
                        // MARK: - .threshold(.visible(0.6)) pocni sa primenum visualEffecta kada je sledeca selija vidljiva 60%
                        // MARK: - Moze i bez .threshold(.visible(0.6))
                            .scrollTransition(.interactive.threshold(.visible(0.6))) { visualEffect, phase in
                                visualEffect
                                    .opacity(phase.isIdentity ? 1 : 0)
                                    .offset(y: phase.isIdentity ? 0 : -100)
                            }
                    }
                })
                .padding(.vertical, 100)
            }
            .ignoresSafeArea()
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollBounceBehavior(.basedOnSize)
            .scrollPosition(id: $scrollToPosition, anchor: .center)
            .animation(.smooth, value: scrollToPosition)
        }
    }
}

#Preview {
    PaginationScrollView()
}
