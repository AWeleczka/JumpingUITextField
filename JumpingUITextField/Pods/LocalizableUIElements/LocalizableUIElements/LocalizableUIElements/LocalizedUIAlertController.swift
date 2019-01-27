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

public extension UIAlertController {
  public convenience init(
    title: Localizable.Item,
    message: Localizable.Item,
    preferredStyle: UIAlertController.Style) {
    var localizedTitle: String?
    var localizedMessage: String?

    if Localizable.check(key: title.key) {
      localizedTitle = Localizable.localize(item: title)
    }

    if Localizable.check(key: message.key) {
      localizedMessage = Localizable.localize(item: message)
    }

    self.init(title: localizedTitle, message: localizedMessage, preferredStyle: preferredStyle)
  }
}

public extension UIAlertAction {
  public convenience init(
    title: Localizable.Item,
    style: UIAlertAction.Style,
    handler: ((UIAlertAction) -> Void)? = nil) {
    let localizedTitle = Localizable.localize(item: title)

    self.init(title: localizedTitle, style: style, handler: handler)
  }
}
