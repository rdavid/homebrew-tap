# frozen_string_literal: true

# SPDX-FileCopyrightText: 2026 David Rabkin
# SPDX-License-Identifier: 0BSD

# Installs pls into a private GEM_HOME.
class Pls < Formula
  desc "Package lister that prints dependent package names"
  homepage "https://rdavid.github.io/pls/"
  url "https://rubygems.org/downloads/pls-1.0.5.gem"
  sha256 "711b4d18c001f655563b85c628b703838b0bfe7bd5ac066957dc2b00eeb92140"
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
