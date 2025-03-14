//
//  File.swift
//  testLatex2
//
//  Created by chh on 2025/3/13.
//

import SwiftUI
import LaTeXSwiftUI

// SwiftUI 视图
struct MySwiftUIView: View {
    var body: some View {
        LaTeX("Hello, $\\LaTeX$!")
        LaTeX("The quadratic formula is $$x=\\frac{-b\\pm\\sqrt{b^2-4ac}}{2a}$$ of $f(x)=ax^2+bx+c$.").foregroundColor(.red)
        LaTeX("皮尔逊相似度是一种用于衡量两个变量之间线性相关程度的统计方法。其公式为：\n\n\\[ r = \\frac{\\sum{(x_i - \\bar{x})(y_i - \\bar{y})}}{\\sqrt{\\sum{(x_i - \\bar{x})^2} \\cdot \\sum{(y_i - \\bar{y})^2}}} \\]\n\n其中：\n- $ x_i $ 和 $ y_i $ 分别是两个变量的观测值。\n- $ \\bar{x} $ 和 $ \\bar{y} $ 分别是两个变量的平均值。\n- $ r $ 的取值范围为 -1 到 1，值越接近 1 表示正相关性越强，越接近 -1 表示负相关性越强，接近 0 表示无线性相关。\n\n皮尔逊相似度常用于统计分析、机器学习和数据挖掘中，以评估变量之间的线性关系。")
        LaTeX("\\[   4\\text{Fe} + 3\\text{O}_2 \\rightarrow 2\\text{Fe}_2\\text{O}_3 \\]")
        LaTeX("\\[ g = \\frac{G \\cdot M}{R^2} \\]\n\n")
    }
}

// 包装为 UIKit 组件
@objc class SwiftUIWrapper: NSObject {
    @objc static func createHostingController() -> UIViewController {
        return UIHostingController(rootView: MySwiftUIView())
    }
}

