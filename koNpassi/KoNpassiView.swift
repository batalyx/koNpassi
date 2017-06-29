//
//  KoNpassiView.swift
//  koNpassi
//
//  Created by Jonne Itkonen on 9.6.2017.
//
//

import UIKit

class KoNpassiView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        let midX = self.bounds.midX
        let midY = self.bounds.midY
        let length = min(self.bounds.height, self.bounds.width)
        let b = UIBezierPath()
        b.move(to: CGPoint(x: midX, y: midY - 0.5 * length))
        b.addLine(to: CGPoint(x: midX, y: midY + 0.5 * length))
        b.addLine(to: CGPoint(x: midX + 0.15 * length, y: midY + 0.2 * length))
        b.stroke()
//        let r = CGAffineTransform(rotationAngle: 0.707)
//        self.transform = r
    }

}
