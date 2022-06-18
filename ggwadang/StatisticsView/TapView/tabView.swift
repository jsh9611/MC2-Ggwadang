//
//  ContentView.swift
//  StatisticsView
//
//  Created by Hyung Seo Han on 2022/06/16.
//

import SwiftUI

struct tabView: View {
    @State private var selected = 0
    var body: some View {
        VStack{
            TabView(selection: $selected){
                testView()
                    .tabItem {
                        Image(systemName:(selected == 0 ? "house.fill" : "house"))
                    }.tag(0)
                Text("shibal")
                    .tabItem {
                        Image(systemName: "plus")
                            .foregroundColor(Color("CustomColor"))
                            .background(Color("CustomColor"))
                    }.tag(1)
                SegView()
                    .tabItem {
                        Image(systemName: (selected == 2 ? "chart.bar.fill" : "chart.bar"))
                    }.tag(2)
                }
        }
    }
}
//.onChange

struct tabView_Previews: PreviewProvider {
    static var previews: some View {
        tabView()
    }
}

