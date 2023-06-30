//
//  HabitDetailView.swift
//  Habit
//
//  Created by Lucas Constante on 15/05/23.
//

import SwiftUI

struct HabitDetailView: View {
    
    @ObservedObject var viewModel: HabitDetailViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(viewModel: HabitDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .center, spacing: 12) {
                Text(viewModel.name)
                    .foregroundColor(Color.green)
                    .font(.title.bold())
                
                Text("Unidade: \(viewModel.label)")
            }
            
            VStack {
                TextField("Escreva aqui o valor conquistado", text: $viewModel.value)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }.padding(.horizontal, 32)
            
            Text("Os registros devem ser feitos em até 24h. \nHábitos se constroem todos os dias :)")
            
            LoadingButtonView(
            action: {
                viewModel.save()
            },
            text: "Salvar",
            showProgress: self.viewModel.uiState == .loading,
            disabled: self.viewModel.value.isEmpty)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Button("Cancelar") {
             // dismiss / pop exit
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation(.easeOut(duration: 0.15)) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                
            }
            .modifier(ButtonStyle())
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.top, 32)
        // .onAppear {
        //   viewModel.$uiState.sink { uiState in
        //     if uiState == .success {
        //       self.presentationMode.wrappedValue.dismiss()
        //     }
        //   }.store(in: &viewModel.cancellables)
        // }
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HabitDetailView(viewModel: HabitDetailViewModel(id: 1, name: "Tocar guitarra", label: "Horas", interactor: HabitDetailInteractor()))
                .previewDevice("iPhone 14 Pro Max")
                .preferredColorScheme($0)
        }
    }
}
