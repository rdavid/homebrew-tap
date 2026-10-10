# frozen_string_literal: true

# SPDX-FileCopyrightText: 2026 David Rabkin
# SPDX-License-Identifier: 0BSD

# Installs a selection of the toolbox shell scripts.
class Toolbox < Formula
  desc "Unix shell scripts designed for everyday use"
  homepage "https://rdavid.github.io/toolbox/"
  url "https://github.com/rdavid/toolbox/archive/refs/tags/v0.9.20261010.tar.gz"
  sha256 "936592cc8d7ca503a59f47cadcefd621dc4d9abb33fe65590138798d711ebb47"
  license "0BSD"

  depends_on "bind"
  depends_on "coreutils"
  depends_on "ffmpeg"
  depends_on "gawk"
  depends_on "imagemagick"
  depends_on "rdiff-backup"
  depends_on "rsync"
  depends_on "shellbase"
  depends_on "speedtest-cli"
  depends_on "whois"

  TOOLS = %w[bak chowner copyright ival myip pingo reel rsyncx sift speed].freeze

  def install
    wrapped = {
      "myip" => "#{formula_opt_bin("whois")}:${PATH}",
      "sift" => "#{formula_opt_libexec("coreutils")}/gnubin:${PATH}",
    }
    TOOLS.each do |tool|
      if wrapped.key?(tool)
        libexec.install "app/#{tool}"
        (bin/tool).write_env_script libexec/tool, PATH: wrapped.fetch(tool)
      else
        bin.install "app/#{tool}"
      end
    end
  end

  test do
    TOOLS.each do |tool|
      assert_match "#{tool} ", shell_output("#{bin}/#{tool} --version 2>&1")
    end
  end
end
