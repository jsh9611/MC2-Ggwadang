//
//  LicenseView.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/28.
//

import SwiftUI

struct LicenseView: View {
    var openSources = [["Realm", "Apache-2.0 license"], ["RealmSwift", "Apache-2.0 license"]]
        var body: some View {
            ScrollView() {
                VStack {
                    ForEach(openSources, id: \.self) { openSource in
                        VStack(alignment: .leading) {
                            Text(openSource[0]).bold()
                            Text(openSource[1]).foregroundColor(.gray)
                        }
                        .padding()
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                VStack {
                    Text("Apache-2.0 license").bold()
                    Text(readTxtFile("apache-license.txt"))
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                }
                .padding()
            }
        }
}

extension LicenseView {
    func readTxtFile(_ name: String) -> String {
        var result = ""
        
        let paths = Bundle.main.path(forResource: "\(name)", ofType: nil)
        guard paths != nil else { return "" }
        
        do {
            result = try String(contentsOfFile: paths!, encoding: .utf8)
        }
        catch let error as NSError {
            print("catch :: ", error.localizedDescription)
            return ""
        }
        
        return result
    }
}

struct LicenseView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseView()
    }
}
