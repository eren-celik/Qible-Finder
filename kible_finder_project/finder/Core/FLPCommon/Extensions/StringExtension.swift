//
//  StringExtension.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 9.04.2023.
//

import Foundation

extension String {

    public var trim: String {
        self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    public var toInt: Int {
        Int(self) ?? 000000
    }

    public var toDouble: Double? {
        Double(self)
    }

    public var encodedUrl: String? {
        let allowedCharacterSet = CharacterSet.alphanumerics.union(
            CharacterSet(charactersIn: "~-_."))
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
    }

    // CONVERT ANY STRING INTO BASE64
    func toBase64() -> String? {
        let data = self.data(using: String.Encoding.utf8)
        return data?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }

    // ENCODE STRING TO SEND AS A QUERYSTRING IN AN URL
    func enconde() -> String {
        let customAllowedSet = CharacterSet(charactersIn: "=\"#%/<>?@\\^`{|}&").inverted
        let escapedString = self.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
        return escapedString ?? ""
    }

    // REMOVE HTML CODE FROM A STRING
    func removeHtml() -> String {
        let str = self.replacingOccurrences(
            of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        return str
    }

    // CONVERT A STRING INTO A DATE GIVEN A CERTAIN FORMAT
    public func toDate(format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC time zone kullan
        let date = dateFormatter.date(from: self)
        return date ?? Date()
    }

    public func indices(of occurrence: String) -> [Int] {
        var indices = [Int]()
        var position = startIndex
        while let range = range(of: occurrence, range: position..<endIndex) {
            let i = distance(
                from: startIndex,
                to: range.lowerBound)
            indices.append(i)
            let offset =
                occurrence.distance(
                    from: occurrence.startIndex,
                    to: occurrence.endIndex) - 1
            guard
                let after = index(
                    range.lowerBound,
                    offsetBy: offset,
                    limitedBy: endIndex)
            else {
                break
            }
            position = index(after: after)
        }
        return indices
    }

    public func ranges(of searchString: String) -> [Range<String.Index>] {
        let _indices = indices(of: searchString)
        let count = searchString.count
        return _indices.map({
            index(startIndex, offsetBy: $0)..<index(startIndex, offsetBy: $0 + count)
        })
    }
}

extension Range where Bound == String.Index {
    public func nsRange<S: StringProtocol>(in string: S) -> NSRange {
        .init(self, in: string)
    }

}
