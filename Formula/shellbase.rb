# frozen_string_literal: true

# SPDX-FileCopyrightText: 2026 David Rabkin
# SPDX-License-Identifier: 0BSD

# Installs the shellbase framework as a single POSIX shell script.
class Shellbase < Formula
  desc "Unix shell framework for logging, validation, and signal handling"
  homepage "https://rdavid.github.io/shellbase/"
  url "https://github.com/rdavid/shellbase/archive/refs/tags/v0.9.20261111.tar.gz"
  sha256 "936f2f03b620fccf43f912d35b12cb72fd5672a7aebcacd92b55744869ac557b"
  license "0BSD"

  skip_clean "bin/base.sh"

  def install
    bin.install "lib/base.sh"
  end

  test do
    assert_match version.to_s, shell_output("sh #{bin}/base.sh --quiet --version")
  end
end
