{ lib, mkWindowsApp, wine, fetchurl, unzip }:

mkWindowsApp rec {
  inherit wine;
  
  pname = "bosca-ceoil";
  version = "2";
  
  src = fetchurl {
    url = "http://www.boscaceoil.net/downloads/boscaceoil_win_v2.zip";
    sha256 = "sha256-jUnKsDFGH+aB9qqjp0FbqsJ8pTzInSPFhXJFlYPu9V0=";
  };
  
  dontUnpack = true;
  
  wineArch = "win64";
  
  buildInputs = [ unzip ];
  
  winAppInstall = ''
    d="$WINEPREFIX/drive_c/${pname}"
    
    mkdir -p "$d"
    unzip ${src} -d "$d"
  '';
  
  winAppRun = ''
    wine "$WINEPREFIX/drive_c/${pname}/BoscaCeoil.exe" "$ARGS"
  '';
  
  installPhase = ''
    runHook preInstall
    ln -s $out/bin/.launcher $out/bin/${pname}
    runHook postInstall
  '';
}
