{ config, pkgs, ... }:

{
  hardware.bluetooth.enable = true;

  # Steam Controller
  # This allows SC-Controller application and daemon to access Steam Controller or its USB dongle.
  # This is done by allowing read/write access to all users. You may want to change this to something like
  # MODE="0660", GROUP="games" to allow r/w access only to members of that group.
  services.udev.extraRules = ''
    # This rule is needed for basic functionality of the controller in Steam and keyboard/mouse emulation
    SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"
    # This rule is necessary for gamepad emulation
    KERNEL=="uinput", MODE="0660", GROUP="users", OPTIONS+="static_node=uinput"
    # Valve HID devices over USB hidraw
    KERNEL=="hidraw*", ATTRS{idVendor}=="28de", MODE="0666"
    # Valve HID devices over bluetooth hidraw
    KERNEL=="hidraw*", KERNELS=="*28DE:*", MODE="0666"
  '';
}
