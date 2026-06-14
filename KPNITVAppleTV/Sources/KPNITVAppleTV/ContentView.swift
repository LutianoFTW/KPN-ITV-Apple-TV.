import SwiftUI

struct ContentView: View {
    let destination: KPNDestination

    @State private var selectedTopic: GuideTopic = .start

    var body: some View {
        ZStack {
            AppBackground()

            VStack(alignment: .leading, spacing: 48) {
                HeaderView(destination: destination)

                HStack(alignment: .top, spacing: 44) {
                    TopicSidebar(selection: $selectedTopic)

                    GuidePanel(topic: selectedTopic)

                    QRPanel(destination: destination)
                }
            }
            .padding(.horizontal, 86)
            .padding(.vertical, 62)
        }
        .preferredColorScheme(.dark)
    }
}

private struct AppBackground: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color(red: 0.0, green: 0.38, blue: 0.26),
                Color(red: 0.02, green: 0.10, blue: 0.13),
                Color.black
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        .overlay(alignment: .topTrailing) {
            Circle()
                .fill(Color.green.opacity(0.18))
                .frame(width: 620, height: 620)
                .blur(radius: 90)
                .offset(x: 140, y: -220)
        }
    }
}

private struct HeaderView: View {
    let destination: KPNDestination

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("KPN ITV for Apple TV")
                .font(.system(size: 58, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            Text("Watch KPN live channels from \(destination.displayURL) on your television using KPN's official web player and AirPlay.")
                .font(.title2.weight(.medium))
                .foregroundStyle(.white.opacity(0.78))
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: 1180, alignment: .leading)
    }
}

private struct TopicSidebar: View {
    @Binding var selection: GuideTopic

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            ForEach(GuideTopic.allCases) { topic in
                Button {
                    selection = topic
                } label: {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(topic.title)
                            .font(.title3.weight(.bold))
                        Text(topic.subtitle)
                            .font(.callout.weight(.medium))
                            .foregroundStyle(.white.opacity(0.72))
                            .lineLimit(2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(22)
                    .background(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .fill(selection == topic ? Color.green.opacity(0.48) : Color.white.opacity(0.10))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .stroke(selection == topic ? Color.green.opacity(0.9) : Color.white.opacity(0.14), lineWidth: 2)
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .frame(width: 360)
    }
}

private struct GuidePanel: View {
    let topic: GuideTopic

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            VStack(alignment: .leading, spacing: 10) {
                Text(topic.title)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text(topic.subtitle)
                    .font(.title3.weight(.medium))
                    .foregroundStyle(.white.opacity(0.74))
            }

            VStack(alignment: .leading, spacing: 20) {
                ForEach(Array(topic.steps.enumerated()), id: \.offset) { index, step in
                    StepRow(number: index + 1, text: step)
                }
            }

            NoticeCard()
        }
        .padding(34)
        .frame(width: 610, minHeight: 570, alignment: .topLeading)
        .background(Color.white.opacity(0.10))
        .clipShape(RoundedRectangle(cornerRadius: 34, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 34, style: .continuous)
                .stroke(Color.white.opacity(0.16), lineWidth: 1)
        )
    }
}

private struct StepRow: View {
    let number: Int
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 18) {
            Text("\(number)")
                .font(.headline.weight(.bold))
                .foregroundStyle(.black)
                .frame(width: 38, height: 38)
                .background(Color.green)
                .clipShape(Circle())

            Text(text)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

private struct NoticeCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Why AirPlay?")
                .font(.headline.weight(.bold))
                .foregroundStyle(.white)

            Text("Apple TV does not include a public web browser for tv.kpn.com, and KPN's protected streams must stay inside KPN's official player.")
                .font(.callout.weight(.medium))
                .foregroundStyle(.white.opacity(0.72))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(18)
        .background(Color.black.opacity(0.28))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

private struct QRPanel: View {
    let destination: KPNDestination

    var body: some View {
        VStack(spacing: 24) {
            QRCodeView(payload: destination.url.absoluteString, caption: destination.displayURL)

            VStack(spacing: 10) {
                Text("Scan to open KPN TV")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(.white)

                Text("Use your KPN subscription on the official website, then select AirPlay to watch on this Apple TV.")
                    .font(.body.weight(.medium))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white.opacity(0.72))
            }
        }
        .padding(32)
        .frame(width: 360, minHeight: 570)
        .background(Color.white.opacity(0.10))
        .clipShape(RoundedRectangle(cornerRadius: 34, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 34, style: .continuous)
                .stroke(Color.white.opacity(0.16), lineWidth: 1)
        )
    }
}
