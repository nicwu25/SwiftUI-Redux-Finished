//
//  SettingRootView.swift
//  SwiftUIxRedux
//
//  Created by Nic Wu on 2022/9/14.
//

import SwiftUI

struct SettingRootView: View {
    var body: some View {
        NavigationView {
            SettingView()
                .environmentObject(Store())
                .navigationBarTitle("设置")
        }
    }
}

struct SettingRootView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRootView()
    }
}
