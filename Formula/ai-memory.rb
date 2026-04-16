class AiMemory < Formula
  desc "AI-agnostic persistent memory system — MCP server, HTTP API, and CLI"
  homepage "https://alphaonedev.github.io/ai-memory-mcp/"
  version "0.6.0-alpha.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-aarch64-apple-darwin.tar.gz"
      sha256 "a7e6d984e8faa1ba2ba6c9ac8c65a4b1fb70323c17bbd7b59826f76d717c1e76"
    else
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-x86_64-apple-darwin.tar.gz"
      sha256 "f3f4a83c42cbefa27954fc4bb3fcb9ed9119fe1583dbaaf56d21206b23517b02"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e65b34dbeea1a7656e45341072f77a73fad1a407231636c714fe997fa9524722"
    else
      url "https://github.com/alphaonedev/ai-memory-mcp/releases/download/v#{version}/ai-memory-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fbdf1d0da27fe52ba4e3cb47c81e948ca00811fec97f5da131f18be52afa1b46"
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
