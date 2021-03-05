class Ariadne < Formula
  desc "C++ library for formal verification of cyber-physical systems"
  homepage "https://github.com/ariadne-cps/ariadne"
  url "https://github.com/ariadne-cps/ariadne/archive/v2.1-rc2.tar.gz"
  sha256 "75886fbf6d4606efbb4145cb3ae0b11bd7bf0112db16a25dab483c1b5022e41e"
  license "GPL-3.0"
  head "https://github.com/ariadne-cps/ariadne.git"

  depends_on "cairo"
  depends_on "cmake"
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "ninja"
  depends_on "python@3.9"

  def install
    mkdir "build" do
      system "cmake -G \"Ninja\" .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=#{prefix}"
      system "cmake", "--build", ".", "--target", "install", "--parallel"
    end
  end
end
