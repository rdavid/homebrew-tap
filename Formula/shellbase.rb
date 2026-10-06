# frozen_string_literal: true

# SPDX-FileCopyrightText: 2026 David Rabkin
# SPDX-License-Identifier: 0BSD

# Installs the shellbase framework as a single POSIX shell script.
class Shellbase < Formula
  desc "Foundation for Unix shell scripts"
  homepage "https://rdavid.github.io/shellbase/"
  url "https://github.com/rdavid/shellbase/archive/refs/tags/v0.9.20260707.tar.gz"
  sha256 "5b5c735f7c1aa8e0e15d8048ae4ff25e21214a117609021422ab18af55bd412f"
  license "0BSD"

  skip_clean "bin/base.sh"

  def install
    bin.install "lib/base.sh"
    (bin/"base.sh").chmod 0755
  end

  test do
    assert_match version.to_s, shell_output("sh #{bin}/base.sh --quiet --version")
  end
end
