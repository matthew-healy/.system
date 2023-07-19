inputs: final: prev:
let
  skia-dependencies = {
    angle2 = final.fetchgit {
      url = "https://chromium.googlesource.com/angle/angle.git";
      rev = "8718783526307a3fbb35d4c1ad4e8101262a0d73";
      sha256 = "0c90q8f4syvwcayw58743sa332dcpkmblwh3ffkjqn5ygym04xji";
    };

    dng_sdk = final.fetchgit {
      url = "https://android.googlesource.com/platform/external/dng_sdk.git";
      rev = "c8d0c9b1d16bfda56f15165d39e0ffa360a11123";
      sha256 = "1nlq082aij7q197i5646bi4vd2il7fww6sdwhqisv2cs842nyfwm";
    };

    piex = final.fetchgit {
      url = "https://android.googlesource.com/platform/external/piex.git";
      rev = "bb217acdca1cc0c16b704669dd6f91a1b509c406";
      sha256 = "05ipmag6k55jmidbyvg5mkqm69zfw03gfkqhi9jnjlmlbg31y412";
    };

    sfntly = final.fetchgit {
      url = "https://chromium.googlesource.com/external/github.com/googlei18n/sfntly.git";
      rev = "b55ff303ea2f9e26702b514cf6a3196a2e3e2974";
      sha256 = "1qi5rfzmwfrji46x95g6dsb03i1v26700kifl2hpgm3pqhr7afpz";
    };
  };

  skia = final.stdenv.mkDerivation {
    pname = "skia";
    version = "aseprite-m102";

    src = final.fetchFromGitHub {
      owner = "aseprite";
      repo = "skia";
      # latest commit from aseprite-m102 branch
      rev = "861e4743af6d9bf6077ae6dda7274e5a136ee4e2";
      hash = "sha256-IlZbalmHl549uDUfPG8hlzub8TLWhG0EsV6HVAPdsl0=";
    };

    nativeBuildInputs = with final; [
      python3
      gn
      ninja
    ];

    buildInputs = with final; [
      fontconfig
      expat
      icu58
      libglvnd
      libjpeg
      libpng
      libwebp
      zlib
      mesa
      xorg.libX11
      harfbuzzFull
    ];

    preConfigure = with skia-dependencies; ''
      mkdir -p third_party/externals
      ln -s ${angle2} third_party/externals/angle2
      ln -s ${dng_sdk} third_party/externals/dng_sdk
      ln -s ${piex} third_party/externals/piex
      ln -s ${sfntly} third_party/externals/sfntly
    '';

    configurePhase = with final; ''
      runHook preConfigure
      gn gen out/Release --args="is_debug=false is_official_build=true extra_cflags=[\"-I${harfbuzzFull.dev}/include/harfbuzz\"]"
      runHook postConfigure
    '';

    buildPhase = ''
      runHook preBuild
      ninja -C out/Release skia modules
      runHook postBuild
    '';

    installPhase = ''
      mkdir -p $out
      # Glob will match all subdirs.
      shopt -s globstar
      # All these paths are used in some way when building aseprite.
      cp -r --parents -t $out/ \
        include/codec \
        include/config \
        include/core \
        include/effects \
        include/gpu \
        include/private \
        include/utils \
        include/third_party/skcms/*.h \
        out/Release/*.a \
        src/gpu/**/*.h \
        src/core/*.h \
        modules/skshaper/include/*.h \
        third_party/externals/angle2/include \
        third_party/skcms/**/*.h
    '';
  };
in
{
  # TODO: do i need lib.mkForce here?
  aseprite = final.stdenv.mkDerivation rec {
    pname = "aseprite";
    version = "1.2.40";

    src = final.fetchFromGitHub {
      owner = "aseprite";
      repo = "aseprite";
      rev = "v${version}";
      fetchSubmodules = true;
      hash = "sha256-KUdJA6HTAKrLT8xrwFikVDbc5RODysclcsEyQekMRZo";
    };

    nativeBuildInputs = with final; [
      cmake
      pkg-config
      ninja
    ];

    buildInputs = with final; [
      curl
      freetype
      giflib
      libjpeg
      libpng
      libwebp
      pixman
      tinyxml
      zlib
      xorg.libX11
      xorg.libXext
      xorg.libXcursor
      xorg.libXxf86vm
      cmark
      harfbuzzFull
      glib
      fontconfig
      pcre
      skia
      libGL
      xorg.libXi
    ];

    patches = [
      ./patches/aseprite/shared-libwebp.patch
      ./patches/aseprite/shared-skia-deps.patch
    ];

    postPatch = ''
      sed -i src/ver/CMakeLists.txt -e "s-set(VERSION \".*\")-set(VERSION \"$version\")-"
    '';

    cmakeFlags = [
      "-DENABLE_UPDATER=OFF"
      "-DUSE_SHARED_CURL=ON"
      "-DUSE_SHARED_FREETYPE=ON"
      "-DUSE_SHARED_GIFLIB=ON"
      "-DUSE_SHARED_JPEGLIB=ON"
      "-DUSE_SHARED_LIBPNG=ON"
      "-DUSE_SHARED_LIBWEBP=ON"
      "-DUSE_SHARED_PIXMAN=ON"
      "-DUSE_SHARED_TINYXML=ON"
      "-DUSE_SHARED_ZLIB=ON"
      "-DUSE_SHARED_CMARK=ON"
      "-DUSE_SHARED_HARFBUZZ=ON"
      "-DUSE_SHARED_WEBP=ON"
      # Disable libarchive programs.
      "-DENABLE_CAT=OFF"
      "-DENABLE_CPIO=OFF"
      "-DENABLE_TAR=OFF"
      # UI backend.
      "-DLAF_WITH_EXAMPLES=OFF"
      "-DLAF_OS_BACKEND=skia"
      "-DENABLE_DESKTOP_INTEGRATION=ON"
      "-DSKIA_DIR=${skia}"
      "-DSKIA_LIBRARY_DIR=${skia}/out/Release"
    ];
  };
}
  
