" Brief help
"  PlugInstall [name ...] [#threads]  Install plugins
"  PlugUpdate [name ...] [#threads]  Install or update plugins
"  PlugClean[!]  Remove unlisted plugins (bang version will clean without prompt)
"  PlugUpgrade Upgrade vim-plug itself
"  PlugStatus  Check the status of plugins
"  PlugDiff  Examine changes from the previous update and the pending changes
"  PlugSnapshot[!] [output path] Generate script for restoring the current snapshot of the plugins"

" Set filetypes for vimplug
autocmd BufNewFile,BufRead *.ipynb setf ipynb

call plug#begin('~/.vim/plugged')

"" Some plugins for workflow.

" Pretty
Plug 'NLKNguyen/papercolor-theme'
Plug 'powerline/powerline-fonts'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'

" Background
Plug 'skywind3000/asyncrun.vim'

" Bad habits
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Productivity
Plug 'terryma/vim-multiple-cursors'
Plug 'SirVer/ultisnips', { 'for': ['tex', 'markdown', 'snippets'] }

" Markdown
Plug 'gabrielelana/vim-markdown', { 'for': ['tex', 'markdown'] }
Plug 'lervag/vimtex', { 'for': ['tex'] }
Plug 'KeitaNakamura/tex-conceal.vim', { 'for': ['tex', 'markdown'] }
Plug 'preservim/vim-pencil', { 'for': ['tex', 'markdown'] }
Plug 'rhysd/vim-grammarous', { 'for': ['tex', 'markdown'] }
Plug 'AnotherGroupChat/citation.vim', { 'for': ['tex', 'markdown'], 'branch': 'denite'}
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins',  'for': ['markdown', 'tex'] }

" Zen
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }

" I think I might be in love with @junegunn
" View registers before usage
Plug 'junegunn/vim-peekaboo'

" Cpp
Plug 'gilligan/vim-lldb', { 'on': 'Lattach' }
Plug 'dense-analysis/ale', { 'for' : 'cpp' }

" Rhai
Plug 'https://git.goyman.com/kuon/rhai.vim.git', { 'for': 'rhai', 'branch': 'main'}

" Git!
" Plug 'tpope/vim-fugitive'

" Nix'ed
Plug 'LnL7/vim-nix'

" Elixir
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }

" Jupyter
Plug 'szymonmaszke/vimpyter', { 'for': 'ipynb' }

" Edit binary data in hex
Plug 'fidian/hexmode'

" Protobuf
Plug 'wfxr/protobuf.vim'
Plug 'cybrown-zoox/vim-pbtxt'

" All hail our AI overlord
Plug 'github/copilot.vim', {'branch': 'main'}

" Maktaba + Glaive for code formatting
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'lpenz/vim-codefmt-haskell', { 'for': 'haskell' }

" All of your Plugins must be added before the following line
call plug#end()            " required
call glaive#Install()
