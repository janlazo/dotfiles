function install_plugins()
  HandleCommand('plugin install comment fzf')
end

MakeCommand('PlugInstall', 'init.install_plugins', 0)
