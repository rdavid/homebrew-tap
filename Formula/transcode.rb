# frozen_string_literal: true

# SPDX-FileCopyrightText: 2026 David Rabkin
# SPDX-License-Identifier: 0BSD

# Installs transcode and its runtime gems into a private GEM_HOME.
class Transcode < Formula
  desc "Tool to transcode, inspect, and convert video files"
  homepage "https://rdavid.github.io/transcode/"
  url "https://rubygems.org/downloads/transcode-1.0.7.gem"
  sha256 "b698c858dbb8f03882611f4ee13b0dbdbc56c56c4052b7c50df4b831520a6d65"
  license "0BSD"

  depends_on "ffmpeg"
  depends_on "handbrake"
  depends_on "mkvtoolnix"
  depends_on "mp4v2"
  depends_on "ruby"

  resource "ellipsized" do
    url "https://rubygems.org/downloads/ellipsized-0.3.0.gem"
    sha256 "678a87ada7a0b91352fd622c3c672df53c0f3d0e025a92f9a12ab206157814f7"
  end

  resource "terminal-table" do
    url "https://rubygems.org/downloads/terminal-table-4.0.0.gem"
    sha256 "f504793203f8251b2ea7c7068333053f0beeea26093ec9962e62ea79f94301d2"
  end

  resource "unicode-display_width" do
    url "https://rubygems.org/downloads/unicode-display_width-3.2.0.gem"
    sha256 "0cdd96b5681a5949cdbc2c55e7b420facae74c4aaf9a9815eee1087cb1853c42"
  end

  resource "unicode-emoji" do
    url "https://rubygems.org/downloads/unicode-emoji-4.2.0.gem"
    sha256 "519e69150f75652e40bf736106cfbc8f0f73aa3fb6a65afe62fefa7f80b0f80f"
  end

  resource "video_transcoding" do
    url "https://rubygems.org/downloads/video_transcoding-0.25.3.gem"
    sha256 "0f48627915f91a86633c06393f938cd0b9048a348f93ba833b51a57d91815ed2"
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
    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV.fetch("GEM_HOME"))
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/transcode --version")
    assert_match "transcode-video", shell_output("#{bin}/transcode-video --help")
  end
end
