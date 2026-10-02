{
  config,
  pkgs,
  ...
}:

let
  # onePassPath = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  onePassPath = "~/.1password/agent.sock";
  
  tomlFormat = pkgs.formats.toml { };
in
{
  programs.ssh = {
    enable = true;
    #enableDefaultConfig = false;
    extraConfig = ''
    Host *
      IdentityAgent ${onePassPath}
    '';
    #settings = {
    #  "Host *" = "IdentityAgent ${onePassPath}"
    #};
  };


  xdg.configFile."1Password/ssh/agent.toml".source = tomlFormat.generate "1password-ssh-agent.toml" {
    ssh-keys = [
      { vault = "Developer"; }
      { vault = "Fachschaft"; }
    ];
  };
}

