//
//  viewModel.swift
//  ggwadang
//
//  Created by Hyung Seo Han on 2022/06/14.
//

import SwiftUI

class viewModel: ObservableObject{
    @Published var selection: Int
    @Published var dataPoints: [Double]
    @Published var values: [Int]
    
    init() {
        self.selection = 0
        self.dataPoints = [35.7868, 100.7, 150.7, 20.7, 50.7, 10, 100]
        self.values = [100,100,0,0,0,0,0,0,0]
    }
    
    func getTotalSugar(section: Int){
        //만약에 동일한 탭을 누른다면?
        if(self.selection == section){
            print("Yabal")
            return
        }
        switch section{
        case 0:
            self.values = [100,100,0,0,0,0,0,0,0]
        case 1:
            self.values = [0,0,100,100,100,100,100,100,100]
            print("shibal")
        case 2:
            print("twobal")
        default:
            print("wow")
        }
    }
    
    
    
}
