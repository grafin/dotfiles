{ pkgs, ... }:

let
  alsa-lib-patched = pkgs.alsa-lib.overrideAttrs(
    attrs: {
      patches = attrs.patches ++ [ ./patches/alsa-lib/midi-fix.patch ];
    }
  );
  reaper-fixed = pkgs.reaper.override {
    alsa-lib = alsa-lib-patched;
  };
in {
  environment.systemPackages = with pkgs; [
    ams-lv2
    artyFX
    calf
    carla
    eq10q
    fomp
    guitarix
    helm
    infamousPlugins
    lmms
    mda_lv2
    qmidiarp
    reaper-fixed
    samplv1
    setbfree
    sorcer
    swh_lv2
    synthv1
    talentedhack
    vocproc
    x42-avldrums
    x42-gmsynth
    x42-plugins
    yabridge
    yabridgectl
  ];
}
