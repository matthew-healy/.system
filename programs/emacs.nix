{ ... }: {
  emacs = {
    enable = true;

    extraConfig = ''
      (setq backup-directory-alist
        `(("." . ,(expand-file-name
                    (concat user-emacs-directory "backups")))))

      (setq backup-by-copying-when-linked t)

      (add-hook 'prog-mode-hook 'display-line-numbers-mode)

      (set-face-attribute 'default nil :height 140)
    '';
  };
}
