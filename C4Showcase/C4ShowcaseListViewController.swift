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

class C4ShowcaseListViewController : UIViewController {
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

extension C4ShowcaseListViewController : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return C4ExampleFactory.numberOfSections()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return C4ExampleFactory.numberOfExamples(section)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("C4ShowcaseCell", forIndexPath: indexPath)
        
        if let cell = cell as? C4ShowcaseCell {
            
            cell.titleLabel?.text = "\(indexPath.row)"
        }

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "C4ShowcaseHeader", forIndexPath: indexPath)
            if let view = view as? C4ShowcaseHeader {
                view.label?.text = C4ExampleFactory.sectionAtIndex(indexPath.section).sectionName
            }
            return view
            
        default:
            assert(false, "unsupported supplementary view type")
        }
        
    }
}

extension C4ShowcaseListViewController : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let canvasController = C4ExampleFactory.createController(indexPath.section, row: indexPath.row) as UIViewController!
        let sectionName = C4ExampleFactory.sectionAtIndex(indexPath.section).sectionName
        canvasController.navigationItem.title = "\(sectionName) \(indexPath.row)"
        self.navigationController?.pushViewController(canvasController, animated: true)
    }
}