class Ariadne < Formula
  desc "C++ library for formal verification of cyber-physical systems"
  homepage "https://github.com/ariadne-cps/ariadne"
  url "https://github.com/ariadne-cps/ariadne/archive/v2.4.1.tar.gz"
  sha256 "14e9dfe546c923ecb569349c25d304d273bc30e79037f68bc0e03522b24c9ae4"
  license "GPL-3.0"
  head "https://github.com/ariadne-cps/ariadne.git"

  bottle do
    root_url "https://www.ariadne-cps.org/cellar"
    sha256 cellar: :any, big_sur: "c95cbba0ece602620f83d32e95c02af5698211a81bbfea6780b1175dc00cfa6a"
  end

  depends_on "cmake" => :build
  depends_on "gcc@10" => :build
  depends_on "ninja" => :build
  depends_on "cairo"
  depends_on "gmp"
  depends_on "gnuplot"
  depends_on "mpfr"
  depends_on "python@3.9"

  def install
    mkdir "build" do
      system "cmake", "..", "-G", "Ninja", "-DCMAKE_CXX_COMPILER=g++-10", "-DCMAKE_BUILD_TYPE=Release",
             "-DCMAKE_INSTALL_PREFIX=#{prefix}", "-DPYTHON_BINDINGS_INSTALL_DIR=libexec"
      system "cmake", "--build", ".", "--target", "install", "--parallel"
    end

    python_version = Language::Python.major_minor_version Formula["python@3.9"].bin/"python3"
    (lib/"python#{python_version}/site-packages/homebrew-ariadne.pth").write <<~EOS
      import site; site.addsitedir('#{libexec}')
    EOS
  end
end
