// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import SwiftEntryKit

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        attributesCreation()
    }
    
    private func attributesCreation() {
        
        describe("EKAttributes creation") {
            
            describe("top toast") {
                var attributes: EKAttributes!
                beforeEach {
                    attributes = EKAttributes()
                    attributes.displayDuration = .infinity
                    attributes.roundCorners = .all(radius: 10)
                    attributes.position = .top
                    attributes.statusBarStyle = .default
                }
                
                it("displays for infinate time") {
                    expect(attributes.displayDuration).to(equal(.infinity))
                }
            }
        }
    }
}
