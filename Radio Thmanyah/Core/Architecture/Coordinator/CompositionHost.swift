//
//  CompositionHost.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 16/8/2025.
//


import SwiftUI

struct CompositionHost<Route: BaseRoute, VM: ViewModelProtocol & ObservableObject, Content: View>: View where VM.Route == Route {

    @StateObject private var viewModel: VM
    private let container: DIContainer
    private let content: () -> Content

    init(
        container: DIContainer,
        makeViewModel: @escaping (DIContainer) -> VM,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.container = container
        _viewModel = StateObject(wrappedValue: makeViewModel(container))
        self.content = content
    }

    var body: some View {
        content()
            .environment(\.container, container)
            .environmentObject(viewModel)
    }
}
