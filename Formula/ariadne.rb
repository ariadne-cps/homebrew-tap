class Ariadne < Formula
  desc "Ariadne C++ library for formal verification"
  homepage "https://github.com/ariadne-cps/ariadne"
  url "https://github.com/ariadne-cps/ariadne/archive/v2.0.tar.gz"
  sha256 "944bc0436de6714e078ef44ff51d63f9ae4fbf968150ccca4cac504c731af462"
  license "GPL-3.0"
  head "https://github.com/ariadne-cps/ariadne.git"

  depends_on "cmake"
  depends_on "ninja"

  depends_on "mpfr"
  depends_on "gmp"
  depends_on "cairo"
  depends_on "python@3.9"

  def install
    mkdir "build" do
      system "cmake -G \"Ninja\" .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=#{prefix}"
      system "cmake", "--build", ".", "--target", "install", "--parallel"
   end
  end

end