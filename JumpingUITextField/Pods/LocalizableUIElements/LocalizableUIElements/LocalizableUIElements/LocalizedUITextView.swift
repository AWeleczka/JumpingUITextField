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

@IBDesignable open class LocalizedUITextView: UITextView {
  @IBInspectable var textKey: String = ""

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
  }
}

public extension UITextView {
  public func localizedText(key: String, _ args: CVarArg...) {
    let localized = Localizable.localize(string: key, arguments: args)
    if self.text != localized {
      self.text = localized
    }
  }
}
