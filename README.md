# NixOS configuration

## Install NixOS
1. Boot into nixos minimal live cd

   [latest-nixos-minimal-x86_64-linux.iso](https://channels.nixos.org/nixos-23.11/latest-nixos-minimal-x86_64-linux.iso)

2. Preparation to install
    ```shell
    sudo su
    loadkeys hu101
    ```
3. Clone nixos configuration
    ```shell
    nix-shell -p git 
    git clone https://github.com/devbysp/nixos
    ```
4. Format hard disk
    ```shell
    nixos/.install/format --hdd /dev/sda
    ```
5. Install nixos
    ```shell
    nixos/.install/install --machine nixos
    ```
6. Reboot
    ```shell
    reboot
    ```
7. Configure home
    ```shell
    git clone https://github.com/devbysp/nixos
    home-manager switch --flake ./nixos
    ```

## Update NixOS

```shell
sudo nixos-rebuild switch --flake .#development
```

## Update Home Manager
```shell
home-manager switch --flake .#magyariz
```

### Generate hashed password
```shell
mkpasswd -m sha-512 'password'
```

