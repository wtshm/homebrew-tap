class Nanoedit < Formula
  desc "Minimal floating text editor designed for use as an external editor"
  homepage "https://github.com/wtshm/nanoedit"
  url "https://github.com/wtshm/nanoedit/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "f57e6893f7d38f8898def687b5ccd4b288f4fcfdbeaee6820090adc95d6b44b6"
  license "MIT"

  depends_on :macos
  depends_on xcode: ["14.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/nanoedit"
    bin.install ".build/release/Highlighter_Highlighter.bundle"
    system "codesign", "--force", "--sign", "-", bin/"nanoedit"
  end

  test do
    assert_match "Usage: nanoedit", shell_output("#{bin}/nanoedit 2>&1", 1)
  end
end
