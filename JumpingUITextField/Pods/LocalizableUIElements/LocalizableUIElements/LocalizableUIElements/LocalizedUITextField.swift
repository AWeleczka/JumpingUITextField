//
//  JumpingUITextField - https://github.com/AWeleczka/JumpingUITextField
//  Extension for UITextField written in swift 4.2
//
//  Readme:        https://github.com/AWeleczka/JumpingUITextField/blob/master/README.md
//  Changelog:     https://github.com/AWeleczka/JumpingUITextField/blob/master/CHANGELOG.md
//  CocoaPod:      https://cocoapods.org/pods/JumpingUITextField
//  License (MIT): https://github.com/AWeleczka/JumpingUITextField/blob/master/LICENSE
//
//  Copyright (c) 2019 Alexander Weleczka - https://AWeleczka.de/
//

import UIKit

@IBDesignable open class LocalizedUITextField: UITextField {
  @IBInspectable var textKey: String = ""
  @IBInspectable var placeholderKey: String = ""

  open override func awakeFromNib() {
    super.awakeFromNib()

    NotificationCenter.default.addObserver(
      forName: Localizable.NotificationChannel,
      object: nil,
      queue: nil) { _ in
      self.awakeFromNib()
    }

    if Localizable.check(key: self.textKey) {
      self.localizedText(key: self.textKey)
    }

    if Localizable.check(key: self.placeholderKey) {
      self.localizedPlaceholder(key: self.placeholderKey)
    }
  }
}

public extension UITextField {
  public func localizedText(key: String, _ args: CVarArg...) {
    let localized = Localizable.localize(string: key, arguments: args)
    if self.text != localized {
      self.text = localized
    }
  }

  public func localizedPlaceholder(key: String, _ args: CVarArg...) {
    let localized = Localizable.localize(string: key, arguments: args)
    if self.placeholder != localized {
      self.placeholder = localized
    }
  }
}
