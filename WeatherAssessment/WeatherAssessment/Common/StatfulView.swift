//
//  StatfulView.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 17/06/2024.
//

import SwiftUI

/// Do not implement Body, just use content as body
 protocol StatefulView: View {
    associatedtype ViewStateContent
    associatedtype LoadingView: View
    associatedtype ErrorView: View
    associatedtype EmptyStateView: View
    associatedtype Content: View

    var viewState: Binding<ViewState<ViewStateContent>> { get set }

    func errorView(_ error: Error) -> ErrorView
    func emptyView() -> EmptyStateView
    func loadingView() -> LoadingView
    func content(_ content: ViewStateContent) -> Content
}

extension StatefulView {
    @ViewBuilder
    var body: some View {
        Group {
            switch viewState.wrappedValue {
            case .empty:
                emptyView()
            case let .failed(error):
                errorView(error)
            case .loading:
                loadingView()
            case let .content(content, _):
                self.content(content)
            case .idle:
                emptyView()
            }
        }
    }
}
