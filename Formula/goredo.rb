# frozen_string_literal: true

# SPDX-FileCopyrightText: 2026 David Rabkin
# SPDX-License-Identifier: 0BSD

# Installs a prebuilt goredo binary from the goredoer releases.
class Goredo < Formula
  desc "Go implementation of djb's redo, a Makefile replacement"
  homepage "https://rdavid.github.io/goredoer/"
  version "2.10.0"
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
      url "https://github.com/rdavid/goredoer/releases/download/v0.9.20261010/goredo-2.10.0-darwin-arm64.tar.gz"
      sha256 "37f0f6be7b94d5980299ce5b5eab09919e9d2f80533a311de7dbf47a0ae5ca2d"
    end
    on_intel do
      url "https://github.com/rdavid/goredoer/releases/download/v0.9.20261010/goredo-2.10.0-darwin-amd64.tar.gz"
      sha256 "09873eca473fcf25eb273e63cf307c569322ba824a54b2d8bb9e84fbd5050d5a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rdavid/goredoer/releases/download/v0.9.20261010/goredo-2.10.0-linux-arm64.tar.gz"
      sha256 "f92e904a0ef6e4f3b189047072cadd931e187990aca29c307120a5f46f9bb39e"
    end
    on_intel do
      url "https://github.com/rdavid/goredoer/releases/download/v0.9.20261010/goredo-2.10.0-linux-amd64.tar.gz"
      sha256 "9e670c09a9c8ce523f00f7c8d9206158eaeabff35500f589a45d5cda8a656fb2"
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
