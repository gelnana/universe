{
  home = {user, ...}: {
    programs.zen-browser.profiles.${user.name} = {
      containersForce = false;
      containers = {
        personal = {
          color = "blue";
          icon = "fingerprint";
          id = 1;
        };
        school = {
          color = "orange";
          icon = "briefcase";
          id = 2;
        };
      };
    };
  };
}
