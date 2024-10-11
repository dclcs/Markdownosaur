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


public struct MarkdownView: NSViewRepresentable {
    public init(markdown: String, height: Binding<CGFloat> = .constant(0)) {
        self.content = markdown
        self._textViewHeight = height
    }
  
    @Binding var textViewHeight: CGFloat
    var content: String
  
    public func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()
        textView.wantsLayer = true
        textView.isEditable = false
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainer?.size = NSSize(width: 260, height: CGFloat.greatestFiniteMagnitude)
        textView.textContainer?.widthTracksTextView = true
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false
        textView.layer?.backgroundColor = .clear
        textView.backgroundColor = .clear
        textView.isSelectable = false /// 控制textView 是否可点击
        return textView
    }
  
    public func updateNSView(_ nsView: NSTextView, context: Context) {
        let document = Document(parsing: content)
        var renderer = Markdownosaur(theme: .linkSummaryTheme)
        let attributedString = renderer.attributedString(from: document)
        
        nsView.textStorage?.setAttributedString(attributedString)
        nsView.layoutManager?.ensureLayout(for: nsView.textContainer!)
        
        DispatchQueue.main.async {
            if let height = nsView.layoutManager?.usedRect(for: nsView.textContainer!).height {
                self.textViewHeight = height
                debugPrint("Updated height: \(height)")
            }
        }
    }
  
  
  /// sizeThatFits 会多次调用
  @available(macOS 13.0, *)
  public func sizeThatFits(_ proposal: ProposedViewSize, nsView: NSTextView, context: Context) -> CGSize? {
        nsView.layoutManager?.ensureLayout(for: nsView.textContainer!)
        let height = nsView.layoutManager?.usedRect(for: nsView.textContainer!).height ?? 0
        return CGSize(width: 260, height: height)
    }
}



#endif
