# KPN ITV Apple TV

A native tvOS companion app that helps KPN customers watch TV from
[tv.kpn.com](https://tv.kpn.com) on Apple TV through the supported AirPlay flow.

## What this app does

- Runs as a native SwiftUI app on Apple TV / tvOS.
- Shows a large QR code for `https://tv.kpn.com`.
- Guides users to open KPN TV on a supported phone, tablet, or computer.
- Explains how to start a live TV channel and send it to Apple TV with AirPlay.
- Keeps KPN authentication, subscriptions, device limits, location checks, and DRM in KPN's own app or website.

## Why it does not embed tv.kpn.com directly

Apple TV does not provide a public, App-Store-safe `WKWebView` or browser API for
rendering arbitrary websites inside tvOS apps. KPN live channels are also protected
behind KPN login, entitlement checks, and DRM. This project therefore avoids
scraping, proxying, or bypassing KPN streams and implements the supported way to
watch on Apple TV: start playback from KPN's own website/app and use AirPlay.

## Project structure

```text
KPNITVAppleTV.xcodeproj/      Xcode tvOS project
KPNITVAppleTV/App/            SwiftUI application source
KPNITVAppleTV/Assets.xcassets Asset catalog metadata
scripts/validate.js           Static project validation
```

## Build and run

Requirements:

- macOS with Xcode 15 or newer
- tvOS 17 simulator, or an Apple TV device configured for development

Steps:

1. Open `KPNITVAppleTV.xcodeproj` in Xcode.
2. Select the `KPNITVAppleTV` scheme.
3. Choose an Apple TV simulator or device.
4. Press Run.

For device builds, replace the placeholder bundle identifier and development team
in the Xcode target settings with values from your Apple Developer account.

## Validate the repository

The validation script can run on any machine with Node.js:

```bash
npm test
```

It checks that the project targets tvOS, includes `tv.kpn.com`, and does not use
unsupported WebKit/browser APIs on tvOS.
