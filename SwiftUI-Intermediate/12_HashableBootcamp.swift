//
//  HashableBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Vuk Knezevic on 13.11.23.
//

import SwiftUI

struct MyHashableModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct MyIdentifibleModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
}

struct HashableBootcamp: View {
    
    let dataHashable: [MyHashableModel] = [
        MyHashableModel(title: "ONE"),
        MyHashableModel(title: "TWO"),
        MyHashableModel(title: "THREE"),
        MyHashableModel(title: "FOUR"),
        MyHashableModel(title: "FIVE"),
    ]
    
    let dataIdentifiable: [MyIdentifibleModel] = [
        MyIdentifibleModel(title: "ONE"),
        MyIdentifibleModel(title: "TWO"),
        MyIdentifibleModel(title: "THREE"),
        MyIdentifibleModel(title: "FOUR"),
        MyIdentifibleModel(title: "FIVE"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                // MARK: - Ide sa [id: \.self]
                ForEach(dataHashable, id: \.self) { item in
                    Text(item.hashValue.description)
                        .font(.headline)
                }
                
                // MARK: - Ide bez [id: \.self]
                ForEach(dataIdentifiable) { item in
                    Text(item.title)
                        .font(.headline)
                }
            }
        }
    }
}

struct HashableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HashableBootcamp()
    }
}
