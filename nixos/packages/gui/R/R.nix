{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (rstudioWrapper.override{
      packages = with rPackages; [
        FinancialMath
        PerformanceAnalytics
        data_table
        ggplot2
        gsheet
        readODS
        rmarkdown
      ];
    })
  ];
}
