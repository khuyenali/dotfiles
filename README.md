1. `git clone --bare git@github.com:khuyenali/dotfiles.git $HOME/.dotfiles`
2. add alias: `alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"`
3. `config checkout`, backup all conflict files
