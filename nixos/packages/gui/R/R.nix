{ pkgs, ... }:

let
  rPackages = with pkgs.rPackages; [
    FinancialMath
    PerformanceAnalytics
    R_utils
    data_table
    ggplot2
    git2r
    gsheet
    htmlwidgets
    plotly
    readODS
    rmarkdown
  ];
in {
  environment.systemPackages = with pkgs; [
    (rstudioWrapper.override {
      packages = rPackages;
    })
    (rWrapper.override {
      packages = rPackages;
    })
  ];
}
