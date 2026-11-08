{ lib, ... }:
{
  home.username = "shiend";
  home.homeDirectory = "/home/shiend";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  xdg.enable = true;
  xdg.configFile."fish/config.fish".source = ./fish/config.fish;
  xdg.configFile."kitty/kitty.conf".source = ./kitty/kitty.conf;

  home.activation.niriConfig = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    niri_dir="''${XDG_CONFIG_HOME:-$HOME/.config}/niri"
    niri_backup="''${niri_dir}.hm-backup"

    if [ -L "$niri_dir" ]; then
      rm -- "$niri_dir"
    fi

    if [ -d "$niri_backup" ] && [ ! -L "$niri_backup" ]; then
      if [ ! -e "$niri_dir" ]; then
        mv -- "$niri_backup" "$niri_dir"
      else
        mkdir -p "$niri_dir"
        cp -a -n "$niri_backup/." "$niri_dir/"
      fi
    fi

    mkdir -p "$niri_dir"
    install_if_missing() {
      source="$1"
      target="$2"
      if [ -L "$target" ]; then
        rm -- "$target"
      fi
      if [ ! -e "$target" ]; then
        install -Dm 644 "$source" "$target"
      fi
    }
    install_if_missing ${./niri/config.kdl} "$niri_dir/config.kdl"
    install_if_missing ${./niri/exec.kdl} "$niri_dir/exec.kdl"
    install_if_missing ${./niri/input.kdl} "$niri_dir/input.kdl"
    install_if_missing ${./niri/keybinds.kdl} "$niri_dir/keybinds.kdl"
    install_if_missing ${./niri/layout.kdl} "$niri_dir/layout.kdl"
    install_if_missing ${./niri/rules.kdl} "$niri_dir/rules.kdl"
    install_if_missing ${./niri/monitor.kdl} "$niri_dir/monitor.kdl"
    install_if_missing ${./niri/noctalia.kdl} "$niri_dir/noctalia.kdl"
  '';

  home.activation.starshipConfig = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    starship_config="''${XDG_CONFIG_HOME:-$HOME/.config}/starship.toml"
    if [ ! -e "$starship_config" ]; then
      install -Dm 644 ${./starship/starship.toml} "$starship_config"
    fi
  '';

  home.activation.noctaliaSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    state_dir="''${XDG_STATE_HOME:-$HOME/.local/state}/noctalia"
    settings="$state_dir/settings.toml"
    if [ ! -e "$settings" ]; then
      mkdir -p "$state_dir"
      install -m 644 ${./noctalia/settings.toml} "$settings"
    fi
  '';
}
