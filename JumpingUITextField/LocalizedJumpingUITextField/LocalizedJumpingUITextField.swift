//
//  Showyou Generic UI - https://showyou.info/
//  The interactive productcatalogue
//
//  Copyright (c) 2019 schoko pro GmbH, Wiesbaden
//

import UIKit
import LocalizableUIElements

@IBDesignable public class LocalizedJumpingUITextField: LocalizedUITextField {
  @IBInspectable var group: String = ""
  @IBInspectable var order: UInt = 0

  public static func nextJumpingUITextField(_ field: LocalizedJumpingUITextField) {
    if field.order > 0 && field.group.count > 0 {
      for subview in field.getJumpingInputs() {
        if field.group == subview.group && subview.order == field.order + 1 {
          subview.becomeFirstResponder()
        }
      }
    }

    field.resignFirstResponder()
  }

  private func getJumpingInputs() -> [LocalizedJumpingUITextField] {
    var subberviews: [UIView] = []
    var inputs: [LocalizedJumpingUITextField] = []

    var supperview = self.superview
    while supperview?.superview != nil {
      supperview = supperview?.superview
    }
    if let supperview = supperview {
      subberviews = self.extractSubviews(view: supperview)
    }

    for jumping in subberviews where jumping is LocalizedJumpingUITextField {
      if let jumping = jumping as? LocalizedJumpingUITextField {
        inputs.append(jumping)
      }
    }

    return inputs
  }

  private func extractSubviews(view: UIView) -> [UIView] {
    var subberviews: [UIView] = []

    if view.subviews.count == 0 {
      subberviews.append(view)
    } else {
      subberviews.append(view)
      for subview in view.subviews {
        subberviews.append(contentsOf: self.extractSubviews(view: subview))
      }
    }

    return subberviews
  }
}
