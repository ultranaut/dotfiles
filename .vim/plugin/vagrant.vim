" Teach vim to syntax highlight Vagrantfile as ruby
"
" https://github.com/mitchellh/vagrant/blob/master/contrib/vim/vagrantfile.vim
"
" Install: $HOME/.vim/plugin/vagrant.vim
" Author: Brandon Philips <brandon@ifup.org>

augroup vagrant
  au!
  au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END
