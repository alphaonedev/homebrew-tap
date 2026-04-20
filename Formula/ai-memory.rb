class AiMemory < Formula
  desc "AI-agnostic persistent memory system — MCP server, HTTP API, and CLI"
  homepage "https://alphaonedev.github.io/ai-memory-mcp/"
  version "0.6.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-aarch64-apple-darwin.tar.gz"
      sha256 "3cdf7edf2f46cc0ab5e50ff9558eb41de76e15341bc10dff37d1d8764ce5b594"
    else
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-x86_64-apple-darwin.tar.gz"
      sha256 "2d0d2a34cfabb6e76dcf9fd827bcbe46b5aa5a4021e79503a135ca5c1b2cfab4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "188b2fd2a34d76e99d42c15edd24cbc37a5412a2f6e02de0b6c318e03ea1a043"
    else
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "67bbdcc491d4cb9ec49cf97b9e7a51548d398d596afaaa80400a2a4d93538c9b"
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
