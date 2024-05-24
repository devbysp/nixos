# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, stateVersion, device, hostname, timezone, locale_citizenship, locale_nationality, 
  windowManager, keymap, keyboardLayout, username, fullName, autoLogin, ... }:

let
  isGnomeWindowManager = (windowManager == "gnome");
in

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = device;
  boot.loader.grub.useOSProber = true;

  networking.hostName = hostname; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = locale_nationality;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = locale_citizenship;
    LC_IDENTIFICATION = locale_nationality;
    LC_MEASUREMENT = locale_nationality;
    LC_MONETARY = locale_citizenship;
    LC_NAME = locale_nationality;
    LC_NUMERIC = locale_nationality;
    LC_PAPER = locale_nationality;
    LC_TELEPHONE = locale_citizenship;
    LC_TIME = locale_nationality;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = isGnomeWindowManager;
  services.xserver.desktopManager.gnome.enable = isGnomeWindowManager;

  # Configure keymap in X11
  services.xserver = {
    layout = keyboardLayout;
    xkbVariant = keymap;
  };

  # Configure console keymap
  console.keyMap = keyboardLayout;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Shells
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh bash ];

  # List packages installed in the system profile.
  environment.systemPackages = with pkgs; [ zsh git neovim home-manager ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.${username} = {
      isNormalUser = true;
      description = fullName;
      hashedPassword = "$6$PLahWm2.bhzuU3e1$bov.myBOD66qyR7Iduf2MZ0XAI0yKO0oqhbzlwlCqfeyqY/7uU3UbK2OdWmc/mRxSaeBeijxWEemeRwymNaDt/";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
    };
    defaultUserShell = pkgs.zsh;
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = autoLogin;
  services.xserver.displayManager.autoLogin.user = username;

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = stateVersion; # Did you read the comment?

  # Enabling flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
