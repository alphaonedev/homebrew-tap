class AiMemory < Formula
  desc "AI-agnostic persistent memory system — MCP server, HTTP API, and CLI"
  homepage "https://alphaonedev.github.io/ai-memory-mcp/"
  version "0.6.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-aarch64-apple-darwin.tar.gz"
      sha256 "b027898e2e63bc5bece020dc1a20f5fd40c81d10d9b956d3f3fe77de52bf040b"
    else
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-x86_64-apple-darwin.tar.gz"
      sha256 "709cb286d840fe0725cc1bbc1c10bb4cf501656246f75ab4eed610e4a1961316"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4a7656bcd1f28fa43dbed193122ab3e718296dd2f3de1f856d7e31c6dfc71824"
    else
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "adc4ccec7c836388565033bf2c3307684a4c0a09edbc45226a53965b2d8cd353"
    end
  end

  def install
    bin.install "ai-memory"
  end

  def caveats
    <<~EOS
      To use with an MCP-compatible AI (Claude Code, Codex CLI, Gemini CLI, OpenClaw, etc.),
      add to your AI platform's MCP config:

        {
          "mcpServers": {
            "memory": {
              "command": "ai-memory",
              "args": ["--db", "~/.local/share/ai-memory/memories.db", "mcp"]
            }
          }
        }

      Documentation: https://alphaonedev.github.io/ai-memory-mcp/
    EOS
  end

  test do
    system "#{bin}/ai-memory", "stats", "--json", "--db", testpath/"test.db"
  end
end
