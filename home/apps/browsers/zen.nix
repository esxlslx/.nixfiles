{ pkgs, inputs, ... }: { 
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  programs.zen-browser = {
  enable = true;
   profiles.falguren = {
      name = "falguren";
      /* isDefault = true;
      	extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        darkreader
        decentraleyes
        istilldontcareaboutcookies
        material-icons-for-github
        privacy-badger
        return-youtube-dislikes
        sponsorblock
        startpage-private-search
        ublock-origin
      ]; */
    }; 
  };
}
