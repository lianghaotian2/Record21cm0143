//
//  MyProjectCard.swift
//  datepassapp
//
//  Created by cmStudent on 2023/02/03.
//

import SwiftUI

struct MyProjectCard : View {
    @State var showSearch: Bool = false
    
    @Binding var topTitleText: String
    @Binding var topTitleSmallText: String
    @Binding var label: String
    @Binding var startday: String
    
    @State private var profileImage: Image = Image("Profile")
    @State private var profileImage2: Image = Image("Profile")
    @State private var showImagePickerYou: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var inputImage: UIImage?
    @State private var inputImageYou: UIImage?
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0){
            let _ = print(topTitleText)
            Rectangle().frame(height: 0)
            HStack{
                
            VStack{
                
            Text(topTitleText)
                .font(.system(size: 23))
                .fontWeight(.black)
            Text(startday)
                .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack{
                    HStack{
                    
                    profileImage
                        .profileImageStyle()
                        .onTapGesture {
                            showImagePicker = true
                        }
                        .onChange(of: inputImage) {_ in loadImage()}
                        .sheet(isPresented: $showImagePicker){
                            ImagePicker(image: $inputImage)
                        }
                        
                        profileImage2
                            .profileImageStyle()
                            .onTapGesture {
                                showImagePickerYou = true
                            }
                            .onChange(of: inputImageYou) {_ in loadImageYou()}
                            .sheet(isPresented: $showImagePickerYou){
                                ImagePicker(image: $inputImageYou)
                            }
                    
                }
                }
                
            }
            
            Spacer().frame(height: 20)
            HStack{
                let daypassNum = Int(label) ?? 0
                if daypassNum > 0 {
                Text(topTitleSmallText + " もう " + label + "日")
                    .font(.system(size: 20))
                }else if daypassNum < 0 {
                    let textDaypass = String(-daypassNum)
                    Text(topTitleSmallText + " あと " + textDaypass + "日")
                        .font(.system(size: 20))
                }
                
                Spacer()
                NavigationLink(destination: AddTopView(label: $label,  topTitleText: $topTitleText, topTitleSmallText: $topTitleSmallText, startday: $startday)) {
                    Text("編集")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 80)
                    .background(Color.blue)
                    .cornerRadius(20)
                }
            }
        }
        .padding(20)
        .background(Color.yellow)
        .cornerRadius(20)
        
        
    }
    
    func loadImage(){
        guard let inputImage = inputImage else {return}
        profileImage = Image(uiImage: inputImage)
    }
    
    func loadImageYou(){
        guard let inputImage2 = inputImageYou else {return}
        profileImage2 = Image(uiImage: inputImage2)
    }
    
}

struct MyProjectCard_Previews: PreviewProvider {
    static var previews: some View {
//        MyProjectCard(topTitleText: .constant("hoge"), bigtitle: "記念日",  topitle: "付き合ってもう" ,daypass: "300")
        MyProjectCard(showSearch: true, topTitleText: .constant(""), topTitleSmallText: .constant(""), label: .constant(""), startday: .constant(""))
    }
}
