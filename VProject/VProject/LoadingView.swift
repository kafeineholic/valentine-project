//
//  LoadingView.swift
//  VProject
//
//  Created by Pattranith Ruangrotch on 12/2/2568 BE.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            //Background
            Image("wallpaper")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true) //hidden nav bar
            VStack {
                //heart effect
                Image("heart_loading")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever(), value: isAnimating)
                    .onAppear { isAnimating = true }
                    .saturation(0.8) // Reduce smoothness
                    .opacity(0.9)
                
                //loading Text
                Text("Please wait a moment.")
                    .font(.system(size: 24, weight: .bold, design: .monospaced))
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.942, green: 0.433, blue: 0.55)/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 20)
                
                ProgressView() //showing status of loading
                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
                    .scaleEffect(2)
                    .padding(.top, 10)
            }
        }
    }
}

#Preview {
    LoadingView()
}
