//
//  HTMLText.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import SwiftUI
import UIKit

struct HTMLText: View {
    private let attributedString: AttributedString

    @MainActor
    init(_ htmlString: String,
         fontSize: CGFloat = 16,
         fontWeight: UIFont.Weight = .regular,
         textColor: UIColor = .label) {

        let font = UIFont(name: "IBMPlexSansArabic-\(fontWeight.fontSuffix)", size: fontSize)
        ?? UIFont.systemFont(ofSize: fontSize, weight: fontWeight)

        self.attributedString = HTMLText.makeAttributed(
            htmlString: htmlString,
            baseFont: font,
            textColor: textColor
        )
    }

    init(_ htmlString: String, font: UIFont, textColor: UIColor = .label) {
        self.attributedString = HTMLText.makeAttributed(
            htmlString: htmlString,
            baseFont: font,
            textColor: textColor
        )
    }

    var body: some View {
        Text(attributedString)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
    }
}

private extension HTMLText {
    static func makeAttributed(htmlString: String, baseFont: UIFont, textColor: UIColor) -> AttributedString {
        guard Thread.isMainThread else {
            return DispatchQueue.main.sync {
                return makeAttributed(htmlString: htmlString, baseFont: baseFont, textColor: textColor)
            }
        }
        do {
            // Create a complete HTML document with CSS styling
            let styledHTML = """
                <html>
                <head>
                    <style>
                        body {
                            font-family: 'IBMPlexSansArabic-Regular', -apple-system, BlinkMacSystemFont, sans-serif;
                            font-size: \(baseFont.pointSize)px;
                            color: \(textColor.toHex());
                            line-height: 1.4;
                            margin: 0;
                            padding: 0;
                        }
                        b, strong { font-family: 'IBMPlexSansArabic-Bold', 'IBMPlexSansArabic-Regular', sans-serif; font-weight: bold; }
                        i, em { font-family: 'IBMPlexSansArabic-Italic', 'IBMPlexSansArabic-Regular', sans-serif; font-style: italic; }
                        u { text-decoration: underline; }
                        a { color: #007AFF; text-decoration: none; }
                        p { margin: 0 0 8px 0; }
                        br { line-height: 1.4; }
                    </style>
                </head>
                <body>\(htmlString)</body>
                </html>
                """

            let data = Data(styledHTML.utf8)
            let nsAttributedString = try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )

            return AttributedString(nsAttributedString)
        } catch {
            print("Error parsing HTML: \(error)")
            return AttributedString(htmlString.strippingHTMLTags())
        }
    }
}

// MARK: - Usage Examples

struct ContentView: View {
    let htmlStrings = [
        "The hosts of NPR's <i>All Things Considered</i> help you make sense of a major news story.",
        "This text has <b>bold</b>, <i>italic</i>, and <u>underlined</u> content.",
        "You can also have <a href='https://example.com'>links</a> and <br/>line breaks.",
        "Support <strong>strong text</strong> and <em>emphasized text</em>.",
        "Multiple <b>formatting <i>options</i></b> can be <u>nested</u>."
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(Array(htmlStrings.enumerated()), id: \.offset) { index, htmlString in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Example \(index + 1):")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        HTMLText(htmlString, fontSize: 16)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("HTML Text Examples")
    }
}

// MARK: - Advanced Version with Custom Styling

struct StyledHTMLText: View {
    let htmlString: String
    let fontSize: CGFloat
    let fontWeight: UIFont.Weight
    let textColor: Color

    init(_ htmlString: String, fontSize: CGFloat = 16, fontWeight: UIFont.Weight = .regular, textColor: Color = .primary) {
        self.htmlString = htmlString
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.textColor = textColor
    }

    var body: some View {
        HTMLText(
            htmlString,
            fontSize: fontSize,
            fontWeight: fontWeight,
            textColor: UIColor(textColor)
        )
    }
}

#Preview {
    NavigationView {
        ContentView()
    }
}
