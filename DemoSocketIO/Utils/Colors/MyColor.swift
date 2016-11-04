//
//  MyColor.swift
//  DemoSocketIO
//
//  Created by Loc.dx-KeizuDev on 11/3/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 08) / 255.0
        let b = CGFloat((hex & 0x0000FF) >> 00) / 255.0
        self.init(red:r, green:g, blue:b, alpha:alpha)
    }
    
    class func crayons_cantaloupeColor (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0xFFCC66, alpha: alpha) }
    class func crayons_honeydewColor   (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0xCCFF66, alpha: alpha) }
    class func crayons_spindriftColor  (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x66FFCC, alpha: alpha) }
    class func crayons_skyColor        (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x66CCFF, alpha: alpha) }
    class func crayons_lavenderColor   (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0xCC66FF, alpha: alpha) }
    class func crayons_carnationColor  (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0xFF6FCF, alpha: alpha) }
    class func crayons_licoriceColor   (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x000000, alpha: alpha) }
    class func crayons_snowColor       (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0xFFFFFF, alpha: alpha) }
    class func crayons_salmonColor     (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0xFF6666, alpha: alpha) }
    class func crayons_bananaColor     (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0xFFFF66, alpha: alpha) }
    class func crayons_floraColor      (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x66FF66, alpha: alpha) }
    class func crayons_iceColor        (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x66FFFF, alpha: alpha) }
    class func crayons_orchidColor     (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x6666FF, alpha: alpha) }
    class func crayons_bubblegumColor  (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0xff66ff, alpha: alpha) }
    class func crayons_leadColor       (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x191919, alpha: alpha) }
    class func crayons_mercuryColor    (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0xe6e6e6, alpha: alpha) }
    class func crayons_tangerineColor  (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0xff8000, alpha: alpha) }
    class func crayons_limeColor       (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x80ff00, alpha: alpha) }
    class func crayons_seaFoamColor    (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x00ff80, alpha: alpha) }
    class func crayons_aquaColor       (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x0080ff, alpha: alpha) }
    class func crayons_grapeColor      (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x8000ff, alpha: alpha) }
    class func crayons_strawberryColor (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0xff0080, alpha: alpha) }
    class func crayons_tungstenColor   (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x333333, alpha: alpha) }
    class func crayons_silverColor     (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0xcccccc, alpha: alpha) }
    class func crayons_maraschinoColor (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0xff0000, alpha: alpha) }
    class func crayons_lemonColor      (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0xffff00, alpha: alpha) }
    class func crayons_springColor     (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x00ff00, alpha: alpha) }
    class func crayons_turquoiseColor  (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x00ffff, alpha: alpha) }
    class func crayons_blueberryColor  (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x0000ff, alpha: alpha) }
    class func crayons_magentaColor    (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0xff00ff, alpha: alpha) }
    class func crayons_ironColor       (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x4c4c4c, alpha: alpha) }
    class func crayons_magnesiumColor  (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0xb3b3b3, alpha: alpha) }
    class func crayons_mochaColor      (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x804000, alpha: alpha) }
    class func crayons_fernColor       (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x408000, alpha: alpha) }
    class func crayons_mossColor       (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x008040, alpha: alpha) }
    class func crayons_oceanColor      (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x004080, alpha: alpha) }
    class func crayons_eggplantColor   (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x400080, alpha: alpha) }
    class func crayons_maroonColor     (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x800040, alpha: alpha) }
    class func crayons_steelColor      (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x666666, alpha: alpha) }
    class func crayons_aluminumColor   (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x999999, alpha: alpha) }
    class func crayons_cayenneColor    (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x800000, alpha: alpha) }
    class func crayons_asparagusColor  (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x808000, alpha: alpha) }
    class func crayons_cloverColor     (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x008000, alpha: alpha) }
    class func crayons_tealColor       (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x008080, alpha: alpha) }
    class func crayons_midnightColor   (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x000080, alpha: alpha) }
    class func crayons_plumColor       (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x800080, alpha: alpha) }
    class func crayons_tinColor        (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x7f7f7f, alpha: alpha) }
    class func crayons_nickelColor     (alpha: CGFloat = 1.0) -> UIColor { return UIColor(hex: 0x808080, alpha: alpha) }
}
