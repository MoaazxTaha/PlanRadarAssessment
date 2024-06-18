//
//  CustomNavigationBarView.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 17/06/2024.
//

import SwiftUI
import SFSafeSymbols

enum CustomNavigationBarView {
    static func configureWithLeftButton(handler: @escaping () -> Void, title: String, buttonImage: Image?) -> some View {
        HStack(alignment: .center) {
            Button (action: {
                handler()
            }, label: {
                ZStack {
                    Image("buttonLeft")
                        .frame(width: 72.0, height: 53)
                        .padding(.top, 40)
                    if let buttonImage {
                        buttonImage
                            .foregroundColor(.white)
                            .padding(.trailing, 16)
                    }
                }
            })
            Spacer()
            Text(title)
                .multilineTextAlignment(.center)
                .padding(.trailing, 72)
            Spacer()
        }
        .background(Color.clear)
        .navigationBarHidden(true)
    }
    static func configureWithRightButton(handler: @escaping () -> Void, title: String, buttonImage: Image?) -> some View {
        
        HStack(alignment: .center) {
            Spacer()
            Text(title)
                .padding(.leading, 72)
            Spacer()
            Button(action: {
                handler()
            }, label: {
                ZStack {
                    Image("buttonRight")
                        .frame(width: 72.0, height: 53)
                        .padding(.top, 40)
                    
                    if let buttonImage {
                        buttonImage
                            .foregroundColor(.white)
                            .padding(.leading, 16)
                    }
                }
            })
        }
        .background(Color.clear)
        .navigationBarHidden(true)
    }
    
    static func updateSmallTitleAppearanceWithCustomFont(_ font: UIFont = UIFont.systemFont(ofSize: 13)) {
        let appear = UINavigationBarAppearance()

            let atters: [NSAttributedString.Key: Any] = [
                .font: font
            ]

            appear.largeTitleTextAttributes = atters
            appear.titleTextAttributes = atters
            UINavigationBar.appearance().standardAppearance = appear
            UINavigationBar.appearance().compactAppearance = appear
            UINavigationBar.appearance().scrollEdgeAppearance = appear
    }
}
