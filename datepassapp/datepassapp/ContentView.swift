//
//  ContentView.swift
//  datepassapp
//
//  Created by cmStudent on 2022/11/29.
//

import SwiftUI
import UserNotifications

struct ContentView: View, InputViewDelegate {
    @State var isWebView:Bool = false
    
    @State var topTitleText: String = "記念日"
    @State var topTitleSmallText: String = "大事な日を入れる"
    @State var label: String = "0000-00-00"
    @State var startday: String = "0000-00-00"
    @State var days: [String] = ["hoge,10"]
    
    init(){
        //List全体の背景色の設定
        UITableView.appearance().backgroundColor = UIColor.clear
        dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(identifier:  "Asia/Tokyo")
        dateFormatter.dateFormat = "yyyy年M月d日"
    }
    
    var dateFormatter:DateFormatter
    
    
    var body: some View {
        
        NavigationView {
            let _ = print(topTitleText)
            ZStack(alignment: .bottomTrailing) {
                Color("sample").edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 0){
                    
                    MyProjectCard(topTitleText: $topTitleText, topTitleSmallText: $topTitleSmallText, label: $label, startday: $startday)
                        .frame(width: 380)
                        .padding(5)
                    
                    
                    List {
                        if #available(iOS 15.0, *) {
                            ForEach(days, id: \.self) { user in
                                let data = user.split(separator: ",")
                                
                                // data[1] StringのDate型だから
                                // String型をDate型に変えてメソッドを呼び出す
                                
                                
                                let date = dateFormatter.date(from: String(data[1]))
                                let sub = sub(startDate: date)
 
                                MyCard(title: String(data[0]), daypass: sub, bgColor: Color.white)
                                    .listRowBackground(Color.clear)
                                
                                
                                
                            }
                            .onDelete(perform: delete)
                            .onMove(perform: move)
                            .listRowSeparator(.hidden)
                            
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    .frame( maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .listStyle(GroupedListStyle())
                    
                    
                    NavigationLink(destination: InputView(delegate: self, text: "")) {
                        Text("追加")
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 20))
                    }
                    .frame(width: 60, height: 60)
                    .background(Color.orange)
                    .cornerRadius(30)
                    .padding()
                    
                    
                    
                    
                }
                .onAppear {
                    if let days = UserDefaults.standard.array(forKey: "DAYS") as? [String] {
                        self.days = days
                    }
                }
                .navigationTitle("DAYS")
                .navigationBarItems(trailing: EditButton())
            }
            
        }
        
    }
    
    // Date型の情報が欲しい
    func sub(startDate: Date?) -> String {
        guard let startDate = startDate else { return "0" }
        let timeInterval = Int(Date().timeIntervalSince(startDate))
        
        print(String(timeInterval / 60 /*分*/ / 60 /*時*/ / 24 /*日*/))
        return String(timeInterval / 60 /*分*/ / 60 /*時*/ / 24 /*日*/)
        //return "10"
    }
    
    func rowReplace(_ from: IndexSet, _ to: Int) {
        days.move(fromOffsets: from, toOffset: to)
    }
    
    
    
    func delete(at offsets: IndexSet) {
        days.remove(atOffsets: offsets)
        print(days)
        UserDefaults.standard.setValue(days, forKey: "DAYS")
    }
    
    func move(offsets: IndexSet, index: Int) {
        days.move(fromOffsets: offsets, toOffset: index)
    }
    
    
    
    func addDays(text: String) {
        days.append(text)
        UserDefaults.standard.setValue(days, forKey: "DAYS")
    }
}





protocol InputViewDelegate {
    func addDays(text: String)
}






struct InputView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State var label: String = ""
    @Environment(\.presentationMode) var presentation
    let delegate: InputViewDelegate
    @State var text: String
    
    
    
    //func sub() -> String {
      //  let timeInterval = Int(endDate.timeIntervalSince(startDate))
       // return String(timeInterval / 60 /*分*/ / 60 /*時*/ / 24 /*日*/)
   // }
    
    //通知関係
    //通知時間差指定計算
    func timeInterval() {
        let today = Date()
        let diff = startDate.timeIntervalSince(today)
        //過去の日は一年記念日の前日に通知
        if diff < -86400 {
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 31536000 + diff - 86400, repeats: false)
            let content = UNMutableNotificationContent()
            content.title = text
            content.body = "明日が1年記念日です"
            content.sound = UNNotificationSound.default
            
            let request = UNNotificationRequest(identifier: "Record", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

        }else if diff > 86400 {
            //1日以上先の日は前日に通知
            let l = diff - 86400
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: l, repeats: false)
            let content = UNMutableNotificationContent()
            content.title = text
            content.body = "あと1日です"
            content.sound = UNNotificationSound.default
            
            let request = UNNotificationRequest(identifier: "Record", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        }else{
            
        }
    }
    
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("なんの日ですか？", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            DatePicker("日付を選択", selection: $startDate, displayedComponents: .date)
            Button {
                // Date型をString型にする
                let start = DateFormatter()
                start.calendar = Calendar(identifier: .gregorian)
                start.locale = Locale(identifier: "ja_JP")
                start.timeZone = TimeZone(identifier:  "Asia/Tokyo")
                start.dateFormat = "yyyy年M月d日"
                let startDate = start.string(from: startDate)
                // "2020年4月25日(土) 16時8分56秒"
                delegate.addDays(text: text + "," + startDate)
                
                //delegate.addDays(text: label)
                
                presentation.wrappedValue.dismiss()
                
                //通知
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]){
                    (granted, error) in
                    if granted {
                        timeInterval()
                    }else {
                        
                    }
                }
                
            }
        label: {
            Text("追加")
                .frame(maxWidth: .infinity)
                .frame(maxHeight: 40)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(7)
                .padding(.horizontal, 7)
                .padding(.vertical, 20)
        }
            
            
            
            
            
        }
        .padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    
    //@State static var topTitleText: String = ""
    
    static var previews: some View {
        ContentView()
    }
}
