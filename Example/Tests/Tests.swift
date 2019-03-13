// https://github.com/Quick/Quick

import Quick
import Nimble
import SygicUIKit

class MockColorPallette: SYUIColorPalette {
    
}

class SYUIColorSchemeManagerTests: QuickSpec {
    override func spec() {
        
        describe("Color scheme tests") {

            beforeEach {
                SYUIColorSchemeManager.shared.currentColorScheme = .day
                SYUIColorSchemeManager.shared.setDefaultColorPalettes()
            }
            
            context("default values") {
                it("scheme") {
                    expect(SYUIColorSchemeManager.shared.currentColorScheme) == .day
                }
                
                it("pallette") {
                    expect(SYUIColorSchemeManager.shared.currentColorPalette is SYUIDefaultColorPalette) == true
                }
                
                it("shouldnt be night") {
                    expect(SYUIColorSchemeManager.shared.isNight) == false
                }
            }
            
            context("updated scheme") {
                it("should switch to night") {
                    SYUIColorSchemeManager.shared.currentColorScheme = .night
                    
                    expect(SYUIColorSchemeManager.shared.isNight) == true
                    expect(SYUIColorSchemeManager.shared.currentColorPalette is SYUINightColorPalette) == true
                }
            }
            
            context("updated pallette") {
                it("should switch pallette") {
                    SYUIColorSchemeManager.shared.setColorPalettes(dayColorPalette: MockColorPallette())
                    
                    expect(SYUIColorSchemeManager.shared.isNight) == false
                    expect(SYUIColorSchemeManager.shared.currentColorPalette is MockColorPallette) == true
                }
            }
        }
    }
}
