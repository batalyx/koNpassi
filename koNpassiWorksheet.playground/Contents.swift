//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import CoreGraphics

var needle = UIBezierPath()
let ox=40
let oy=40
needle.move(to: CGPoint(x:ox+0, y:oy+0))
needle.addLine(to: CGPoint(x: ox-2, y: oy+0))
needle.addLine(to: CGPoint(x: ox+0, y: oy+20))
needle.addLine(to: CGPoint(x: ox+0, y: oy-20))
needle.addLine(to: CGPoint(x: ox+2, y: oy+0))
needle.addLine(to: CGPoint(x: ox+0, y: oy+0))
needle.close()

let r = UIGraphicsImageRenderer(size: CGSize(width:40, height:40))
let arrow = r.image { _ in
    let con = UIGraphicsGetCurrentContext()
    con?.move(to: CGPoint(x:0, y:0))
    con?.addLine(to: CGPoint(x:0, y:10))
    con?.addLine(to: CGPoint(x:4, y:8))
    con?.addLine(to: CGPoint(x:-8, y:0))
//    con?.addLine(to: CGPoint(x:0, y:10))
//    con?.closePath()
    con?.strokePath()
}

var str = "Hello, playground"

class Viewi : UIView {
    override func draw(_ rect: CGRect) {
        let cx = UIGraphicsGetCurrentContext()
        arrow.draw(at: CGPoint(x:20, y:20))
        //cx?.rotate(by: 0.707)
        cx?.addPath(needle.cgPath)
        needle.stroke()
        cx?.rotate(by:0.707)
    }
}

class ViewC  : UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.preferredContentSize = CGSize(width: 80, height: 80)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = Viewi(
            frame: CGRect(x: 0, y: 0,
                          width: 80, height: 80))
        view.backgroundColor = .cyan

        let v1 = UIView(frame:CGRect(x: 11, y: 13, width: 20, height: 20))
        v1.backgroundColor = UIColor.orange
        view.addSubview(v1)
        v1.bounds
        self.view = view
    }
}

var v = ViewC()
PlaygroundPage.current.liveView = v
//PlaygroundPage.current.liveView = Viewi(frame:CGRect(x:0, y:0, width:30, height: 30))
//(PlaygroundPage.current.liveView as! UIView).backgroundColor = .orange
