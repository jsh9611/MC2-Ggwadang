//
//  HomeView.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/19.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .bottom) {
                    MainView()
                    StatusView().padding(.bottom, 20)
                }
                MainListView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
