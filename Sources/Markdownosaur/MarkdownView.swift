//
//  File.swift
//  Markdownosaur
//
//  Created by dcl on 10/11/24.
//

import SwiftUI
import Markdown
#if os(macOS)

import AppKit


extension MarkdownView {
  public static func string(from content: String) -> String {
    var parser = Markdownosaur()
    return parser.attributedString(from: Document(parsing: content)).string
  }
}

public struct MarkdownView: NSViewRepresentable {
  
  @Binding var textViewHeight: CGFloat
  var content: String
  @Environment(\.isSelectable) private var isSelectable: Bool
  @Environment(\.containerConstraint) private var containerConstraint: ContainerConstraint
  
  public init(markdown: String,
              height: Binding<CGFloat> = .constant(0)) {
        self.content = markdown
        self._textViewHeight = height
    }

    public func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()
        textView.wantsLayer = true
        textView.isEditable = false
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        if containerConstraint.width != 0 {
          textView.textContainer?.size = NSSize(width: containerConstraint.width, height: CGFloat.greatestFiniteMagnitude)
        } else {
          textView.textContainer?.size = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)

        }
      
        textView.textContainerInset = NSSize(width: containerConstraint.horiPadding, height: 0)
      
        textView.textContainer?.widthTracksTextView = true
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false
        textView.layer?.backgroundColor = .clear
        textView.backgroundColor = .clear
        textView.isSelectable = isSelectable /// 控制textView 是否可点击
        
        return textView
    }
  
    public func updateNSView(_ nsView: NSTextView, context: Context) {
        let document = Document(parsing: content)
        var renderer = Markdownosaur(theme: .linkSummaryTheme)
        let attributedString = renderer.attributedString(from: document)
        
        nsView.textStorage?.setAttributedString(attributedString)
        nsView.layoutManager?.ensureLayout(for: nsView.textContainer!)
        nsView.isSelectable = isSelectable
        DispatchQueue.main.async {
            if let height = nsView.layoutManager?.usedRect(for: nsView.textContainer!).height {
                self.textViewHeight = height
                debugPrint("Updated height: \(height)")
            }
        }
    }
  
  
  /// sizeThatFits 会多次调用
  public func sizeThatFits(_ proposal: ProposedViewSize, nsView: NSTextView, context: Context) -> CGSize? {
        nsView.layoutManager?.ensureLayout(for: nsView.textContainer!)
        let height = nsView.layoutManager?.usedRect(for: nsView.textContainer!).height ?? 0
        debugPrint("size: \(CGSize(width: containerConstraint.width, height: height))")
        return CGSize(width: containerConstraint.width, height: height)
    }
}


#endif
