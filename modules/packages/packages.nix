{ self, inputs, ... }: {
  flake.nixosModules.packages = { pkgs, lib, ... }: {
    environment.systemPackages = with pkgs; [

      # Core CLI 
      git
      wget
      curl
      kitty
      neovim
      btop
      fastfetch
      eza
      fzf

      # Archive & Compression 
      zip
      unzip
      p7zip        
      unrar
      rsync    

      # File & Search
      ripgrep        
      fd             
      bat          
      file        
      tree          
      tokei    
      qdirstat

      # Data Processing
      jq             
      yq-go     

      # System & Disk 
      duf            
      ncdu       

      # Hardware & Diagnostik
      pciutils       
      usbutils       
      dmidecode      
      lm_sensors     
      smartmontools  
      hwinfo         
      powertop       
      acpi           

      # Filesystem & Drive
      exfatprogs     
      ntfs3g         
      dosfstools     

      # Terminal & Productivity
      zellij         
      lazygit        
      tealdeer      
      man-db        
      zoxide         
      just           
      shellcheck     
      shfmt          

      # Git & Diagnosa
      gh             
      git-lfs        
      delta          
      lsof           
      strace         
      sysstat        

      # Network & Security
      openssh
      mtr           
      whois

      # Enkripsi
      gnupg
      age            

      # Wayland & Desktop Integration 
      wl-clipboard
      cliphist
      bibata-cursors
      playerctl
      brightnessctl
      nwg-displays
      fuzzel
      ddcutil
      libnotify
      networkmanagerapplet
      qalculate-gtk
      xdg-user-dirs
      seahorse
      grim
      slurp
      satty
      wl-clip-persist
      xdg-utils

      # Audio 
      pavucontrol

      # Multimedia
      mpv            
      imv            
      kdePackages.okular
      ffmpeg         
      yt-dlp         

      # Document
      poppler-utils  
      qpdf              
      simple-scan    
      system-config-printer 

      # KDE 
      kdePackages.dolphin
      kdePackages.konsole
      kdePackages.kio-extras
      kdePackages.kio-admin
      kdePackages.ark
      kdePackages.breeze-icons
      kdePackages.breeze
      kdePackages.plasma-integration
      kdePackages.polkit-kde-agent-1
      kdePackages.qqc2-desktop-style
      kdePackages.qtsvg

      # Dev Build Tools & Debugger
      gcc         
      clang         
      cmake
      gnumake
      meson
      ninja
      pkg-config
      gdb
      lldb
      valgrind       
      binutils
      direnv        

      # Dev: Python 
      python3      
      uv             

      # Dev: Node
      nodejs        
      pnpm          
      bun          

      # Dev: C# / .NET 
      dotnet-sdk    

      # Dev: Java 
      jdk          
      maven
      gradle

      # Dev: Fortran
      gfortran       
      openmpi        

      # Dev: Database 
      dbeaver-bin  
      bruno         

      # Security & Network  
      nmap
      wireshark      
      tcpdump
      netcat-openbsd 
      rustscan       

      # Dev: Rust 
      rustc          
      cargo          
      rust-analyzer  
      clippy         
      rustfmt        

      # Dev: Go
      go             
      gopls          

      # GUI Applications
      antigravity-ide
      equibop

    ] ++ [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      (inputs.pixie-sddm.packages.${pkgs.stdenv.hostPlatform.system}.pixie-sddm.override {
        background = ../../assets/sddm/wallpaper.jpg;
        avatar = ../../assets/sddm/avatar.jpg;
      })
    ];
  };
}
