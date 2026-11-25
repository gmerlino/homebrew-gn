class Gn < Formula
  desc "A meta-build system that generates build files for Ninja"
  homepage "https://gn.googlesource.com/gn"
  url "https://gn.googlesource.com/gn.git",
      revision: "e04c7ff10dc0955050fbdbae6b46d856663d7d1f"
  version "2643"
  license "BSD-3-Clause"
  head "https://gn.googlesource.com/gn.git", branch: "main"

  depends_on "ninja" => :build
  depends_on "python@3.15" => :build

  def install
    ENV["CXX"] = ENV.cxx
    system Formula["python@3.15"].opt_bin/"python3.15", "build/gen.py", "--allow-warnings"
    system "ninja", "-C", "out", "gn", "gn_unittests"
    system "out/gn_unittests"
    bin.install buildpath/"out/gn"
    bin.install buildpath/"out/gn_unittests"
    pkgshare.install "src"
  end

  test do
    # Format tests locate fixtures relative to the executable, not the cwd.
    (testpath/"out").mkpath
    cp bin/"gn_unittests", testpath/"out/gn_unittests"
    (testpath/"src").make_symlink pkgshare/"src"
    assert_match "PASSED", shell_output("#{testpath}/out/gn_unittests")
  end
end
