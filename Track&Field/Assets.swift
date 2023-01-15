// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let _22968457 = ImageAsset(name: "22968457")
  internal static let _22968459 = ImageAsset(name: "22968459")
  internal static let camera = ImageAsset(name: "Camera")
  internal static let bgColor = ColorAsset(name: "bgColor")
  internal static let clearColor = ColorAsset(name: "clearColor")
  internal static let lineColor = ColorAsset(name: "lineColor")
  internal static let mainColor = ColorAsset(name: "mainColor")
  internal static let painColor = ColorAsset(name: "painColor")
  internal static let subRedColor = ColorAsset(name: "subRedColor")
  internal static let whiteColor = ColorAsset(name: "whiteColor")
  internal static let commentP = ImageAsset(name: "Comment_p")
  internal static let commentWhite = ImageAsset(name: "Comment_white")
  internal static let ex1 = ImageAsset(name: "Ex1")
  internal static let ex2 = ImageAsset(name: "Ex2")
  internal static let ex3 = ImageAsset(name: "Ex3")
  internal static let ex4 = ImageAsset(name: "Ex4")
  internal static let ex5 = ImageAsset(name: "Ex5")
  internal static let ex6 = ImageAsset(name: "Ex6")
  internal static let ex7 = ImageAsset(name: "Ex7")
  internal static let ex8 = ImageAsset(name: "Ex8")
  internal static let iconCurbed = ImageAsset(name: "Icon_curbed")
  internal static let iconShadow = ImageAsset(name: "Icon_shadow")
  internal static let rectangle139 = ImageAsset(name: "Rectangle 139")
  internal static let rectangle140 = ImageAsset(name: "Rectangle 140")
  internal static let settingPouple = ImageAsset(name: "Setting_Pouple")
  internal static let settingRed = ImageAsset(name: "Setting_Red")
  internal static let writing = ImageAsset(name: "Writing")
  internal static let analizeNotselected = ImageAsset(name: "analize_notselected")
  internal static let analizeSelected = ImageAsset(name: "analize_selected")
  internal static let backMark = ImageAsset(name: "backMark")
  internal static let box6 = ImageAsset(name: "box6")
  internal static let cloudyDesign = ImageAsset(name: "cloudy_design")
  internal static let coachPicture = ImageAsset(name: "coach_picture")
  internal static let frontMark = ImageAsset(name: "frontMark")
  internal static let historyNotselected = ImageAsset(name: "history_notselected")
  internal static let historySelected = ImageAsset(name: "history_selected")
  internal static let legBack = ImageAsset(name: "leg_back")
  internal static let legFront = ImageAsset(name: "leg_front")
  internal static let noshaPain = ImageAsset(name: "nosha_pain")
  internal static let noshaPain2 = ImageAsset(name: "nosha_pain2")
  internal static let noshaSyosai = ImageAsset(name: "nosha_syosai")
  internal static let pDown = ImageAsset(name: "p_down")
  internal static let pFrom = ImageAsset(name: "p_from")
  internal static let pLine = ImageAsset(name: "p_line_")
  internal static let pLineBold = ImageAsset(name: "p_line_bold")
  internal static let pLineLight = ImageAsset(name: "p_line_light")
  internal static let pMulti = ImageAsset(name: "p_multi")
  internal static let pNonpushedS = ImageAsset(name: "p_nonpushed_s")
  internal static let pPlus = ImageAsset(name: "p_plus")
  internal static let pPushedLong = ImageAsset(name: "p_pushed_long")
  internal static let pPushedM = ImageAsset(name: "p_pushed_m")
  internal static let pPushedS = ImageAsset(name: "p_pushed_s")
  internal static let pRectangleCurbedEx = ImageAsset(name: "p_rectangle_curbed_Ex")
  internal static let pRectangleCurbedL = ImageAsset(name: "p_rectangle_curbed_L")
  internal static let pRectangleCurbedM = ImageAsset(name: "p_rectangle_curbed_M")
  internal static let pRectangleCurbedS = ImageAsset(name: "p_rectangle_curbed_S")
  internal static let pRectangleDetailExD = ImageAsset(name: "p_rectangle_detail_Ex_D")
  internal static let pRectangleDetailExL = ImageAsset(name: "p_rectangle_detail_Ex_L")
  internal static let pRectangleDetailLL108 = ImageAsset(name: "p_rectangle_detail_LL 108")
  internal static let pRectangleDetailLD = ImageAsset(name: "p_rectangle_detail_L_D")
  internal static let pRectangleDetailLL = ImageAsset(name: "p_rectangle_detail_L_L")
  internal static let pRectangleDetailMD = ImageAsset(name: "p_rectangle_detail_M_D")
  internal static let pRectangleDetailSD = ImageAsset(name: "p_rectangle_detail_S_D")
  internal static let pRectangleInshow = ImageAsset(name: "p_rectangle_inshow")
  internal static let pRectangleListD = ImageAsset(name: "p_rectangle_list_D")
  internal static let pRectangleNosha1 = ImageAsset(name: "p_rectangle_nosha-1")
  internal static let pRectangleNosha2 = ImageAsset(name: "p_rectangle_nosha-2")
  internal static let pRectangleNosha3 = ImageAsset(name: "p_rectangle_nosha-3")
  internal static let pRectangleNosha = ImageAsset(name: "p_rectangle_nosha")
  internal static let pRectangleSlider = ImageAsset(name: "p_rectangle_slider")
  internal static let pSetting = ImageAsset(name: "p_setting")
  internal static let painHeavy = ImageAsset(name: "pain_heavy")
  internal static let painLight = ImageAsset(name: "pain_light")
  internal static let playerPicture = ImageAsset(name: "player_picture")
  internal static let playerSmall = ImageAsset(name: "player_small")
  internal static let popupAna = ImageAsset(name: "popup_Ana")
  internal static let rLineLight = ImageAsset(name: "r_line_light")
  internal static let rainDesign = ImageAsset(name: "rain_design")
  internal static let rankingNotselected = ImageAsset(name: "ranking_notselected")
  internal static let rankingSelected = ImageAsset(name: "ranking_selected")
  internal static let recordNotselected = ImageAsset(name: "record_notselected")
  internal static let recordSelected = ImageAsset(name: "record_selected")
  internal static let sanderGesign = ImageAsset(name: "sander_gesign")
  internal static let snowDesign = ImageAsset(name: "snow_design")
  internal static let sunDesign = ImageAsset(name: "sun_design")
  internal static let wPushedL = ImageAsset(name: "w_pushed_l")
  internal static let wPushedLong = ImageAsset(name: "w_pushed_long")
  internal static let wPushedM = ImageAsset(name: "w_pushed_m")
  internal static let wPushedMaru = ImageAsset(name: "w_pushed_maru")
  internal static let wRectangleCurbedNoLine = ImageAsset(name: "w_rectangle-curbed_NoLine")
  internal static let wRectangle = ImageAsset(name: "w_rectangle")
  internal static let wRectangleCurbedD = ImageAsset(name: "w_rectangle_curbed_D")
  internal static let wRectangleCurbedL = ImageAsset(name: "w_rectangle_curbed_L")
  internal static let wRectangleCurbedShadow = ImageAsset(name: "w_rectangle_curbed_Shadow")
  internal static let wRectangleCurbshadow = ImageAsset(name: "w_rectangle_curbshadow")
  internal static let whitePrefectRectangle = ImageAsset(name: "white_prefect_rectangle")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
