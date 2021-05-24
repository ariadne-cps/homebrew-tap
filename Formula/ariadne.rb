class Ariadne < Formula
  desc "C++ library for formal verification of cyber-physical systems"
  homepage "https://github.com/ariadne-cps/ariadne"
  url "https://github.com/ariadne-cps/ariadne/archive/v2.3.tar.gz"
  sha256 "387c7200d7886236afb515fe4e717c5f76f3a3e4df7999da4b9de4b3ab56fd4b"
  license "GPL-3.0"
  head "https://github.com/ariadne-cps/ariadne.git"

  bottle do
    root_url "https://www.ariadne-cps.org/cellar"
    sha256 cellar: :any, big_sur: "d54f8d205cc1c309011a9010afa939a70a70f137ec075ae94f683c0744df9f0d"
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
