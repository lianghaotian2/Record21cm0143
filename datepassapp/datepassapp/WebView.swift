//
//  WebView.swift
//  datepassapp
//
//  Created by cmStudent on 2023/02/16.
//

import SwiftUI
import WebKit //WebKitをインポート
 
struct WebView: UIViewRepresentable {
    var url: String = "https://www.nippon.com/ja/japan-topics/today0215/" //表示するWEBページのURLを指定
    
    func makeUIView(context: Context) -> WKWebView{
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.load(URLRequest(url: URL(string: url)!))
    }
}
 
struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView()
    }
}
