const fs = require("fs");
const path = require("path");

const root = path.resolve(__dirname, "..");

function read(relativePath) {
  return fs.readFileSync(path.join(root, relativePath), "utf8");
}

function assert(condition, message) {
  if (!condition) {
    throw new Error(message);
  }
}

const requiredFiles = [
  "KPNITVAppleTV.xcodeproj/project.pbxproj",
  "KPNITVAppleTV/App/KPNITVAppleTVApp.swift",
  "KPNITVAppleTV/App/ContentView.swift",
  "KPNITVAppleTV/App/QRCodeView.swift",
  "KPNITVAppleTV/Assets.xcassets/Contents.json",
  "KPNITVAppleTV/Assets.xcassets/AccentColor.colorset/Contents.json"
];

for (const file of requiredFiles) {
  assert(fs.existsSync(path.join(root, file)), `Missing required file: ${file}`);
}

const project = read("KPNITVAppleTV.xcodeproj/project.pbxproj");
const contentView = read("KPNITVAppleTV/App/ContentView.swift");
const qrCodeView = read("KPNITVAppleTV/App/QRCodeView.swift");
const source = [contentView, qrCodeView].join("\n");

assert(project.includes("SDKROOT = appletvos;"), "Project must use the tvOS SDK.");
assert(
  project.includes('SUPPORTED_PLATFORMS = "appletvos appletvsimulator";'),
  "Project must support Apple TV device and simulator platforms."
);
assert(project.includes("TARGETED_DEVICE_FAMILY = 3;"), "Targeted device family must be Apple TV.");
assert(source.includes("https://tv.kpn.com"), "App must guide users to tv.kpn.com.");
assert(source.includes("airplayvideo"), "App must include AirPlay viewing guidance.");

const unsupportedBrowserApis = [
  "import WebKit",
  "WKWebView",
  "UIWebView",
  "SFSafariViewController"
];

for (const api of unsupportedBrowserApis) {
  assert(!source.includes(api), `Unsupported tvOS browser API found: ${api}`);
}

console.log("Validation passed: tvOS app scaffold and KPN viewing flow are configured.");
