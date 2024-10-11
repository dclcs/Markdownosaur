//
//  ViewController.swift
//  ExampleProject
//
//  Created by Ezequiel Becerra on 29/05/2022.
//

import UIKit
import Markdown
import Markdownosaur

import SwiftUI

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.attributedText = attributedText(from: markdownText())
    }

    /// Transforms markdown text to NSAttributedString
    

    /// Gets text from "test.md"
    

}

private func attributedText(from markdown: String) -> NSAttributedString {
    let document = Document(parsing: markdown)

    var markdownosaur = Markdownosaur()
    return markdownosaur.attributedString(from: document)
}

private func markdownText() -> String {
    let url = Bundle.main.url(forResource: "test", withExtension: "md")!
    let data = try! Data(contentsOf: url)
    return String(data: data, encoding: .utf8)!
}


struct TextViewWrapper: UIViewRepresentable {
  func updateUIView(_ uiView: UIViewType, context: Context) {
    
  }
  
  
  let markdownString: String
  
  func makeUIView(context: Context) -> some UIView {
    let view = UITextView()
    view.isEditable = false
    view.attributedText = attributedText(from: markdownString)
    view.isSelectable = true
    return view
  }
  
  
  

  
  
}

#Preview {

  let document = Document(parsing: markdownText())
Text("132")
  
  TextViewWrapper(markdownString: markdownText())
    .textSelection(.enabled)
}
