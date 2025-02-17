//
//  SecondView.swift
//  VProject
//
//  Created by Pattranith Ruangrotch on 13/2/2568 BE.
//

import SwiftUI

struct SecondView: View {
    
    @State private var timeElapsed: String = ""
    //insert your startdate here
    private let startDate = Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 3))!
    
    @State private var showThirdView = false
    
    var body: some View {
        NavigationStack { //open Navigation Stack
            ZStack { //open ZStack1
                Image("wallpaper")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .navigationBarHidden(true)
                VStack { //open VStack1
                    Text("We've been together for:")
                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                        .padding()
                        .multilineTextAlignment(.center)
                    Text(timeElapsed)
                        .font(.system(size: 40, weight: .bold, design: .monospaced))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text("... and still counting <3")
                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                        .padding()
                        .multilineTextAlignment(.center)
                    Button(action: {
                        showThirdView = true
                    }) {
                        Text("Next Page")
                            .fontWeight(.semibold)
                            .fontDesign(.monospaced)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)

                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 0.998, green: 0.432, blue: 0.57))
                    
                } //close VStack1
                Spacer()
                .navigationDestination(isPresented: $showThirdView) {
                    ThirdView()
                }
            } //close ZStack1
            .onAppear {
                //calculate time when SecondView is start
                startTimer()
            }
        } //close NavigationStack
    }
    
    //time calculate function
    func updateTimeElapsed() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: startDate, to: currentDate)
        
        if let day = components.day, let hour = components.hour, let minute = components.minute, let second = components.second {
            timeElapsed = String(format: "%02d Days\n%02d Hours\n%02d Minutes\n%02d Seconds", day, hour, minute, second)
        }
    }
    
    //start timer function
    func startTimer() {
        //start timer for updating time
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            updateTimeElapsed()
        }
    }
}

#Preview {
    SecondView()
}
