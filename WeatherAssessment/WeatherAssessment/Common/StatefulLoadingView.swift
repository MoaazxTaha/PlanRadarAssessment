//
//  SessionDataController.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 17/06/2024.
//

import SwiftUI

public struct StatefulLoadingView: View {
    public init() {}

    public var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .progressViewStyle(
                    CircularProgressViewStyle(tint: .blue)
                )
            Spacer()
        }
    }
}
