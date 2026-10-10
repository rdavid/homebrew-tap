# frozen_string_literal: true

# SPDX-FileCopyrightText: 2026 David Rabkin
# SPDX-License-Identifier: 0BSD

# Installs renamr and its runtime gems into a private GEM_HOME.
class Renamr < Formula
  desc "File and directory name normalizer"
  homepage "https://github.com/rdavid/renamr"
  url "https://rubygems.org/downloads/renamr-1.0.17.gem"
  sha256 "6d495bfbf55e802b07aa26c3aa9a8cd25237614ad3ffdb4d9b500b52f15d8a2a"
  license "0BSD"

  depends_on "ruby"

  resource "concurrent-ruby" do
    url "https://rubygems.org/downloads/concurrent-ruby-1.3.8.gem"
    sha256 "b2f1be836e968ccc78ccfce277ea79c72a88633f22306782c16ff23fb415d1e1"
  end

  resource "ellipsized" do
    url "https://rubygems.org/downloads/ellipsized-0.3.0.gem"
    sha256 "678a87ada7a0b91352fd622c3c672df53c0f3d0e025a92f9a12ab206157814f7"
  end

  resource "i18n" do
    url "https://rubygems.org/downloads/i18n-1.15.2.gem"
    sha256 "00f9eb62412fe593b2a65a97daa75300d37abb8f7202ec748e94b6d46a9dd1b5"
  end

  resource "terminal-table" do
    url "https://rubygems.org/downloads/terminal-table-4.0.0.gem"
    sha256 "f504793203f8251b2ea7c7068333053f0beeea26093ec9962e62ea79f94301d2"
  end

  resource "unicode-display_width" do
    url "https://rubygems.org/downloads/unicode-display_width-3.3.0.gem"
    sha256 "4b7aa66a4b11db50f6f7e98411215cd0dd10eaecb665d36eec5bcacb3fa0b613"
  end

  resource "unicode-emoji" do
    url "https://rubygems.org/downloads/unicode-emoji-4.3.0.gem"
    sha256 "11c02fa73290378c066bb0562cd4c87d8e1b706fbbe0059ca12746a4244de8ce"
  end

  def install
    ENV["GEM_HOME"] = libexec
    resources.each do |r|
      r.stage do
        system "gem", "install", Dir["*.gem"].first,
               "--ignore-dependencies", "--no-document",
               "--install-dir", libexec
      end
    end
    system "gem", "install", Dir["*.gem"].first,
           "--ignore-dependencies", "--no-document",
           "--install-dir", libexec
    bin.install libexec/"bin/renamr"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV.fetch("GEM_HOME"))
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/renamr --version")
    (testpath/"Hello World.txt").write("")
    system bin/"renamr", "--act", "--dir", testpath
    assert_path_exists testpath/"hello-world.txt"
    refute_path_exists testpath/"Hello World.txt"
  end
end
