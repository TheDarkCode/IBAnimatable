//
//  Created by Tom Baranes on 02/04/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class SystemRevealAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  // MARK: - private
  private var fromDirection: TransitionDirection
  
  public init(fromDirection: TransitionDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .right:
      self.transitionAnimationType = .systemReveal(fromDirection: .right)
      self.reverseAnimationType = .systemReveal(fromDirection: .left)
      self.interactiveGestureType = .pan(fromDirection: .left)
    case .top:
      self.transitionAnimationType = .systemReveal(fromDirection: .top)
      self.reverseAnimationType = .systemReveal(fromDirection: .bottom)
      self.interactiveGestureType = .pan(fromDirection: .bottom)
    case .bottom:
      self.transitionAnimationType = .systemReveal(fromDirection: .bottom)
      self.reverseAnimationType = .systemReveal(fromDirection: .top)
      self.interactiveGestureType = .pan(fromDirection: .top)
    default:
      self.transitionAnimationType = .systemPush(fromDirection: .left)
      self.reverseAnimationType = .systemPush(fromDirection: .right)
      self.interactiveGestureType = .pan(fromDirection: .right)
    }
    
    super.init()
  }
}

extension SystemRevealAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return getTransitionDuration(using: transitionContext)
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(using: transitionContext, type: SystemTransitionType.reveal, subtype: fromDirection.CATransitionSubtype)
  }
}
