import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI
import UIKit

struct QRCodeView: View {
    let payload: String
    let caption: String

    var body: some View {
        VStack(spacing: 18) {
            Group {
                if let image = QRCodeGenerator.makeImage(from: payload) {
                    Image(uiImage: image)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .accessibilityLabel("QR code for \(caption)")
                } else {
                    Text(caption)
                        .font(.headline)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            .frame(width: 250, height: 250)
            .padding(26)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))

            Text(caption)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white)
        }
        .accessibilityElement(children: .combine)
    }
}

private enum QRCodeGenerator {
    private static let context = CIContext()

    static func makeImage(from text: String) -> UIImage? {
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(text.utf8)
        filter.correctionLevel = "M"

        guard let outputImage = filter.outputImage else {
            return nil
        }

        let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: 12, y: 12))

        guard let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) else {
            return nil
        }

        return UIImage(cgImage: cgImage)
    }
}
