class GrokCli < Formula
  desc "AI coding agent powered by xAI Grok — Bun + React Ink"
  homepage "https://alphaonedev.github.io/grok-cli/"
  version "1.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alphaonedev/grok-cli/releases/download/grok-dev%40#{version}/grok-darwin-arm64"
      sha256 "c686b48b0e54c2e39616fc259e5308b19c877d8fededc749aa8c8bf19cfc6aca"
    else
      odie "grok-cli only ships a darwin-arm64 binary today (Apple Silicon)."
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/alphaonedev/grok-cli/releases/download/grok-dev%40#{version}/grok-linux-x64"
      sha256 "6a83ebc2f316c51ad5cbbf1296131b8902ef816aabe7a2d8c8c644b57cebbc8a"
    else
      odie "grok-cli only ships an x86_64 linux binary today."
    end
  end

  def install
    binary_name = OS.mac? ? "grok-darwin-arm64" : "grok-linux-x64"
    bin.install binary_name => "grok"

    # The macOS binary is ad-hoc signed but not yet Apple-notarized.
    # Strip the quarantine attribute Homebrew sometimes inherits so
    # users don't hit a Gatekeeper "cannot verify developer" warning
    # on first launch. Best-effort — silently ignore if xattr isn't
    # available or the attribute isn't set.
    if OS.mac?
      begin
        system "/usr/bin/xattr", "-d", "com.apple.quarantine", bin/"grok"
      rescue
        nil
      end
    end
  end

  def caveats
    <<~EOS
      Get a Grok API key:  https://console.x.ai

      Then set it via one of:
        export GROK_API_KEY=xai-...
        grok --api-key xai-...
        echo '{"apiKey":"xai-..."}' > ~/.grok/user-settings.json

      Run:  grok --help

      macOS note: this release is ad-hoc signed but not yet Apple-notarized.
      Homebrew handles the Gatekeeper attribute automatically.
      Full notarization is on the roadmap.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/grok --version").strip
  end
end
