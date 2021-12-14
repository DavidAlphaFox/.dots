set DOTFILES /home/dylan/.dotfiles
function snix
  cd $DOTFILES;
  if test (count $argv) -eq 0
    sudo nixos-rebuild switch -j auto --flake ".#"
  else
    sudo nixos-rebuild $argv[1] -j auto --flake ".#"
  end
  cd -;
end

complete -f -c snix -a 'build test boot switch'
