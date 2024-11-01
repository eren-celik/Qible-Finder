//
//  AppFileManager.swift
//  FLCommon
//
//  Created by Ugur Cakmakci on 9.04.2023.
//

import Foundation

final class AppFileManager {
    
    class func downloadFile(url: URL?) async -> URL? {
        guard let url else { return nil }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let fileName = response.suggestedFilename
            let tmpURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName ?? "")
            try data.write(to: tmpURL)
            return tmpURL
        } catch {
            return nil
        }
    }
}
