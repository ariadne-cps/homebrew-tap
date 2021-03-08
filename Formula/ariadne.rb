class Ariadne < Formula
  desc "C++ library for formal verification of cyber-physical systems"
  homepage "https://github.com/ariadne-cps/ariadne"
  url "https://github.com/ariadne-cps/ariadne/archive/v2.1.tar.gz"
  sha256 "1c0204dbec6c01d898f426e40d406ec4f39cd29b9c30f9d203525fa51cd6982a"
  license "GPL-3.0"
  head "https://github.com/ariadne-cps/ariadne.git"

  bottle do
    root_url "https://www.ariadne-cps.org/cellar"
    sha256 cellar: :any, big_sur: "ebb63c23f433d815bb205f8cabc6cf049c88b24e1f07858520e6eec3ab8d7591"
  end

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "cairo"
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "python@3.9"

  def install
    mkdir "build" do
      system "cmake .. -G Ninja -DCMAKE_BUILD_TYPE=Release",
             "-DCMAKE_INSTALL_PREFIX=#{prefix} -DPYTHON_BINDINGS_INSTALL_DIR=libexec"
      system "cmake", "--build", ".", "--target", "install", "--parallel"
    end

    python_version = Language::Python.major_minor_version Formula["python@3.9"].bin/"python3"
    (lib/"python#{python_version}/site-packages/homebrew-ariadne.pth").write <<~EOS
      import site; site.addsitedir('#{libexec}')
    EOS
  end
end
