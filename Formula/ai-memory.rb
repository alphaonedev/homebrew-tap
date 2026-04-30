class AiMemory < Formula
  desc "AI-agnostic persistent memory system — MCP server, HTTP API, and CLI"
  homepage "https://alphaonedev.github.io/ai-memory-mcp/"
  version "0.6.3.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-aarch64-apple-darwin.tar.gz"
      sha256 "ef374c8ea8f9b61afbbbce6619b75d4efe01fe006af099a2433156a80e2ddb33"
    else
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-x86_64-apple-darwin.tar.gz"
      sha256 "30d1642534b10b4158862d1c5d6338c0ccd604a6e4618ad87d93690cbb9ad682"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c5a055fd1c871da7c962007e501efab3e0cc269187fe01de852b1085a62987bf"
    else
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3b787d27d79cf820f196d8f6605ce2dbc55e8868c837c5c9a3d822fa684f6fe0"
    end
  end

  def install
    bin.install "ai-memory"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ai-memory --version")
  end
end
