// Copyright (c) 2014-present, Facebook, Inc. All rights reserved.
//
// You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
// copy, modify, and distribute this software in source code or binary form for use
// in connection with the web services and APIs provided by Facebook.
//
// As with any software that integrates with the Facebook platform, your use of
// this software is subject to the Facebook Developer Principles and Policies
// [http://developers.facebook.com/policy/]. This copyright notice shall be
// included in all copies or substantial portions of the software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import XCTest

class DrawableTests: XCTestCase {
  let size = CGSize(width: 100, height: 100)
  let placeholderImageColor = UIColor( // swiftlint:disable:this object_literal
    red: 157.0 / 255.0,
    green: 177.0 / 255.0,
    blue: 204.0 / 255.0,
    alpha: 1.0
  )

  func testBaseClassPathWithSize() {
    XCTAssertNil(Icon().path(with: size))
  }

  func testDefaultScale() {
    XCTAssertEqual(
      HumanSilhouetteIcon().image(size: size)?.scale,
      UIScreen.main.scale,
      "Icons should default their scale to the scale of the main screen"
    )
  }

  func testDefaultScaleWithColor() {
    XCTAssertEqual(
      HumanSilhouetteIcon().image(size: size, color: .red)?.scale,
      UIScreen.main.scale,
      "Scale should not be affected by the color"
    )
  }

  func testCustomScale() {
    XCTAssertEqual(
      HumanSilhouetteIcon().image(
        size: size,
        scale: 2.0
      )?.scale,
      2.0,
      "Icons should accept a custom scale"
    )
  }

  func testSystemColor() throws {
    let potentialImage = HumanSilhouetteIcon().image(
      size: size,
      scale: 2.0,
      color: .red
    )

    guard let image = potentialImage else {
      return XCTFail("Should be able to create an image with a valid size")
    }

    let redIcon = UIImage(
      named: "redSilhouette.png",
      in: Bundle(for: DrawableTests.self),
      compatibleWith: nil
    )

    XCTAssertEqual(
      image.pngData(),
      redIcon?.pngData(),
      "Should create the expected image for the size and color"
    )
  }

  // MARK: Human Silhouette Icon

  func testImageWithInvalidSize() {
    XCTAssertNil(HumanSilhouetteIcon().image(size: .zero), "An image must have a non-zero size")
  }

  func testPlaceholderImageColor() {
    let potentialImage = HumanSilhouetteIcon().image(
      size: size,
      scale: 2.0,
      color: placeholderImageColor
    )
    let customIcon = UIImage(
      named: "customColorSilhouette.png",
      in: Bundle(for: DrawableTests.self),
      compatibleWith: nil
    )

    guard let image = potentialImage else {
      return XCTFail("Should be able to create an image with a valid size")
    }

    XCTAssertEqual(
      image.pngData(),
      customIcon?.pngData(),
      "Should create the expected image for the size and color"
    )
  }

  // MARK: Logo Icon

  func testLogo() {
    let potentialImage = FBLogo().image(
      size: size,
      scale: 2.0,
      color: .red
    )
    let storedImage = UIImage(
      named: "redLogo.png",
      in: Bundle(for: DrawableTests.self),
      compatibleWith: nil
    )

    guard let image = potentialImage else {
      return XCTFail("Should be able to create an image with a valid size")
    }

    XCTAssertEqual(
      image.pngData(),
      storedImage?.pngData(),
      "Should create the expected image"
    )
  }

  // MARK: Close Icon

  func testCloseIcon() {
    guard let image = FBCloseIcon().image(
      with: size,
      primaryColor: .red,
      secondaryColor: .green,
      scale: 2.0
    ) else {
      return XCTFail("Should be able to create an image with a valid size")
    }

    let storedImage = UIImage(
      named: "closeIcon.png",
      in: Bundle(for: DrawableTests.self),
      compatibleWith: nil
    )

    XCTAssertEqual(
      image.pngData(),
      storedImage?.pngData(),
      "Should create the expected image"
    )
  }
}
