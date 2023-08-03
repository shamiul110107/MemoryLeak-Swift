//
//  SecondVC.swift
//  MemoryLeakTest
//
//  Created by Md. Shamiul Islam on 28/9/22.
//

import Foundation
import UIKit

class ViewModel {
    var handler: (() -> Void)?
}

class SecondVc: UIViewController {
    let viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // memoryLeak() this function will create a memory leak. If you click on
        //memoryLeak()
        /// enable tthis line to test no memory leak occur
        //noMemoryLeak()
        
    }
    
    private func memoryLeak() {
        viewModel.handler = {
            self.catchAllError(completion: { _, _ in
                
            })
        }
        viewModel.handler?()
    }
    
    private func noMemoryLeak() {
        viewModel.handler = { [weak self] in
            guard let self = self else {return}
            self.catchAllError(completion: { _, _ in
                
            })
        }
        viewModel.handler?()
    }
    
    deinit {
        print("SecondVc deallocated")
    }
    
    func catchAllError(completion: @escaping (Data?, Error?) -> Void) {
        completion(nil, NSError(domain: "No domain", code: 500))
    }
}
