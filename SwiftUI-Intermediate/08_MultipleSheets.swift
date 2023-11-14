//
//  08_MultipleSheets.swift
//  SwiftUI-Intermediate
//
//  Created by Vuk Knezevic on 11.11.23.
//

import SwiftUI

// MARK: - Content .sheet-a se kreira odmah po dodavanju i taj sadrzaj ce biti prikazan kad se klikne na dugme, tj odmah po kliktanju na dugme, a sadrzaj koji blok dugmeta treba da menja ce biti izvrsen posle dizanja sheet-a, dakle na oko bez implementiranog sadrzaja jer taj kasni za prvobitno setovanim contentom sheet-a

// MARK: - Multiple sheets se resava na tri nacina: 
// MARK: 1) pomocu binding-a, ali to moze da izazove neke probleme na drugim mestima gde se koristi isti model
// MARK: 2) koriscenjem vise .sheet-ova, ali ovo kad se radi to mora da se uradi tako da pozvani .sheet-ovi budu na elementima u istoj hijerarhiji, ne moze da jedan sheet bude pozvan na parentu a drugi na childu, jer ce pozvani sheet biti parentov, takodje jedan element dozvoljava koriscenje samo jednog .sheet-a, tako da se iskljucuje mogucnost da npr parent ima dva sheeta. Dodanta stvar je neprakticnost jer ce previse isPresented varijabli biti korisceno, tj onliko ce ih biti koliko razlicitih sheet-ova hocemo da prezentujemo
// MARK: 3) inicijalizatora sa item-om

struct MultiSheetModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
}

struct MultipleSheets: View {
    
    // MARK: - 3) inicijalizator sa item-om, mora se ovo postaviti da bude nil, da ne bi u samom startu izbacivao sheet
    @State var selectedModel: MultiSheetModel? // = MultiSheetModel(title: "STARTING TITLE")
    // MARK: - 3) inicijalizator sa item-om, ne treba nam vise isPresented
//    @State var isPresented: Bool = false
//    @State var isPresented2: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                selectedModel = MultiSheetModel(title: "ONE")
                // MARK: - 3) inicijalizator sa item-om, ne treba nam vise isPresented
//                isPresented.toggle()
            }
            // MARK: - 2) koriscenjem vise .sheet-ova
//            .sheet(isPresented: $isPresented, content: {
//                NextScreen(selectedModel: MultiSheetModel(title: "ONE"))
//            })
            
            Button("Button 2") {
                selectedModel = MultiSheetModel(title: "TWO")
                // MARK: - 3) inicijalizator sa item-om, ne treba nam vise isPresented
//                isPresented2.toggle()
            }
            // MARK: - 2) koriscenjem vise .sheet-ova
//            .sheet(isPresented: $isPresented2, content: {
//                NextScreen(selectedModel: MultiSheetModel(title: "TWO"))
//            })
        }
//        .sheet(isPresented: $isPresented, content: {
//            NextScreen(selectedModel: selectedModel)
//        })
        .sheet(item: $selectedModel) { model in
            NextScreen(selectedModel: model)
        }
    }
}

struct NextScreen: View {
    
    // MARK: - 1) Pomocu binding-a
//    @Binding var selectedModel: MultiSheetModel
    let selectedModel: MultiSheetModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultipleSheets()
}
