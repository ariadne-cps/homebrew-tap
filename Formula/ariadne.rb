class Ariadne < Formula
  desc "C++ library for formal verification of cyber-physical systems"
  homepage "https://github.com/ariadne-cps/ariadne"
  url "https://github.com/ariadne-cps/ariadne/archive/2.1-rc1.tar.gz"
  sha256 "3382f22539aca4d1d5ef0ccb7142098049314562b10eeb5aa028e016d4ea4ca3"
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
    Dir.chdir("python") do  
      system "python3", "setup.py", "install", "--prefix=#{prefix}"
    end  
  end
end
