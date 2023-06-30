//
//  SignUpView.swift
//  Habit
//
//  Created by Lucas Constante on 11/04/23.
//

import SwiftUI

struct SignUpView: View {
  
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .center) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Cadastro")
                            .foregroundColor(Color("textColor"))
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        fullNameField
                        
                        emailField
                        
                        passwordField
                        
                        documentField
                        
                        phoneField
                        
                        birthdayField
                        
                        genderField
                        
                        saveButton
                        
                    }
                    
                    Spacer()
                }.padding(.horizontal, 8)
                
            }.padding()
            
            if case SignUpUIState.error(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("Ok")) {
                            // Faz algo quando some o alerta
                        })
                    }
            }
        }
    }
}

extension SignUpView {
    var fullNameField: some View {
        EditTextView(text: $viewModel.fullName,
                     placeholder: "Entre com seu nome completo *",
                     keyboard: .alphabet,
                     error: "Nome deve ter mais de 3 caracteres",
                     failure: viewModel.fullName.count < 3,
                     autocapitalization: .words)
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "Entre com seu e-mail *",
                     keyboard: .emailAddress,
                     error: "e-mail inválido",
                     failure: !viewModel.email.isEmail())
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView(text: $viewModel.password,
                     placeholder: "Entre com sua senha *",
                     keyboard: .emailAddress,
                     error: "senha deve ter ao menos 8 caracteres",
                     failure: viewModel.password.count < 8,
                     isSecure: true)
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(text: $viewModel.document,
                     placeholder: "Entre com seu CPF *",
                     mask: "###.###.###-##",
                     keyboard: .numberPad,
                     error: "CPF inválido",
                     failure: viewModel.document.count != 14)
        // TODO: mask
        // TODO: isDisabled
    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(text: $viewModel.phone,
                     placeholder: "Entre com seu celular *",
                     mask: "(##) ####-####",
                     keyboard: .numberPad,
                     error: "Entre com o DDD + 8 ou 9 dígitos",
                     failure: viewModel.phone.count < 14 || viewModel.phone.count > 15)
        // TODO: mask
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(text: $viewModel.birthday,
                     placeholder: "Entre com sua data de nascimento *",
                     mask: "##/##/####",
                     keyboard: .numberPad,
                     error: "Data deve ser dd/MM/yyyy",
                     failure: viewModel.birthday.count != 10)
        // TODO: mask
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue)
                    .tag(value)
            }
        }.pickerStyle(SegmentedPickerStyle())
            .padding(.top, 16)
            .padding(.bottom, 32)
    }
}

extension SignUpView {
    var saveButton: some View {
        LoadingButtonView(action: {
            viewModel.signUp()
        },
                          text: "Realize o seu cadastro",
                          showProgress: self.viewModel.uiState == SignUpUIState.loading, disabled: !viewModel.email.isEmail() ||
                          viewModel.password.count < 8 ||
                          viewModel.fullName.count < 3 ||
                          viewModel.document.count != 14 ||
                          viewModel.phone.count < 14 || viewModel.phone.count > 15 ||
                          viewModel.birthday.count != 10)
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
                .previewDevice("iPhone 14 Pro Max")
                .preferredColorScheme($0)
        }
        
    }
}

