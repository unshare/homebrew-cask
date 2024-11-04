cask "acronis-true-image" do
  version "41592"
  sha256 "304335d0e8e26bc46571e6926baf20da0f2d694f20a8728c7f220236d1ed29c2"

  url "https://dl.acronis.com/u/AcronisTrueImage_#{version}.dmg"
  name "Acronis True Image"
  desc "Full image backup and cloning software"
  homepage "https://www.acronis.com/products/true-image/"

  livecheck do
    url "https://www.acronis.com/en-us/support/updates/changes.html?p=42798"
    regex(/Build.*?>\s*v?(\d+(?:\.\d+)*)\s*</i)
  end

  auto_updates true
  depends_on macos: ">= :big_sur"
  depends_on cask: "acronis-true-image-cleanup-tool"

  pkg "Installer.pkg"

  uninstall launchctl: [
              "com.acronis.aakore",
              "com.acronis.acep",
              "com.acronis.acroprld_client",
              "com.acronis.active_protection",
              "com.acronis.cyber-protect-service",
              "com.acronis.escyberprotect",
              "com.acronis.helpertool",
              "com.acronis.mms_mini",
              "com.acronis.mobile_backup_server",
              "com.acronis.mobile_backup_status_server",
              "com.acronis.monitor",
              "com.acronis.scheduler",
            ],
            quit:      [
              "com.acronis.CyberProtectHomeOffice",
              "com.acronis.CyberProtectHomeOffice.FinderSyncExt",
              "com.acronis.CyberProtectHomeOffice.help",
              "com.acronis.CyberProtectHomeOffice.monitor",
              "com.acronis.escyberprotect",
            ],
            signal:    [
              ["TERM", "com.acronis.CyberProtectHomeOffice"],
              ["TERM", "com.acronis.CyberProtectHomeOffice.FinderSyncExt"],
              ["TERM", "com.acronis.CyberProtectHomeOffice.help"],
              ["TERM", "com.acronis.CyberProtectHomeOffice.monitor"],
              ["TERM", "com.acronis.escyberprotect"],
              ["KILL", "com.acronis.CyberProtectHomeOffice"],
              ["KILL", "com.acronis.CyberProtectHomeOffice.FinderSyncExt"],
              ["KILL", "com.acronis.CyberProtectHomeOffice.help"],
              ["KILL", "com.acronis.CyberProtectHomeOffice.monitor"],
              ["KILL", "com.acronis.escyberprotect"],
            ],
            pkgutil:   "com.acronis.CyberProtectHomeOffice",
            delete:    "/Applications/Acronis True Image.app"

  zap script: {
    executable: "#{HOMEBREW_PREFIX}/lib/acronis-true-image/cleanup_tool",
    sudo:       true,
  }
end
