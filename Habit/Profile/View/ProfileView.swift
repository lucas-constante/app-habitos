//
//  ProfileView.swift
//  Habit
//
//  Created by Lucas Constante on 23/05/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var disableDone: Bool {
        viewModel.fullNameValidation.failure
        || viewModel.phoneValidation.failure
        || viewModel.birthdayValidation.failure
    }
    
    var body: some View {
        ZStack {
            if case ProfileUIState.loading = viewModel.uiState {
                ProgressView()
            } else {
                NavigationView {
                    
                    VStack {
                        
                        Form {
                            
                            Section(header: Text("Dados cadastrais")) {
                                HStack {
                                    Text("Nome")
                                    Spacer()
                                    TextField("Digite o nome", text: $viewModel.fullNameValidation.value)
                                        .keyboardType(.alphabet)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.fullNameValidation.failure {
                                    Text("Nome deve ter mais de 4 caracteres")
                                        .foregroundColor(.red)
                                }
                                
                                HStack {
                                    Text("E-mail")
                                    Spacer()
                                    TextField("", text: $viewModel.email)
                                        .disabled(true)
                                        .foregroundColor(Color.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack {
                                    Text("CPF")
                                    Spacer()
                                    TextField("", text: $viewModel.document)
                                        .disabled(true)
                                        .foregroundColor(Color.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack {
                                    Text("Celular")
                                    Spacer()
                                    
                                    ProfileEditTextView(text: $viewModel.phoneValidation.value,
                                                        placeholder: "Digite o seu celular *",
                                                        mask: "(##) ####-####",
                                                        keyboard: .numberPad)
                                }
                                
                                if viewModel.phoneValidation.failure {
                                    Text("Entre com o DDD + 8 ou 9 dígitos")
                                        .foregroundColor(.red)
                                }
                                
                                HStack {
                                    Text("Data de nascimento")
                                    Spacer()
                                    
                                    ProfileEditTextView(text: $viewModel.birthdayValidation.value,
                                                        placeholder: "Digite a sua data de nascimento *",
                                                        mask: "##/##/####",
                                                        keyboard: .numberPad)
                                }
                                
                                if viewModel.birthdayValidation.failure {
                                    Text("Data deve ser dd/MM/yyyy")
                                        .foregroundColor(.red)
                                }
                                
                                NavigationLink(
                                    destination: GenderSelectorView(selectedGender: $viewModel.gender,
                                                                    genders: Gender.allCases,
                                                                    title: "Escolha o gênero"),
                                    label: {
                                        Text("Gênero")
                                        Spacer()
                                        Text(viewModel.gender?.rawValue ?? "")
                                    })
                                
                            }
                            
                        }
                        
                    }
                    
                    .navigationBarTitle(Text("Editar Perfil"), displayMode: .automatic)
                    .navigationBarItems(trailing: Button(action: {
                        viewModel.updateUser()
                    }, label: {
                        if case ProfileUIState.updateLoading = viewModel.uiState {
                            ProgressView()
                        } else {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        }
                    })
                        .alert(isPresented: .constant(viewModel.uiState == .updateSuccess)) {
                            Alert(title: Text("Habit"),
                                  message: Text("Dados atualizados com sucesso"),
                                  dismissButton: .default(Text("Ok")) {
                                viewModel.uiState = .none
                            })
                        }
                        .opacity(disableDone ? 0 : 1)
                    )
                }
            }
            
            if case ProfileUIState.updateError(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"),
                              message: Text(value),
                              dismissButton: .default(Text("Ok")) {
                            viewModel.uiState = .none
                        })
                    }
            }
            
            if case ProfileUIState.fetchError(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"),
                              message: Text(value),
                              dismissButton: .default(Text("Ok")) {
                        })
                    }
            }
            
        }.onAppear(perform: viewModel.fetchUser)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(interactor: ProfileInteractor()))
    }
}

