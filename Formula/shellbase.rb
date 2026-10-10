# frozen_string_literal: true

# SPDX-FileCopyrightText: 2026 David Rabkin
# SPDX-License-Identifier: 0BSD

# Installs the shellbase framework as a single POSIX shell script.
class Shellbase < Formula
  desc "Foundation for Unix shell scripts"
  homepage "https://rdavid.github.io/shellbase/"
  url "https://github.com/rdavid/shellbase/archive/refs/tags/v0.9.20261010.tar.gz"
  sha256 "bc7d15bd50b3b4182b39726ddfe5f9481ce12ca45d47b28f354cdc007cbb17f8"
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
