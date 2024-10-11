//
//  File.swift
//  Markdownosaur
//
//  Created by dcl on 10/11/24.
//

import Foundation
import Markdown
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#else
import AppKit
#endif
import SwiftUI


#if os(watchOS)
var systemGray: TTColor { TTColor.gray }
var systemBlue: TTColor { TTColor.blue }
#else
var systemGray: TTColor { TTColor.systemGray }
var systemBlue: TTColor { TTColor.systemBlue }
#endif


public let baseFontSize: CGFloat = 15.0

public extension TTFont {
  
#if os(macOS)
  static public var baseFont = NSFont.systemFont(ofSize: baseFontSize, weight: .regular)
#else
  static public var baseFont = UIFont.systemFont(ofSize: baseFontSize, weight: .regular)
#endif
}


public protocol TextStyle {
  
}

public struct EmptyTextStyle: TextStyle {
  public init() {}
}


public struct Theme {
  public var text: TextStyle = EmptyTextStyle()
  public var textFont: TTFont = .baseFont    // 普通文本字体
  public var emphasisFontTraits: TTFontDescriptor.SymbolicTraits = .italic
  public var strongFontTraits: TTFontDescriptor.SymbolicTraits = .bold
  public var headingFontTraits: TTFontDescriptor.SymbolicTraits = .bold
  public var headingMaxPointSize: CGFloat = 28.0 // heading 标签字体 = max - 2 * (heading level)
  public var linkColor: TTColor = TTColor.systemBlue
  public var strikethroughType: NSUnderlineStyle = .single
  public var unorderedListTag: String = "•"
  public var unorderedBulletFont: TTFont = TTFont.systemFont(ofSize: baseFontSize, weight: .regular)
  public var listLeftMargin: CGFloat = 15.0
  public var listDepthMargin: CGFloat = 20.0
  public var listRightMargin: CGFloat = 8.0
  public var listItemContentFont: TTFont = .baseFont
  public var orderedNumeralFont: TTFont = TTFont.monospacedDigitSystemFont(ofSize: baseFontSize, weight: .regular)
  
  public var codeForegroudColor: TTColor = systemGray
  public var codeFont: TTFont = TTFont.monospacedSystemFont(ofSize: baseFontSize - 1.0, weight: .regular)
  
  public var quoteLeftMargin: CGFloat = 15.0
  public var quoteDepthMargin: CGFloat = 20.0
  public var quoteFont: TTFont = TTFont.systemFont(ofSize: baseFontSize, weight: .regular)
  public var quoteForegroudColor: TTColor = systemGray
  
  public var paragraphLineSpacing: CGFloat = 10
  
  static public var baseTheme: Theme = Theme()
  
  static public var testTheme: Theme = Theme(
    emphasisFontTraits: .italic,
    strongFontTraits: .bold,
    headingFontTraits: .italic,
    headingMaxPointSize: 30,
    linkColor: TTColor.gray,
    strikethroughType: .thick,
    unorderedListTag: "a",
    listLeftMargin: 4,
    listDepthMargin: 20,
    listRightMargin: 10,
    listItemContentFont: TTFont.monospacedDigitSystemFont(ofSize: 13, weight: .heavy),
    codeForegroudColor: .brown,
    codeFont: .boldSystemFont(ofSize: 13),
    quoteLeftMargin: 10,
    quoteFont: .boldSystemFont(ofSize: 13),
    quoteForegroudColor: .blue
  )
  
  static var linkSummaryTheme: Theme = Theme(
    textFont: .systemFont(ofSize: 13),
    unorderedBulletFont: .systemFont(ofSize: 20, weight: .bold),
    listLeftMargin: 0,
    listRightMargin: 6,
    paragraphLineSpacing: 2
  )
}



#Preview("test") {
  let source = """
## Overview of Finland\n

Finland has 53 municipalities where a 3 4 5 Finnish is not the sole official language.test12313tet11123

- Finland has 53 municipalities where a 3 4 5 Finnish is not the sole official language.test12313tet11123
  * Finland has 53 municipalities where a 3 4 5 Finnish is not the sole official language.test12313tet11123
> Finland has 53 municipalities where a 3 4 5 Finnish is not the sole official language.test12313tet11123

"""
  VStack {

    MarkdownView(markdown: source)
    .frame(width: 300)

  }
  .frame(maxHeight: .infinity)
//  .background(.red)
}

#Preview("block quote") {
  VStack {
    MarkdownView(markdown: """
pdadsad

> Dorothy followed her through many of the beautiful rooms in her castle.
>
> ddsd

ddadsd


* 1312
- 1331
  * 3123
- kkk
""")
  }
}



#Preview("code") {
  
  VStack {
    
    MarkdownView(markdown: """
inline code : `int a = 10`    
""")
    
    MarkdownView(markdown: """
```swift
int a = 10
int a = 10
```
""")
  }
}

#Preview("order list") {
  VStack {
    MarkdownView(markdown: """
1. First item
1. Second item
1. Third item
1. Fourth item
  2. Intended item
""")
  }
}

#Preview("unorder list") {
  VStack {
    MarkdownView(markdown: """
- unorderlist0
  - unorderlist0.1
  - unorderlist0.2
    - unorderlist0.2.1
- unorderlist1
  - unorderlist1.1
- unorderlist2

""")
  }
}


#Preview("single element") {
  VStack {
    MarkdownView(markdown: "Show an awasome MarkdownUI feature")
        
    /// emphasis
    MarkdownView(markdown: "emphasis : Show an awasome *MarkdownUI feature*")
    
    MarkdownView(markdown: "Show an awasome **MarkdownUI feature**")
        
    MarkdownView(markdown: "Show an awasome ~MarkdownUI feature~")

    
    MarkdownView(markdown: "# Heading 1")
    MarkdownView(markdown: "## Heading 2")
    MarkdownView(markdown: "### Heading 3")
    MarkdownView(markdown: "#### Heading 4")
    MarkdownView(markdown: "##### Heading 5")
    MarkdownView(markdown: "###### Heading 6")
    
    MarkdownView(markdown: "[Duck Duck Go](https://duckduckgo.com)")

    MarkdownView(markdown: "####### Heading 7")

    
  }
}




