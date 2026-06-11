{ osConfig, pkgs, ... }:

let
  runtimeInputs = with pkgs; [
    coreutils
    libnotify
    nautilus
    osConfig.programs.kdeconnect.package
    zenity
  ];

  findDevice = ''
    device_id="$(kdeconnect-cli --list-available --id-only | head -n 1)"

    if [[ -z "$device_id" ]]; then
      notify-send --urgency=critical "KDE Connect" "No connected phone found"
      exit 1
    fi
  '';

  browsePhone = pkgs.writeShellApplication {
    name = "kdeconnect-browse-phone";
    inherit runtimeInputs;
    text = ''
      ${findDevice}

      if ! kdeconnect-cli --device "$device_id" --mount; then
        notify-send --urgency=critical "KDE Connect" "Could not mount phone storage"
        exit 1
      fi

      mount_point=""
      for _ in $(seq 1 20); do
        mount_point="$(kdeconnect-cli --device "$device_id" --get-mount-point)"
        [[ -n "$mount_point" && -d "$mount_point" ]] && break
        sleep 0.25
      done

      if [[ -z "$mount_point" || ! -d "$mount_point" ]]; then
        notify-send --urgency=critical "KDE Connect" "Phone storage is not available"
        exit 1
      fi

      nautilus --new-window "$mount_point"
    '';
  };

  sendFile = pkgs.writeShellApplication {
    name = "kdeconnect-send-file";
    inherit runtimeInputs;
    text = ''
      ${findDevice}

      file="$(zenity --file-selection --title="Send File to Phone")" || exit 0

      if kdeconnect-cli --device "$device_id" --share "$file"; then
        notify-send "KDE Connect" "File sent to phone"
      else
        notify-send --urgency=critical "KDE Connect" "File transfer failed"
        exit 1
      fi
    '';
  };
in
{
  home.packages = [
    browsePhone
    sendFile
  ];
}
