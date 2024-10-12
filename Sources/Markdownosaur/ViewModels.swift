//
//  File.swift
//  Markdownosaur
//
//  Created by dcl on 10/12/24.
//

import SwiftUI

struct SelectableModifier: ViewModifier {
    let isSelectable: Bool
    
    func body(content: Content) -> some View {
        content
            .environment(\.isSelectable, isSelectable)
    }
}


private struct SelectableKey: EnvironmentKey {
    static let defaultValue: Bool = false
}


struct ContainerConstraint {
  var width: CGFloat
  var horiPadding: CGFloat
  var vertPadding: CGFloat
  static let `default` = ContainerConstraint(width: 0, horiPadding: 0, vertPadding: 0)
}

struct ContainerConstraintModifier: ViewModifier {
  let constraint: ContainerConstraint
  func body(content: Content) -> some View {
    content
      .environment(\.containerConstraint, constraint)
  }
}

private struct ContainerConstraintKey: EnvironmentKey {
    static let defaultValue: ContainerConstraint = .default
}



extension EnvironmentValues {
    var isSelectable: Bool {
        get { self[SelectableKey.self] }
        set { self[SelectableKey.self] = newValue }
    }
  
  
  var containerConstraint: ContainerConstraint {
    get { self[ContainerConstraintKey.self] }
    set { self[ContainerConstraintKey.self] = newValue }
  }
}

extension View {
    public func selectable(_ isSelectable: Bool) -> some View {
        self.modifier(SelectableModifier(isSelectable: isSelectable))
    }
  
  
  public func containerConstraint(_ width: CGFloat, horiPadding: CGFloat = 0, verticalPadding: CGFloat = 0) -> some View {
    self.modifier(ContainerConstraintModifier(constraint: .init(width: width, horiPadding: horiPadding, vertPadding: verticalPadding)))
  }
}
