class Ariadne < Formula
  desc "C++ library for formal verification of cyber-physical systems"
  homepage "https://github.com/ariadne-cps/ariadne"
  url "https://github.com/ariadne-cps/ariadne/archive/v2.5.3.tar.gz"
  sha256 "9b21878a24263a100af45d9e964af219fd6272e59d22541216288e5c808e3e0a"
  license "GPL-3.0"
  head "https://github.com/ariadne-cps/ariadne.git"

  bottle do
    root_url "https://www.ariadne-cps.org/cellar"
    sha256 cellar: :any, sequoia: "9b21878a24263a100af45d9e964af219fd6272e59d22541216288e5c808e3e0a"
  end

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "cairo"
  depends_on "gmp"
  depends_on "gnuplot"
  depends_on "mpfr"
  depends_on "python@3"

  def install
    mkdir "build" do
      system "cmake", "..", "-G", "Ninja", "-DCMAKE_BUILD_TYPE=Release",
             "-DCMAKE_INSTALL_PREFIX=#{prefix}", "-DPYTHON_BINDINGS_INSTALL_DIR=libexec"
      system "cmake", "--build", ".", "--target", "install", "--parallel"
    end

    python_version = Language::Python.major_minor_version Formula["python@3"].bin/"python3"
    (lib/"python#{python_version}/site-packages/homebrew-ariadne.pth").write <<~EOS
      import site; site.addsitedir('#{libexec}')
    EOS
  end
end
