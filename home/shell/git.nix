{
  programs.git = {
    enable = true;
    settings = {
      branch.autosetuprebase = "always";
      color.ui = true;
      core.askPass = "";
      init.defaultBranch = "main";
      github.user = "esxlslx";
      user = {
        name = "esxlslx";
        email = "mikumiku@beam" # Place with your real email, Hatsune Miku the best btw mikumiku@beam
      };
    };
    # aliases = {
		#   pu = "push";
    #   co = "checkout";
    #   cm = "commit";
    #   s = "status";
    # };
  };

  programs.gitui = { # Terminal UI
    enable = true;
  };
}
