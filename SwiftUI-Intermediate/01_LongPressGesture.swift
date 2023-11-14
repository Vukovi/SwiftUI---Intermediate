//
//  01_LongPressGesture.swift
//  SwiftUI-Intermediate
//
//  Created by Vuk Knezevic on 11.11.23.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    
    @State private var isLongGestureComplete: Bool = false
    @State private var isComplete: Bool = false
    @State private var isSuccess: Bool = false
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text(isLongGestureComplete ? "COMPLETE" : "NOT COMPLETE")
                .padding()
                .background(isLongGestureComplete ? Color.green : Color.gray)
                .cornerRadius(10)
            // MARK: - maximum distance je mogucnost da se kaze koliko pixela od tacke gestura je gesture dozvoljen ako se prst pomera, tako da u ovom slucaj kad ostvarimo long tap, i prst i dalje drzimo, ali nam on sklizne sa button-a, ima se prostora od 50 px za to sklizavanje
                .onLongPressGesture(minimumDuration: 5, maximumDistance: 50) {
                    isLongGestureComplete.toggle()
            }
            
            Spacer()
            
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 10)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack {
                Text("CLICK AND HOLD")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onLongPressGesture(
                        minimumDuration: 2,
                        maximumDistance: 50) {
                            // MARK: - Ovo se okida kad se long tap zavrsi
                            withAnimation(.easeInOut) {
                                isSuccess = true
                            }
                        } onPressingChanged: { isPressing in
                            // MARK: - Ovo pocinje sa tapom i traje do kraja minimumDuration
                            if isPressing {
                                // duration isti kao minimumDuration
                                withAnimation(.easeInOut(duration: 2)) {
                                    isComplete = true
                                }
                            } else {
                                // Dodajem malo zadrzavanje da bi se ovaj deo koda odigrao sigurno posle izvrsenja koda u bloku iznad, tj u onComplete bloku
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    if !isSuccess {
                                        withAnimation(.easeInOut) {
                                            isComplete = false
                                        }
                                    }
                                }
                            }
                        }

                
                Text("RESET")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }
            }
            
            Spacer()
        }
    }
}

#Preview {
    LongPressGestureBootcamp()
}
