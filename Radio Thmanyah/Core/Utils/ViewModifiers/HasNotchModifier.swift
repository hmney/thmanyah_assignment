////
////  HasNotchModifier.swift
////  Radio Thmanyah
////
////  Created by Houssam-Eddine Mney on 12/8/2025.
////
//
//import SwiftUI
//
//private struct HasNotchModifier: ViewModifier {
//    func body(content: Content) -> some View {
//        content.background(
//            GeometryReader { geo in
//                Color.clear
//                    .preference(key: HasNotchPreferenceKey.self,
//                                value: geo.safeAreaInsets.top > 20)
//            }
//        )
//        .onPreferenceChange(HasNotchPreferenceKey.self) { value in
//            DispatchQueue.main.async {
//                UIApplication.shared.windows.first?
//                    .rootViewController?
//                    .view.environment(\.hasNotch, value)
//            }
//        }
//    }
//}
//
//private struct HasNotchPreferenceKey: PreferenceKey {
//    static var defaultValue: Bool = false
//    static func reduce(value: inout Bool, nextValue: () -> Bool) {
//        value = nextValue()
//    }
//}
//
//extension View {
//    func detectNotch() -> some View {
//        modifier(HasNotchModifier())
//    }
//}
