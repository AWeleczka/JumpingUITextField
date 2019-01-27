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

@IBDesignable open class LocalizedUIButton: UIButton {
  @IBInspectable var titleKey: String = ""

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
  }
}

public extension UIButton {
  public func localizedTitle(key: String, _ args: CVarArg...) {
    let localized = Localizable.localize(string: key, arguments: args)
    if self.title(for: .normal) != localized {
      self.setTitle(localized, for: UIControl.State.normal)
      self.setTitle(localized, for: UIControl.State.highlighted)
      self.setTitle(localized, for: UIControl.State.disabled)
      self.setTitle(localized, for: UIControl.State.selected)
      self.setTitle(localized, for: UIControl.State.application)
      if #available(iOS 9.0, *) {
        self.setTitle(localized, for: UIControl.State.focused)
      }
    }
  }
}
