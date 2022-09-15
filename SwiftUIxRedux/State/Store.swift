//
//  Store.swift
//  SwiftUIxRedux
//
//  Created by Nic Wu on 2022/9/14.
//

import Foundation

/*
 1. 將 app 當作一個狀態機，狀態決定用戶界面
 2. 這些狀態都保存在一個 Store 對像中，被稱為 State
 */

class Store: ObservableObject {
    
    @Published var appState = AppState()
    
    /// 讓 View 呼叫發送某個 Action 的方法
    func dispatch(_ action: AppAction) {
        print("[ACTION]: \(action)")
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        
        if let command = result.1 {
            print("[COMMAND]: \(command)")
            command.execute(in: self)
        }
    }
    
    /// Reducer 唯一職責是計算新的 State
    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        
        var appState = state
        var appCommand: AppCommand?
        
        switch action {
        case .login(let email, let password):
            
            guard !appState.settings.loginRequesting else { break }
            
            appState.settings.loginRequesting = true
            
            appCommand = LoginAppCommand(email: email, password: password)
            
        case .accountBehaviorDone(let result):
            
            appState.settings.loginRequesting = false
            
            switch result {
            case .success(let user):
                appState.settings.loginUser = user
            case .failure(let error):
                appState.settings.loginError = error
            }
        }
        
        return (appState, appCommand)
    }
}
