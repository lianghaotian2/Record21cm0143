//
//  MyCard.swift
//  datepassapp
//
//  Created by cmStudent on 2023/02/03.
//

import SwiftUI

struct MyCard : View {
    
    
    var title : String
    var daypass : String
    var bgColor : Color
    
    var body: some View{
        
        HStack(spacing: 0){
            let daypassNum = Int(daypass) ?? 0
            if daypassNum > 0 {
                Divider().opacity(0)
                //                Rectangle().frame(height: 0)
                Text(title + " もう")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                if #available(iOS 15.0, *) {
                    VStack {
                        
                        Text(daypass)
                            .foregroundColor(Color.white)
                            .padding(10)
                            .font(.system(size:20))
                            .frame(width: 65, height: 40)
                            .background(.cyan)
                    }
                    
                }else {
                    // Fallback on earlier versions
                }
            }else if daypassNum < 0 {
                let textDaypass = String(-daypassNum)
                Divider().opacity(0)
                //                Rectangle().frame(height: 0)
                Text(title + " あと")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                if #available(iOS 15.0, *) {
                    VStack {
                        
                        Text(textDaypass)
                            .foregroundColor(Color.white)
                            .padding(10)
                            .font(.system(size:20))
                            .frame(width: 65, height: 40)
                            .background(.yellow)
                    }
                    
                }else {
                    // Fallback on earlier versions
                }
            } else {
                // 当日
                let textDaypass = "今日"
                Divider().opacity(0)
                //                Rectangle().frame(height: 0)
                Text(title + " は　")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                if #available(iOS 15.0, *) {
                    VStack {
                        
                        Text(textDaypass + "です")
                            .foregroundColor(Color.white)
                            .padding(10)
                            .font(.system(size:20))
                            .frame(width: 120, height: 40)
                            .background(.yellow)
                    }
                    
                }else {
                    // Fallback on earlier versions
                }
            }
            
            
            
            
            
            if #available(iOS 15.0, *) {
                VStack {
                    let daypassNum = Int(daypass) ?? 0
                    if daypassNum > 0 {
                        Text("日")
                            .fontWeight(.bold)
                            .font(.system(size:23))
                            .foregroundColor(.white)
                        //.padding()
                            .frame(width: 35, height: 40)
                            .cornerRadius(10)
                            .background(.blue)
                    }else if daypassNum < 0 {
                        Text("日")
                            .fontWeight(.bold)
                            .font(.system(size:23))
                            .foregroundColor(.white)
                        //.padding()
                            .frame(width: 35, height: 40)
                            .cornerRadius(10)
                            .background(.orange)
                    }
                    
                }
                
                .cornerRadius(10, maskedCorners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
            } else {
                // Fallback on earlier versions
            }
            
        }
        .frame(height: 40, alignment: .center)
        .frame(maxWidth: .infinity)
        .background(bgColor)
        .cornerRadius(10)
        
    }
    
    
}

struct MyCard_Previews: PreviewProvider {
    static var previews: some View {
        MyCard(title: "ABC", daypass: "300" , bgColor: Color.green)
    }
}

struct PartlyRoundedCornerView: UIViewRepresentable {
    let cornerRadius: CGFloat
    let maskedCorners: CACornerMask
    
    func makeUIView(context: UIViewRepresentableContext<PartlyRoundedCornerView>) -> UIView {
        let uiView = UIView()
        uiView.layer.cornerRadius = cornerRadius
        uiView.layer.maskedCorners = maskedCorners
        uiView.backgroundColor = .white
        return uiView
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PartlyRoundedCornerView>) {
    }
}
struct PartlyRoundedCornerModifier: ViewModifier {
    let cornerRadius: CGFloat
    let maskedCorners: CACornerMask
    
    func body(content: Content) -> some View {
        content.mask(PartlyRoundedCornerView(cornerRadius: self.cornerRadius, maskedCorners: self.maskedCorners))
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, maskedCorners: CACornerMask) -> some View {
        self.modifier(PartlyRoundedCornerModifier(cornerRadius: radius, maskedCorners: maskedCorners))
    }
}
