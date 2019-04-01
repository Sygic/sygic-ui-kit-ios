//// Tests.swift
//
// Copyright (c) 2019 Sygic a.s.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
