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

import UIKit

class C4ExampleViewController : UIViewController {
    
    @IBOutlet var canvasContainer: UIView!
    @IBOutlet var codeContainer: UIView!
    @IBOutlet var webView: UIWebView!
    
    var canvasController: UIViewController!
    var codeViewHeightConstraint: NSLayoutConstraint!
    var codeViewIsVisible: Bool = false
    
    class func create(canvas: UIViewController) -> C4ExampleViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let example = storyboard.instantiateViewControllerWithIdentifier("C4ExampleViewController") as! C4ExampleViewController
        example.canvasController = canvas
        return example
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        
        // configure subviews & child controller
        self.addChildViewController(canvasController)
        canvasController.didMoveToParentViewController(self)
        
        canvasController.view.frame = canvasContainer.bounds
        canvasController.viewWillAppear(false)
        self.canvasContainer.add(canvasController.view)
        canvasController.viewDidAppear(false)
        
        // store height constraint of webview for use in animation
        for constraint: NSLayoutConstraint in codeContainer.constraints {
            if constraint.firstAttribute == .Height {
                codeViewHeightConstraint = constraint
            }
        }
        
        // webview should be hidden initially
        codeViewHeightConstraint.constant = 0
        
        // load html
        let url = NSBundle.mainBundle().URLForResource("basic", withExtension: "html")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    @IBAction func viewCodeButtonClicked(sender: UIBarButtonItem) {
        
        UIView.animateWithDuration(0.2) {
            if self.codeViewIsVisible {
                self.codeViewHeightConstraint.constant = 0
            }
            else {
                self.codeViewHeightConstraint.constant = self.canvasContainer.frame.size.height
            }
            
            self.view.layoutIfNeeded()
        }
        
        codeViewIsVisible = !codeViewIsVisible
        sender.title = codeViewIsVisible ? "Hide Code" : "View Code"
    }
}
