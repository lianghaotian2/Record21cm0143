//
//  AddTopView.swift
//  datepassapp
//
//  Created by cmStudent on 2023/02/15.
//

import SwiftUI

struct AddTopView: View {
    @State var startDate = Date()
    @State private var endDate = Date()
    @Binding var label: String
    @State var templabel: String = ""
    @Binding var topTitleText: String
    @State var tempTitleText: String = ""
    @Binding var topTitleSmallText: String
    @State var tempTitleSmallText: String = ""
    @Binding var startday: String
    
    
    @State var showTitle: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var df:DateFormatter{
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            df.locale = Locale(identifier: "ja_JP")
            return df
        }
    
    func sub2() -> String {
        let timeInterval = Int(endDate.timeIntervalSince(startDate))
        return String(timeInterval / 60 /*分*/ / 60 /*時*/ / 24 /*日*/)
    }
    
    var body: some View {
        NavigationView{
        VStack {
            TextField("なんの日ですか", text: $tempTitleText, onCommit:{ self.showTitle = true})
                .padding(8)
                .frame(width: 330, height: 40)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(10)
            
            TextField("なんの日ですか", text: $tempTitleSmallText, onCommit:{ self.showTitle = true})
                .padding(8)
                .frame(width: 330, height: 40)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(10)
            
            DatePicker("日付を選択", selection: $startDate, displayedComponents: .date)
            
            Button(action: {
                label = sub2()
                topTitleText = tempTitleText
                topTitleSmallText = tempTitleSmallText
                startday = "\(df.string(from: startDate))"
                
                
                dismiss()
                
            }) {
                Text("完了")
                    .padding()
                    .font(.system(size: 28))
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 60)
                    .background(.orange)
                    .cornerRadius(18)
            }
            
            
        }
        .navigationTitle("ピン留め")
        .navigationBarTitleDisplayMode(.inline)
    }
    }
}
struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddTopView(label: .constant("hoge"), topTitleText: .constant("hoge"), topTitleSmallText: .constant("hoge"), startday: .constant("0000-00-00"))
    }
}
