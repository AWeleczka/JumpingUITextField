//
//  LocalizableUIElements - https://github.com/AWeleczka/LocalizableUIElements
//  A set of UIKit-Elements with easy localization in code and storyboard
//
//  Readme:        https://github.com/AWeleczka/LocalizableUIElements/blob/master/README.md
//  Changelog:     https://github.com/AWeleczka/LocalizableUIElements/blob/master/CHANGELOG.md
//  CocoaPod:      https://cocoapods.org/pods/LocalizableUIElements
//  License (MIT): https://github.com/AWeleczka/LocalizableUIElements/blob/master/LICENSE
//
//  Copyright (c) 2019 Alexander Weleczka - https://AWeleczka.de/
//

import Foundation

public class Localizable {
  public struct Item {
    public let key: String
    public let args: [CVarArg]

    public init(
      key: String,
      _ args: CVarArg...) {
      self.key = key
      self.args = args
    }
  }

  /// Activate locaization-debug - causes only keys to be printed if set to true
  public static var DisplayDebugKeys: Bool = false

  public static var LanguageCode: String = "" {
    didSet {
      NotificationCenter.default.post(name: Localizable.NotificationChannel, object: nil)
    }
  }

  public static let NotificationChannel = NSNotification.Name(
    rawValue: "LocalizableUIElements_LanguageCodeChange")

  public static func check(
    key: String) -> Bool {
    guard key.count > 0 else {
      NSLog("Key is empty")
      return false
    }

    if Localizable.getLocalization(key: key).count == 0 {
      NSLog("Missing localization for key '%@'", key)
      return false
    }

    return true
  }

  public static func localize(
    item: Localizable.Item) -> String {
    guard Localizable.check(key: item.key) else {
      return String(format: "Missing localization for key '%@'", item.key)
    }

    return Localizable.localize(string: item.key, arguments: item.args)
  }

  public static func localize(
    string key: String,
    _ args: CVarArg...) -> String {
    return Localizable.localize(string: key, arguments: args)
  }

  public static func localize(
    string key: String,
    arguments: [CVarArg]) -> String {
    // Validate key has a valid and not empty localization
    guard Localizable.check(key: key) else {
      return String(format: "Missing localization for key '%@'", key)
    }

    // Output set to debug - print only localization-key
    guard !Localizable.DisplayDebugKeys else {
      return key
    }

    let localization = Localizable.getLocalization(key: key)
    let localizedString = String(format: localization, arguments: arguments)

    return localizedString
  }

  public static func localize(
    attributedString key: String,
    _ args: CVarArg...,
    attributes: [NSAttributedString.Key: AnyObject]? = nil) -> NSAttributedString {
    // Validate key has a valid and not empty localization
    guard Localizable.check(key: key) else {
      return NSAttributedString(
        string: String(format: "Missing localization for key '%@'", key),
        attributes: attributes)
    }

    // Output set to debug - print only localization-key
    guard !Localizable.DisplayDebugKeys else {
      return NSAttributedString(string: key, attributes: attributes)
    }

    let localizedString = Localizable.localize(string: key, arguments: args)
    let localizedAttributedString = NSAttributedString(string: localizedString, attributes: attributes)

    return localizedAttributedString
  }

  public static func localize(
    url key: String,
    _ args: CVarArg...) -> URL {
    // Validate key has a valid and not empty localization
    guard Localizable.check(key: key) else {
      return URL(string: String(format: "http://localhost#missing=%@", key))!
    }

    // Output set to debug - print only localization-key
    guard !Localizable.DisplayDebugKeys else {
      return URL(string: String(format: "http://localhost#debug=%@", key))!
    }

    let localizedString = Localizable.localize(string: key, arguments: args)
    let localizedURL = URL(string: localizedString)

    if let localizedURL = localizedURL {
      return localizedURL
    } else {
      return URL(string: String(format: "http://localhost#invalid=%@", key))!
    }
  }

  /// Get the raw localization value for a key and languagecode
  public static func getLocalization(
    key: String,
    languageCode: String = Localizable.getLanguageCode()) -> String {
    if let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
      let bundle = Bundle(path: bundlePath) {
      let localization = NSLocalizedString(key, tableName: nil, bundle: bundle, value: key, comment: key)

      guard localization != key else {
        return ""
      }

      return localization
    }

    let localization = NSLocalizedString(key, comment: key)

    guard localization != key else {
      return ""
    }

    return localization
  }

  /// Get the set Localizable.LanguageCode or the system prefered language if not set
  public static func getLanguageCode() -> String {
    if Localizable.LanguageCode.isEmpty {
      if let languageCode = Locale.preferredLanguages.first {
        return languageCode
      }
    }

    return Localizable.LanguageCode
  }
}

public extension String {
  public func localized(_ args: CVarArg...) -> String {
    return Localizable.localize(string: self, arguments: args)
  }
}
