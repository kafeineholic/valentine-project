//
//  MainView.swift
//  VProject
//
//  Created by Pattranith Ruangrotch on 13/2/2568 BE.
//

import SwiftUI

struct MainView: View {
    
    @State private var showLoading = false
    @State private var showSecondView = false
    @State private var showAlert = false // To control alert visibility
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("wallpaper")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .navigationBarHidden(true)
                VStack {
                    // Main content inside the box
                    VStack(spacing: 20) {
                        Text("Will You Be\nMy Valentine?")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .fontDesign(.monospaced)
                            .foregroundColor(Color(red: 0.158, green: 0.158, blue: 0.237))
                            .padding(.top, 30)
                        
                        HStack {
                            Button(action: {
                                showLoading = true
                                // waiting 2s then go to SecondView
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    showLoading = false
                                    showSecondView = true
                                }
                            }) {
                                Text("Yes")
                                    .fontWeight(.semibold)
                                    .fontDesign(.monospaced)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(Color.green)
                            
                            Button(action: {
                                // Show alert when "No" button is clicked
                                showAlert = true
                            }) {
                                Text("No")
                                    .fontWeight(.semibold)
                                    .fontDesign(.monospaced)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(Color.red)
                            .padding()
                        }
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 40)
                    .background(Color(red: 1.0, green: 0.866, blue: 0.882, opacity: 0.9))
                    .cornerRadius(20) // Rounded corners
                    .shadow(radius: 10)
                }
                .navigationDestination(isPresented: $showLoading) {
                    LoadingView()
                }
                
                // Wait until loading is finished, then show SecondView
                .navigationDestination(isPresented: $showSecondView) {
                    SecondView()
                }
                
            }
            // Add the alert that is triggered when "No" is clicked
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("The request failed. Please try again."),
                    primaryButton: .default(Text("Try Again")) {
                        // Code to re-try (close alert and proceed with the action)
                        showAlert = false
                        showLoading = true
                        // Wait for 2 seconds before going to the SecondView
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showLoading = false
                            showSecondView = true
                        }
                    },
                    secondaryButton: .cancel {
                        showAlert = false
                    }
                )
            }
        }
    }
}

#Preview {
    MainView()
}
