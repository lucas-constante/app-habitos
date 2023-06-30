//
//  SplashViewModel.swift
//  Habit
//
//  Created by Lucas Constante on 04/04/23.
//

import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
    
    @Published var uiState: SplashUIState = .loading
    
    private var cancellableAuth: AnyCancellable?
    private var cancellableRefresh: AnyCancellable?
    
    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor) {
      self.interactor = interactor
    }
    
    deinit {
      cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
    }
    
    func onAppear() {
        cancellableAuth = interactor.fetchAuth()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                // Se userAuth == nulo -> Login
                if userAuth == nil {
                    self.uiState = .goToSignInScreen
                }
                // Senão se userAuth != null && expirou
                else if (Date().timeIntervalSince1970 > Double(userAuth!.expires)) {
                  // Chamar o refresh token na API
                    print("token expirou")
                    let request = RefreshRequest(token: userAuth!.refreshToken)
                    self.cancellableRefresh = self.interactor.refreshToken(refreshRequest: request)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch(completion) {
                            case .failure(_):
                                self.uiState = .goToSignInScreen
                                break
                            default:
                                break
                            }
                        }, receiveValue: { success in
                            
                            let auth = UserAuth(idToken: success.accessToken,
                                                         refreshToken: success.refreshToken,
                                                         expires: Date().timeIntervalSince1970 + Double(success.expires),
                                                         tokenType: success.tokenType)
                                                
                            self.interactor.insertAuth(userAuth: auth)
                            
                            self.uiState = .goToHomeScreen
                            
                        })
                }
                // Senão -> tela principal
                else {
                    self.uiState = .goToHomeScreen
                }
            }
    }
    
}

extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
    func homeView() -> some View {
        return SplashViewRouter.makeHomeView()
    }
}
