//
//  06_ScrollViewReader.swift
//  SwiftUI-Intermediate
//
//  Created by Vuk Knezevic on 11.11.23.
//

import SwiftUI

// MARK: - Preko ScrollViewReader-a moze da se postigne scroll-To

struct ScrollViewReaderBootcamp: View {
    
    @State private var scrollToindex: Int = 0
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            
            TextField("Placeholder...", text: $text)
                .frame(height: 55)
                .padding(.horizontal)
                .border(.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
                        
            Button("Scroll to position #49") {
                withAnimation(.spring()) {
                    // MARK: - Ovo ga scrolluje na 30-tu poziciju, a anchor definise da 30-ti element bude na sredini ScrollView-a
                    // proxy.scrollTo(30, anchor: .center)
                    
                    if let index = Int(text) {
                        scrollToindex = index
                    }
                }
            }
            
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<50) { value in
                        Text("Item \(value)")
                            .font(.title)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                        // MARK: - Mora da se doda ovaj id po kom ce scrollTo raditi
                            .id(value)
                    }
                    .onChange(of: scrollToindex) { oldValue, newValue in
                        withAnimation(.spring()) {
                            proxy.scrollTo(newValue, anchor: .center)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderBootcamp()
}
