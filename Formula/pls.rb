# frozen_string_literal: true

# SPDX-FileCopyrightText: 2026 David Rabkin
# SPDX-License-Identifier: 0BSD

# Installs pls into a private GEM_HOME.
class Pls < Formula
  desc "Package lister that prints dependent package names"
  homepage "https://rdavid.github.io/pls/"
  url "https://rubygems.org/downloads/pls-1.0.6.gem"
  sha256 "fe895d0beb8c9d760271e1d381168ab8757501e2205690189d24b869725f10c8"
  license "0BSD"

  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "install", Dir["*.gem"].first,
           "--ignore-dependencies", "--no-document",
           "--install-dir", libexec
    bin.install libexec/"bin/pls"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV.fetch("GEM_HOME"))
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pls --version")
  end
end
