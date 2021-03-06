class Ariadne < Formula
  desc "C++ library for formal verification of cyber-physical systems"
  homepage "https://github.com/ariadne-cps/ariadne"
  url "https://github.com/ariadne-cps/ariadne/archive/v2.1-rc3.tar.gz"
  sha256 "091457c8b4348fd1a8e764a3d8edf096d6a4fc57ee00601f5bea772032113e42"
  license "GPL-3.0"
  revision 3
  head "https://github.com/ariadne-cps/ariadne.git"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "cairo"
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "python@3.9"

  def install
    mkdir "build" do
      system "cmake -G \"Ninja\" .. -DCMAKE_BUILD_TYPE=Release -DHOMEBREW=1 -DCMAKE_INSTALL_PREFIX=#{prefix}"
      system "cmake", "--build", ".", "--target", "install", "--parallel"
    end

    python_version = Language::Python.major_minor_version Formula["python@3.9"].bin/"python3"
    (lib/"python#{python_version}/site-packages/homebrew-ariadne.pth").write <<~EOS
      import site; site.addsitedir('#{libexec}')
    EOS
  end
end
