class AiMemory < Formula
  desc "AI-agnostic persistent memory system — MCP server, HTTP API, and CLI"
  homepage "https://alphaonedev.github.io/ai-memory-mcp/"
  version "0.5.4.6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-aarch64-apple-darwin.tar.gz"
      sha256 "f8c6bdff062a54525cf4097b935b53b7c5fda5fb3452dfd48f36bcf343e7b3a8"
    else
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-x86_64-apple-darwin.tar.gz"
      sha256 "ecab6e9f7aa3f502dc31900dc98f64a080afe6444f64269d34b89bd9d1e60db9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2e1e7edcf6683268e5de99d631fe40e20cb170f512ca5a18abda4d9ca6cd9f63"
    else
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9407c5c204c4f85cad334ca52aabe048b23686c97e6ff6b905f1726eb9d94f80"
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
