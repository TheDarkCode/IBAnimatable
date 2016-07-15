//
//  Created by Tom Baranes on 28/03/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class SystemPageAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  // MARK: - private
  private var type: TransitionPageType
  
  public init(type: TransitionPageType, transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    self.type = type
    
    switch type {
    case .curl:
      self.transitionAnimationType = .systemPage(type: .curl)
      self.reverseAnimationType = .systemPage(type: .unCurl)
    case .unCurl:
      self.transitionAnimationType = .systemPage(type: .unCurl)
      self.reverseAnimationType = .systemPage(type: .curl)
    }
    
    super.init()
  }
}

extension SystemPageAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return getTransitionDuration(using: transitionContext)
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    switch self.type {
    case .curl:
      animateWithCATransition(using: transitionContext, type: SystemTransitionType.pageCurl, subtype: nil)
    case .unCurl:
      animateWithCATransition(using: transitionContext, type: SystemTransitionType.pageUnCurl, subtype: nil)
    }
  }
}
