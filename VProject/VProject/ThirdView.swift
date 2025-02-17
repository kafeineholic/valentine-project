//
//  ThirdView.swift
//  VProject
//
//  Created by Pattranith Ruangrotch on 13/2/2568 BE.
//

import SwiftUI
import AVKit

struct ThirdView: View {
    
    @State private var isVideoPresented = false
    // To track which messages are shown
    @State private var messageIndexes: [Int] = []
    //insert your messages here (in the index)
    let messages = [
        "Please insert your text 1 here...",
        "Please insert your text 2 here...",
        "Please insert your text 3 here...",
        "Please insert your text 4 here...",
        "Please insert your text 5 here...",
        "Please insert your text 6 here...",
        "Please insert your text 7 here...",
        "Press VIDEO button to see more "
    ]
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color for iMessage-like screen
                Color(white: 0.95) // Light gray background
                    .ignoresSafeArea()
                
                VStack {
                    // Top border to mimic iMessage
                    Rectangle()
                        .frame(height: 1) // Height of the border
                        .foregroundColor(Color.gray.opacity(0.3)) // Light gray border
                        .padding(.top, 30) // Adjust padding as needed
                    
                    ScrollView {
                        //message bubbles
                        VStack(spacing: 10) {
                            ForEach(Array(messages.enumerated()), id: \.offset) { index, message in
                                if messageIndexes.contains(index) {
                                    HStack {
                                        Spacer()
                                        Text(message)
                                            .padding()
                                            .background(message.count <= 50 ?
                                                        AnyView(Capsule().foregroundColor(.blue)) :
                                                            AnyView(Color.blue.cornerRadius(15)))
                                            .foregroundColor(.white)
                                            .font(.system(size: 18, weight: .medium))
                                            .transition(.scale.combined(with: .opacity))
                                    }
                                }
                            }
                        }
                        .padding(.top, 20)
                        .padding(.horizontal, 20)
                    }
                    
                    
                    // "Cannot reply" section
                    HStack {
                        Text("This messages can not reply")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                        Image(systemName: "lock.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color(white: 0.95))
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.3)),
                        alignment: .top
                    )
                }
                .toolbar {
                    ToolbarItem(placement: .principal) { // Place at the center of Navigation Bar
                        VStack(alignment: .center, spacing: 4) { // Adjust spacing as needed
                            Image("profile_icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .frame(width: 60, height: 60)
                            //insert your conatact name here
                            Text("contact name")
                                .font(.system(size: 16, weight: .medium))
                                .padding(.top,1) // Add padding to separate text from image
                        }
                    }
                    
                    // Video button when click the vdo is open
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isVideoPresented.toggle()
                        }) {
                            Image(systemName: "video")
                                .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $isVideoPresented) {
                            //import ur vdo to VProject folder
                            if let videoURL = Bundle.main.url(forResource: "vdo", withExtension: "MOV") {
                                VideoPlayer(player: AVPlayer(url: videoURL))
                                    .edgesIgnoringSafeArea(.all)
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline) // Ensure the title is inline
            
            // Animate messages appearing one by one
            .onAppear {
                for index in 0..<messages.count {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.5) {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                            messageIndexes.append(index)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ThirdView()
}
