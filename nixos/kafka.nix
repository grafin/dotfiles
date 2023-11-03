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
    extraProperties = ''
      offsets.topic.replication.factor = 1
    '';
  };
}
