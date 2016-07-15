//
//  Created by Tom Baranes on 30/03/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class SystemCameraIrisAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  // MARK: - private
  private var hollowState: TransitionHollowState
  
  public init(hollowState: TransitionHollowState, transitionDuration: Duration) {    
    self.transitionDuration = transitionDuration
    self.hollowState = hollowState
    
    switch hollowState {
    case .open:
      self.transitionAnimationType = .systemCameraIris(hollowState: .open)
      self.reverseAnimationType = .systemCameraIris(hollowState: .close)
      self.interactiveGestureType = .pinch(direction: .close)
    case .close:
      self.transitionAnimationType = .systemCameraIris(hollowState: .close)
      self.reverseAnimationType = .systemCameraIris(hollowState: .open)
      self.interactiveGestureType = .pinch(direction: .open)
    case .none:
      self.transitionAnimationType = .systemCameraIris(hollowState: .none)
      self.reverseAnimationType = .systemCameraIris(hollowState: .none)
      self.interactiveGestureType = .pinch(direction: .close)
    }
    
    super.init()
  }
}

extension SystemCameraIrisAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return getTransitionDuration(using: transitionContext)
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    switch self.hollowState {
    case .open:
      animateWithCATransition(using: transitionContext, type: SystemTransitionType.cameraIrisHollowOpen, subtype: nil)
    case .close:
      animateWithCATransition(using: transitionContext, type: SystemTransitionType.cameraIrisHollowClose, subtype: nil)
    case .none:
      animateWithCATransition(using: transitionContext, type: SystemTransitionType.cameraIris, subtype: nil)

    }
  }
}
