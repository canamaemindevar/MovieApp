//
//  PremiumView.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 7.11.2023.
//

import SwiftUI

struct PremiumView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var girisAnim = false
    @State var oppValue = 0.0

    var body: some View {
        ZStack(alignment:.center){
            Image("cinema")
                .resizable()
                .ignoresSafeArea()

            LinearGradient (gradient: Gradient(colors:
                                                [.white.opacity(0.3),.black.opacity(0.4)]), startPoint: .top,
                            endPoint: .bottom)
            .ignoresSafeArea()

            HStack(alignment:.top){
                Text("")
                    .frame(width:7, height: 160)
                    .background(.gray)
                    .cornerRadius(20)
                Spacer().frame (width:25)
                VStack(alignment:.leading){
                    Text (K.hello.rawValue)
                        .foregroundColor(.white)
                        .bold()
                    Spacer().frame(height:10)
                    Text (K.premium.rawValue)
                        .font (.title2)
                        .bold()
                        .foregroundColor(Color(red: 180/255, green: 140/255, blue:
                                                125/255))

                    Text("Features").foregroundColor(.white.opacity(0.7))
                    Spacer().frame(height:40)
                    Button(K.activeIt.rawValue, action: {
                        LocalState.hasOnboarded = true
                        presentationMode.wrappedValue.dismiss()
                    })
                    .buttonStyle(GirisButton())

                }

                .opacity(oppValue)
                .animation(.easeIn(duration: 1).delay(0.1), value: oppValue)
                .onAppear (){
                    oppValue = 1.0
                }

            }

        }
    }
}


struct PremiumView_Previews: PreviewProvider {
    static var previews: some View {
        PremiumView()
    }
}


struct GirisButton: ButtonStyle{
    var colorButton1 = Color(red: 90/255, green: 70/255, blue: 60/255, opacity: 1)
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width:180, height: 40)

            .background(colorButton1)
            .cornerRadius(8)
            .foregroundColor(.white)
            .transformEffect(configuration.isPressed ? CGAffineTransform(rotationAngle: 0.2): CGAffineTransform(rotationAngle: 0))
            .animation(.easeInOut(duration: 0.9), value: configuration.isPressed)
    }

}
