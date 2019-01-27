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

import UIKit

@IBDesignable open class LocalizedUITabBarItem: UITabBarItem {
  @IBInspectable public var titleKey: String = ""
  @IBInspectable public var badgeKey: String = ""

  open override func awakeFromNib() {
    super.awakeFromNib()

    NotificationCenter.default.addObserver(
      forName: Localizable.NotificationChannel,
      object: nil,
      queue: nil) { _ in
      self.awakeFromNib()
    }

    if Localizable.check(key: self.titleKey) {
      self.localizedTitle(key: self.titleKey)
    }

    if Localizable.check(key: self.badgeKey) {
      self.localizedBadge(key: self.badgeKey)
    }
  }
}

public extension UITabBarItem {
  public func localizedTitle(key: String, _ args: CVarArg...) {
    let localized = Localizable.localize(string: key, arguments: args)
    if self.title != localized {
      self.title = localized
    }
  }

  public func localizedBadge(key: String?, _ args: CVarArg...) {
    if let key = key {
      let localized = Localizable.localize(string: key, arguments: args)
      if self.badgeValue != localized {
        self.badgeValue = localized
      }

      return
    }

    self.badgeValue = nil
    return
  }
}
