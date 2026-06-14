import SwiftUI

struct ContentView: View {
    private let kpnURL = "https://tv.kpn.com"
    private let steps = WatchStep.defaultSteps

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.0, green: 0.13, blue: 0.08),
                    Color(red: 0.0, green: 0.38, blue: 0.18),
                    Color(red: 0.0, green: 0.08, blue: 0.08)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 44) {
                header

                HStack(alignment: .top, spacing: 56) {
                    QRPanel(url: kpnURL)
                        .frame(width: 500)

                    VStack(alignment: .leading, spacing: 22) {
                        Text("Watch KPN TV on this Apple TV")
                            .font(.title2.weight(.semibold))
                            .foregroundStyle(.white)

                        ForEach(steps) { step in
                            WatchStepRow(step: step)
                        }

                        Text("Apple TV does not provide a supported browser or WebKit view for tv.kpn.com. This app keeps the flow native and sends playback to Apple TV through AirPlay, so KPN login, channel availability, subscriptions, and DRM stay with KPN.")
                            .font(.callout)
                            .foregroundStyle(.white.opacity(0.72))
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 8)
                    }
                }

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 88)
            .padding(.vertical, 64)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("KPN TV for Apple TV")
                .font(.system(size: 64, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            Text("Open tv.kpn.com on a supported device, choose a channel, then AirPlay it to this Apple TV.")
                .font(.title3)
                .foregroundStyle(.white.opacity(0.82))
        }
    }
}

private struct QRPanel: View {
    let url: String

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            VStack(alignment: .leading, spacing: 10) {
                Label("Scan to open", systemImage: "qrcode.viewfinder")
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.78))

                Text(url)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.white)
            }

            QRCodeView(text: url)
                .frame(width: 340, height: 340)
                .padding(34)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 34, style: .continuous))
                .shadow(color: .black.opacity(0.35), radius: 28, x: 0, y: 18)

            Text("Use your phone, tablet, or computer to scan the code. Log in with your KPN ID or subscription details when KPN asks.")
                .font(.body)
                .foregroundStyle(.white.opacity(0.76))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(36)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 42, style: .continuous))
    }
}

private struct WatchStepRow: View {
    let step: WatchStep

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(systemName: step.symbolName)
                .font(.title2.weight(.semibold))
                .foregroundStyle(.white)
                .frame(width: 54, height: 54)
                .background(Color.white.opacity(0.16))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

            VStack(alignment: .leading, spacing: 5) {
                Text(step.title)
                    .font(.headline)
                    .foregroundStyle(.white)

                Text(step.detail)
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.74))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(20)
        .background(Color.white.opacity(0.10))
        .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
    }
}

private struct WatchStep: Identifiable {
    let id: Int
    let title: String
    let detail: String
    let symbolName: String

    static let defaultSteps = [
        WatchStep(
            id: 1,
            title: "Open KPN TV",
            detail: "Visit tv.kpn.com in a supported browser and sign in to your KPN TV account.",
            symbolName: "safari"
        ),
        WatchStep(
            id: 2,
            title: "Choose a live channel",
            detail: "Start the live TV channel or programme you want to watch from KPN.",
            symbolName: "play.tv"
        ),
        WatchStep(
            id: 3,
            title: "Send it to Apple TV",
            detail: "Tap AirPlay or screen mirroring and select this Apple TV from the device list.",
            symbolName: "airplayvideo"
        )
    ]
}

#Preview {
    ContentView()
}
