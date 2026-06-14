import Foundation

struct KPNDestination: Equatable {
    let title: String
    let url: URL
    let displayURL: String

    static let kpnTV = KPNDestination(
        title: "KPN TV",
        url: URL(string: "https://tv.kpn.com")!,
        displayURL: "tv.kpn.com"
    )
}

enum GuideTopic: String, CaseIterable, Identifiable {
    case start
    case airPlay
    case remote
    case privacy

    var id: String { rawValue }

    var title: String {
        switch self {
        case .start:
            return "Start watching"
        case .airPlay:
            return "AirPlay setup"
        case .remote:
            return "Apple TV tips"
        case .privacy:
            return "Privacy"
        }
    }

    var subtitle: String {
        switch self {
        case .start:
            return "Open KPN's official website and choose a live channel."
        case .airPlay:
            return "Send playback from an iPhone, iPad, or Mac to this Apple TV."
        case .remote:
            return "Keep the viewing experience comfortable from the couch."
        case .privacy:
            return "This app never asks for KPN credentials."
        }
    }

    var steps: [String] {
        switch self {
        case .start:
            return [
                "Scan the QR code or type tv.kpn.com on an iPhone, iPad, or Mac.",
                "Sign in with your KPN account on the official KPN website.",
                "Pick the channel you want to watch from KPN's live TV guide.",
                "Use AirPlay or screen mirroring to watch on this Apple TV."
            ]
        case .airPlay:
            return [
                "Make sure this Apple TV and your device are on the same Wi-Fi network.",
                "Start playback on tv.kpn.com in Safari or a supported browser.",
                "Select the AirPlay icon in the player or Control Center.",
                "Choose this Apple TV from the device list."
            ]
        case .remote:
            return [
                "Use the Siri Remote to keep this guide open while setting up playback.",
                "Press Back to return to the guide topics.",
                "If AirPlay stops, reconnect from the device that is playing tv.kpn.com.",
                "For best results, keep the source device awake and near Wi-Fi."
            ]
        case .privacy:
            return [
                "KPN account login happens only on tv.kpn.com.",
                "No usernames, passwords, cookies, or viewing history are stored here.",
                "Live channels remain delivered by KPN's official web player.",
                "This app is a launcher and setup guide for Apple TV."
            ]
        }
    }
}
