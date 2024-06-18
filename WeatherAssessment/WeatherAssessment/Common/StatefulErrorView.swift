//
//  SessionDataController.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 17/06/2024.
//

import SwiftUI

public struct StatefulErrorView: View {
    public var onRetry: () -> Void
    private var error: Error

    public init(error: Error, onRetry: @escaping () -> Void) {
        self.onRetry = onRetry
        self.error = error
    }

    private var errorMessage: String {
        guard let error = error as? LocalizedError else { return "Something went wrong, please try again later." }
        return error.errorDescription ?? "Something went wrong, please try again later."
    }

    public var body: some View {
        VStack(spacing: 16) {
            Text(errorMessage)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Button("Dismiss", action: onRetry)
                .foregroundColor(.red)
        }.padding()
    }
}
