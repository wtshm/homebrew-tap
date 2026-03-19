class Nanoedit < Formula
  desc "Minimal floating text editor designed for use as an external editor"
  homepage "https://github.com/wtshm/nanoedit"
  url "https://github.com/wtshm/nanoedit/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "f8b509c9c22dd9f5c64df8bcaeb7b8f2e9b54ab008d33bda00d599452a11dfbd"
  license "MIT"

  depends_on :macos
  depends_on xcode: ["14.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    libexec.install ".build/release/nanoedit"
    libexec.install ".build/release/Highlighter_Highlighter.bundle"
    system "codesign", "--force", "--sign", "-", libexec/"nanoedit"
    (bin/"nanoedit").write <<~SH
      #!/bin/bash
      exec "#{libexec}/nanoedit" "$@"
    SH
  end

  test do
    assert_match "Usage: nanoedit", shell_output("#{bin}/nanoedit 2>&1", 1)
  end
end
