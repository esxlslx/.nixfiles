{ pkgs, ... }: { # Работа с виртуальными машинами
  
  virtualisation = {
    # podman.enable = true;
    # waydroid.enable = true;

    docker = {
      enable = true;
      rootless = {
        enable = true;
      };
    };
    
    spiceUSBRedirection.enable = true; # Connect USB devices to libvirt VMs, both local and remote.
    libvirtd = { # https://nixos.wiki/wiki/Libvirt
      enable = true;
      qemu.package = pkgs.qemu_full;
    };
  };

  # Network autostart - `virsh net-autostart default` в терминале
  programs.virt-manager.enable = true; # https://nixos.wiki/wiki/Virt-manager

  #################################################
  ## Это надо включить на виртуалке, не на хосте ##
  ## Позволяет работать virtio драйверу          ##
  ## Мб на хосте надо в терминал spice-vdagent   ##
  #################################################

  # The host must provide the needed virtio serial port under the special name org.qemu.guest_agent.0. 
  # https://wiki.libvirt.org/Qemu_guest_agent.html#setting-qemu-ga-up
  # Ниже xml код для qemu. Но не работает. Я не смог заставить работать виртуалку на virtio
  # <channel type='unix'>
  #  <source mode='bind' path='/var/lib/libvirt/qemu/f16x86_64.agent'/>
  #  <target type='virtio' name='org.qemu.guest_agent.0'/>
  # </channel>

   services = {
     openssh.enable = true; # Это ставится на виртуалку, чтоб к ней конект по ssh работал.
     spice-vdagentd.enable = true; # Clipboard sharing
     qemuGuest = {
       enable = true; # Fix resolution
       package = pkgs.qemu_full;
     };
   };
}
