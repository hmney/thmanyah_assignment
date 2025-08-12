//
//  FixtureLoader.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation

/// Loads test resources from the **unit test bundle**.
import Foundation

enum FixtureLoader {
    static func data(named name: String, ext: String = "json", subfolder: String? = nil, file: StaticString = #filePath, line: UInt = #line) -> Data {
        guard let url = url(for: name, ext: ext, subfolder: subfolder) else {
            fatalError("❌ Fixture not found: \(pathDescription(name: name, ext: ext, subfolder: subfolder))", file: file, line: line)
        }
        do { return try Data(contentsOf: url) }
        catch { fatalError("❌ Could not read fixture \(url.lastPathComponent): \(error)", file: file, line: line) }
    }

    static func decode<T: Decodable>(_ type: T.Type, named name: String, ext: String = "json", subfolder: String? = nil, decoder: JSONDecoder = defaultDecoder(), file: StaticString = #filePath, line: UInt = #line) -> T {
        let bytes = data(named: name, ext: ext, subfolder: subfolder, file: file, line: line)
        do { return try decoder.decode(T.self, from: bytes) }
        catch {
            let preview = String(data: bytes.prefix(512), encoding: .utf8) ?? ""
            fatalError("❌ Decoding '\(name).\(ext)' failed: \(error)\nPreview: \(preview)", file: file, line: line)
        }
    }

    static func url(for name: String, ext: String = "json", subfolder: String? = nil) -> URL? {
        let bundle = Bundle(for: BundleToken.self)

        if let dir = subfolder.map({ "Fixtures/\($0)" }) ?? "Fixtures" as String?,
           let u = bundle.url(forResource: name, withExtension: ext, subdirectory: dir) {
            return u
        }

        if let u = bundle.url(forResource: name, withExtension: ext) {
            return u
        }

        if let path = bundle.path(forResource: "Fixtures/\(name)", ofType: ext) {
            return URL(fileURLWithPath: path)
        }

        return nil
    }

    static func defaultDecoder() -> JSONDecoder {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601Flexible
        d.keyDecodingStrategy = .useDefaultKeys
        return d
    }

    private static func pathDescription(name: String, ext: String, subfolder: String?) -> String {
        let dir = subfolder.map { "Fixtures/\($0)" } ?? "Fixtures or bundle root"
        return "\(dir)/\(name).\(ext)"
    }

    private final class BundleToken {}
}
