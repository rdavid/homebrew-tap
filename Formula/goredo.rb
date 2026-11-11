# frozen_string_literal: true

# SPDX-FileCopyrightText: 2026 David Rabkin
# SPDX-License-Identifier: 0BSD

# Installs a prebuilt goredo binary from the goredoer releases.
class Goredo < Formula
  desc "Go implementation of djb's redo build system"
  homepage "https://rdavid.github.io/goredoer/"
  version "2.11.0"
  license "GPL-3.0-only"

  livecheck do
    url :stable
    regex(/goredo[._-]v?(\d+(?:\.\d+)+)[._-]darwin[._-]arm64\.t/i)
    strategy :github_latest do |json, regex|
      json["assets"]&.filter_map { |asset| asset["name"]&.[](regex, 1) }
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/rdavid/goredoer/releases/download/v0.9.20261111/goredo-2.11.0-darwin-arm64.tar.gz"
      sha256 "f76b2258f795c700ffc2d3f2271af8c84508da9948ffef2d74f1e4ceb0a2df26"
    end
    on_intel do
      url "https://github.com/rdavid/goredoer/releases/download/v0.9.20261111/goredo-2.11.0-darwin-amd64.tar.gz"
      sha256 "aed8a63558d1f706c58158dd4403ccaf3075ad7439b45c19d9aa1461aa2851d2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rdavid/goredoer/releases/download/v0.9.20261111/goredo-2.11.0-linux-arm64.tar.gz"
      sha256 "fa3a2cab2af7c6b5fa9d1cdaced6048a7c69c70d63810bb1a3c7914fea02fc5e"
    end
    on_intel do
      url "https://github.com/rdavid/goredoer/releases/download/v0.9.20261111/goredo-2.11.0-linux-amd64.tar.gz"
      sha256 "7375e35413a931a91bfc12f985b459a4f149930c5c2998dd4840a596d483e428"
    end
  end

  conflicts_with "goredo", because: "both install `goredo`, `redo` and `redo-*` binaries"
  conflicts_with "redo", because: "both install `redo` and `redo-*` binaries"

  def install
    bin.install "goredo"
    cd bin do
      system bin/"goredo", "-symlinks"
    end
  end

  test do
    (testpath/"gore.do").write <<~EOS
      echo YOU ARE LIKELY TO BE EATEN BY A GRUE >&2
    EOS
    assert_match "YOU ARE LIKELY TO BE EATEN BY A GRUE\n", shell_output("#{bin}/redo -no-progress gore 2>&1")

    assert_match version.to_s, shell_output("#{bin}/goredo -version")
  end
end
