//
//  20_CustomPublisher & Subscribers.swift
//  SwiftUI-Intermediate
//
//  Created by Vuk Knezevic on 14.11.23.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    @Published var count: Int = 0
    @Published var textFieldText: String = ""
    @Published var textFieldValid: Bool = false
    @Published var showButton: Bool = false
    
    var timer: AnyCancellable?
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setupTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func addButtonSubscriber() {
        $textFieldValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
        // MARK: - Debounce ceka da emituje dogadjaj za postavljeno vreme
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map {
                if $0.count > 3 {
                    return true
                }
                return false
            }
        // MARK: - Ovako postoji opasnost da self izazove retain cycle, assign bolje koristiti na strukturama
//            .assign(to: \.textFieldValid, on: self)
            .sink(receiveValue: { [weak self] isValid in
                self?.textFieldValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setupTimer() {
        // MARK: - 1. Varijanta sa jednim AnyCancellable-om
//        timer = Timer
//            .publish(
//                every: 1,
//                on: .main,
//                in: .common
//            )
//            .autoconnect()
//            .sink {[weak self] _ in
//                guard let self = self else { return }
//                
//                self.count += 1
//                
//                if self.count >= 10 {
//                    self.timer?.cancel()
//                }
//            }
        
        // MARK: - 2. Varijanta sa vise AnyCancellable-a
        Timer.publish(
            every: 1,
            on: .main,
            in: .common
        )
        .autoconnect()
        .sink { [weak self] _ in
            guard let self = self else { return }
            
            self.count += 1
            
            // MARK: - Ovako bi se iskljucili svi cancellables, analogno pojedinacnom iskljucenju u varijanti 1
//            if self.count >= 10 {
//                for item in cancellables {
//                    item.cancel()
//                }
//            }
        }
        .store(in: &cancellables)
    }
}

struct CustomPublisher___Subscribers: View {
    
    @StateObject private var viewModel: SubscriberViewModel = SubscriberViewModel()
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Number is: \(viewModel.count)")
                .font(.largeTitle)
            
            TextField("Type something here...", text: $viewModel.textFieldText)
                .frame(height: 55)
                .padding(.horizontal)
                .background(Color.gray)
                .cornerRadius(10)
                .padding(.horizontal)
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark")
                        .foregroundStyle(.red)
                        .padding(.trailing)
                        .padding(.trailing)
                        .opacity(viewModel.textFieldText.count < 1 ? 0 :
                                    viewModel.textFieldValid ? 0 : 1)
                    
                    Image(systemName: "checkmark")
                        .foregroundStyle(.green)
                        .padding(.trailing)
                        .padding(.trailing)
                        .opacity(viewModel.textFieldValid ? 1 : 0)
                }
            
            Text("Text is valid: \(viewModel.textFieldValid.description)")
            
            Button(action: {}, label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding()
                    .opacity(viewModel.showButton ? 1 : 0.5)
            })
            .disabled(viewModel.showButton)
            
        }
    }
}

#Preview {
    CustomPublisher___Subscribers()
}
