//
//  Charts+Square.swift
//  weather_proj
//
//  Created by Chan on 2/28/24.
//

import SwiftUI
import Charts

struct Square: ChartSymbolShape, InsettableShape {
    let inset: CGFloat
    
    init(inset: CGFloat = 0) {
        self.inset = inset
    }
    
    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 1
        let minDimension = min(rect.width, rect.height)
        return Path(
            roundedRect: .init(x: rect.midX - minDimension / 2, y: rect.midY - minDimension / 2, width: minDimension, height: minDimension),
            cornerRadius: cornerRadius
        )
    }
    
    func inset(by amount: CGFloat) -> Square {
        Square(inset: inset + amount)
    }
    
    var perceptualUnitRect: CGRect {
        let scaleAdjustment: CGFloat = 0.75
        return CGRect(x: 0.5 - scaleAdjustment / 2, y: 0.5 - scaleAdjustment / 2, width: scaleAdjustment, height: scaleAdjustment)
    }
}
