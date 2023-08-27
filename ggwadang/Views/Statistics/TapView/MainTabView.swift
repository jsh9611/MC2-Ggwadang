//
//  ContentView.swift
//  StatisticsView
//
//  Created by Hyung Seo Han on 2022/06/16.
//

import SwiftUI

struct MainTabView: View {
    @State private var selected = 0
    @State private var oldSelected = 0
    @EnvironmentObject var store: RecordStore
    @State var isPresented = false
    
    //store.records에서 가져옴
    let records: [Record]
    
    var body: some View {
        VStack{
            TabView(selection: $selected){
                HomeView(isPresented: $isPresented)
                    .tabItem {
                        Image(systemName:(selected == 0 ? "house.fill" : "house"))
                    }
                    .tag(0)
                    .onAppear{
                        self.oldSelected = self.selected
                    }
                
                Text("")
                    .tabItem {
                        Image(systemName: "plus")
                            .foregroundColor(Color("CustomColor"))
                            .background(Color("CustomColor"))
                    }
                    .onAppear{
                        isPresented.toggle()
                        self.selected = self.oldSelected
                    }
                    .tag(1)
                
                SegView(records: self.records)
                    .tabItem {
                        Image(systemName: (selected == 2 ? "chart.bar.fill" : "chart.bar"))
                    }
                    .tag(2)
                    
                }
                .fullScreenCover(isPresented: $isPresented, content: {LargeCategoryView(isPresented: self.$isPresented).environmentObject(self.store)})
        }
    }
}
//.onChange

/*
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
*/

