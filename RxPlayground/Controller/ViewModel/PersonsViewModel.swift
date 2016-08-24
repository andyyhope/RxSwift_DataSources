//
//  PersonsViewModel.swift
//  RxPlayground
//
//  Created by Andyy Hope on 24/08/2016.
//  Copyright © 2016 Andyy Hope. All rights reserved.
//

import Foundation
import RxSwift

struct PersonsViewModel {
    var persons: Variable<[Person]>
    
    init() {
        self.persons = Variable([])
    }
    
    func requestTest(delay delay: Int) {
        PersonsRequester.testPersons(delay: delay) {
            guard case .success(let persons) = $0 else { return }
            
            self.persons.value = persons
        }
    }
}