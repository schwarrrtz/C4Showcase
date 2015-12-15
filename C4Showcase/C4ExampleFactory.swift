// Copyright © 2015 C4
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions: The above copyright
// notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

import Foundation
import UIKit
import C4

class C4Example {
    
    var className: String
    var thumbnail: UIImage?
    
    init(className: String) {
        self.className = className
    }
}

class C4ExampleSection {
    
    var sectionName: String
    var examples: [C4Example]
    
    init(name: String, examples: [C4Example]) {
        self.sectionName = name
        self.examples = examples
    }
}

class C4ExampleFactory {
    
    class func numberOfSections() -> Int {
        return sectionList.count
    }
    
    class func sectionAtIndex(index: Int) -> C4ExampleSection {
        return sectionList[index]
    }
    
    class func numberOfExamples(section: Int) -> Int {
        return sectionList[section].examples.count
    }
    
    class func exampleForIndexPath(indexPath: NSIndexPath) -> C4Example {
        return sectionList[indexPath.section].examples[indexPath.row]
    }
    
    class func createController(section: Int, row: Int) -> C4CanvasController? {
        let example = sectionList[section].examples[row]
        if let controllerClass = NSClassFromString("C4Showcase." + example.className) as? C4CanvasController.Type {
            return controllerClass.init()
        }
        return nil
    }
    
    static let sectionList: [C4ExampleSection] = [C4ExampleSection(name: "Views", examples: [C4Example(className: "Views01"),
                                                                                             C4Example(className: "Views02"),
                                                                                             C4Example(className: "Views04"),
                                                                                             C4Example(className: "Views05"),
                                                                                             C4Example(className: "Views09")]),
        
                                                  C4ExampleSection(name: "Shapes", examples: [C4Example(className: "Shapes01"),
                                                                                              C4Example(className: "Shapes04"),
                                                                                              C4Example(className: "Shapes06"),
                                                                                              C4Example(className: "Shapes08"),
                                                                                              C4Example(className: "Shapes09"),
                                                                                              C4Example(className: "Shapes12")])]
}