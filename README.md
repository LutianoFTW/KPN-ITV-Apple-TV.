# KPN ITV Apple TV

A native Apple TV companion app for watching KPN TV channels through the official
KPN web player at [tv.kpn.com](https://tv.kpn.com).

## What this app does

- Runs as a native SwiftUI tvOS app.
- Shows a couch-friendly setup guide for the Siri Remote.
- Displays a QR code for `https://tv.kpn.com`.
- Guides users to sign in on KPN's official website and send playback to Apple TV
  with AirPlay or screen mirroring.
- Avoids collecting KPN usernames, passwords, cookies, or viewing history.

## Important playback limitation

Apple TV does not provide a public Safari browser experience for apps, and KPN's
live TV streams are protected by KPN's official player, subscription checks, and
DRM. This project therefore does **not** scrape streams, embed `tv.kpn.com`, or
attempt to bypass KPN's access controls.

The supported flow is:

1. Open `tv.kpn.com` on an iPhone, iPad, or Mac.
2. Sign in with a valid KPN account.
3. Choose a live TV channel in KPN's official web player.
4. Use AirPlay or screen mirroring to watch on Apple TV.

## Requirements

- macOS with Xcode 16 or newer.
- Apple TV simulator or an Apple TV device running tvOS 16 or newer.
- A valid KPN subscription for the channels you want to watch.
- An iPhone, iPad, or Mac on the same Wi-Fi network for AirPlay playback.

## Run locally

1. Open `KPNITVAppleTV.xcodeproj` in Xcode.
2. Select the `KPNITVAppleTV` scheme.
3. Choose an Apple TV simulator or paired Apple TV device.
4. Press Run.

## Project structure

```text
KPNITVAppleTV.xcodeproj/          Xcode project for the tvOS app
KPNITVAppleTV/Sources/            SwiftUI application source
```

## Future production work

To play channels directly inside a native tvOS app, KPN would need to provide an
official API or SDK that supports tvOS playback, authentication, entitlement
checks, stream URLs, EPG data, and FairPlay/DRM integration.
