//
//  HomeView.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/19.
//

import SwiftUI

struct HomeView: View {
    @Binding var isPresented: Bool
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .bottom) {
                    MainView(isPresented: $isPresented)
                    StatusView(isPresented: $isPresented).padding(.bottom, 20)
                }
                MainListView(isPresented: $isPresented)
            }
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
