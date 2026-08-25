{ ... }:

{
  services.fprintd.enable = true;

  # Noctalia talks to fprintd directly on the lock screen. Do not enable
  # fprintAuth for the PAM "login" stack: Noctalia 5 uses that stack for the
  # password fallback and would wait for a second fingerprint transaction.
  security.pam.services = {
    greetd.fprintAuth = true;
    sudo.fprintAuth = true;
  };
}
