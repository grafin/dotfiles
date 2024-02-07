{ ... }:

{
  services.zookeeper = {
    enable = true;
    extraConf = ''
      admin.enableServer=false
    '';
  };
  services.apache-kafka = {
    enable = true;
    settings = {
      "offsets.topic.replication.factor" = 1;
      "log.dirs" = [ "/tmp/apache-kafka" ];
    };
  };
}
