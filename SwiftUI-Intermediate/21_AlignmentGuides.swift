//
//  21_AlignmentGuides.swift
//  SwiftUI-Intermediate
//
//  Created by Vuk Knežević on 27.11.23..
//

import SwiftUI

// MARK: - https://www.swiftui-lab.com/alignment-guides/
// MARK: - Pomocu alignment guides uticemo na parent view, za razliku npr od .offset(x: ??) gde uticemo na pomeranje child view-a

struct AlignmentGuides: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, World!")
                .background(Color.blue)
                .alignmentGuide(.leading, computeValue: { dimension in
                    // MARK: - Ova promena se ne bi primetila, da je u inicijalizatoru VStack-a alignment bio postavljen na .center, promena je vidljiva je jer su alignment inicijalizatora i alignment guide-a oba postavljeni na .leading
                    
                    // MARK: - Pomerili smo VStack leading za 20!!!!
//                    return 20
                    
                    // MARK: - Ovaj alignment guide verovatno koristi geometry reader tako da u argumentu DIMENSION postoji informacija kolike su dimenzije Text-a i za VStack leading ce se pomoeriti za sirinu Texta
                    return dimension.width
                })
            
            Text("Some othe rText")
                .background(Color.red)
        }
        .background(Color.orange)
    }
}

struct AlignmentChildView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            row(title: "Row 1", showIcon: false)
            row(title: "Row 2", showIcon: true)
            row(title: "Row 3", showIcon: false)
        })
        .padding(16)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding(40)
    }
    
    private func row(title: String, showIcon: Bool) -> some View {
        HStack(spacing: 10, content: {
            
            if showIcon {
                Image(systemName: "info.circle")
                    .frame(width: 30, height: 30)
            }
            
            Text(title)
            
            Spacer()
        })
//        .background(.red)
        .alignmentGuide(.leading, computeValue: { dimension in
            return showIcon ? 40 : 0
        })
    }
}

#Preview {
    AlignmentChildView()
}
