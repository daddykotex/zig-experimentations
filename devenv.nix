{ pkgs, ... }:

{
  packages = [ pkgs.git ];

  languages.zig.enable = true;
}
