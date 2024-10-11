//
//  ContentView.swift
//  ExampleProject-macOS
//
//  Created by dcl on 10/11/24.
//

import SwiftUI
import Markdownosaur


struct ContentView: View {
  
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
          
          
          MarkdownView(markdown: "123")
        }
        .padding()
    }
}



#Preview("unorder list") {
  MarkdownView(markdown: """
- 1.1
  - 1.1.1
  - 1.1.2
  - 1.1.3
- 2.1
""")
  .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
}


#Preview {
    ContentView()
}
//    LinearGradient(colors: [.red, .black], startPoint: .leading, endPoint: .trailing)
//      .frame(height: 200)
//      .mask {
//            MarkdownView(markdown: """
//        - 1.1
//          - 1.1.1
//          - 1.1.2
//          - 1.1.3
//        - 2.1
//        """)
//      }
//      .textSelection(.enabled)

#Preview ("gridient-view") {

  VStack {
    MarkdownView(markdown: """
- 1.1
  - 1.1.1
  - 1.1.2
  - 1.1.3
- 2.1
""")
//    .mask {
//      LinearGradient(colors: [.red, .green], startPoint: .leading, endPoint: .trailing)
//    }
    .background(.red)
    
    Text("3123")
  }
}
