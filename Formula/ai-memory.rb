class AiMemory < Formula
  desc "AI-agnostic persistent memory system — MCP server, HTTP API, and CLI"
  homepage "https://alphaonedev.github.io/ai-memory-mcp/"
  version "0.6.4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-aarch64-apple-darwin.tar.gz"
      sha256 "b0d8025127e99b0d3bbaa66fe0ae47725a91ef70a48a47b770030be9d3df5c81"
    else
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-x86_64-apple-darwin.tar.gz"
      sha256 "dbe9fa53bb6c586662d16b4abcd0eb54876d9a008a966082120eed707ba29c53"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "38345ea73327d07c624bdf434372286b40bf2a4264345151523009f921967afd"
    else
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "14fb84cd131e9a9b8afadb9c12cfe2148b76c9544e0033cc8ff2e8c1193a8ba9"
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
