class Nanoedit < Formula
  desc "Minimal floating text editor designed for use as an external editor"
  homepage "https://github.com/wtshm/nanoedit"
  url "https://github.com/wtshm/nanoedit/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "9ad98bf4411cc65d6c1a8162f7090bc36c39a9f50ccd2492373bd82570a6b75e"
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
