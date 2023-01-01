
" lua require('lua.mine.completion')
" lua require('lua.mine.lsp_config')


" Move line up and down.

nnoremap K :m .-2<CR>==
nnoremap J :m .+2<CR>==
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+2<CR>gv=gv


set number 		  " For line number in vim 
set tabstop=4             " How many spaces to enter for each tab
syntax on 
"colorscheme delek
set incsearch  " Search as you type
set shiftwidth=2  " How many spaces to indent code blocks
filetype on " detect file type
filetype indent on " indentation according to file type
set mouse=a
set hlsearch              " Highlight matches while searching
set background=dark       " Turn dark mode on
hi clear CursorLine
augroup CLClear
  autocmd! ColorScheme * hi clear CursorLine
augroup END
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey
set cursorline
" set clipboard=unnamedplus
vmap <C-c> "+y


" Show status line
"set laststatus=2
"set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"
set showcmd
" Don’t keep results highlighted after searching...
set nohlsearch
" ...just highlight as we type
"


" plugins
call plug#begin()

Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/preservim/nerdtree' " sidebar files tree
Plug 'https://github.com/tpope/vim-commentary' " commenting
Plug 'https://github.com/tpope/vim-surround' " surrounding qutoes, tags, etc
Plug 'https://github.com/tc50cal/vim-terminal' " vim terminal
Plug 'https://github.com/ryanoasis/vim-devicons' " some dev icons 
Plug 'https://github.com/dylanaraps/wal.vim' " pywal colorscheme
Plug 'https://github.com/neoclide/coc.nvim' " autocomepletion
Plug 'https://github.com/preservim/tagbar' " right side tagbar 
Plug 'https://github.com/junegunn/fzf.vim' " vim fzf 
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'williamboman/mason.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/vim-vsnip'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter' 
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

call plug#end()


" tabedit

set stal=2
set showtabline=1
highlight link TabNum Special
nnoremap <C-i> :tabnext<CR>
map <S-Tab> gt
set guitablabel=\[%N\]\ %t\ %M


" Airline 

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='wal'


" vim-terminal
nnoremap <C-l> :TerminalSplit zsh<CR>


" Autocompletion

"inoremap <expr><TAB> coc#pum#visible() ? coc#_select_confirm() : "<Tab>"
" inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"


" Vim fzf 

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
nnoremap <C-f> :Files ~/<CR>


" NerdTree -

let g:NERDSpaceDelims = 1 
let g:NERDTreeWinSize=get(g:,'NERDTreeWinSize', 25)
let g:NERDTreeChDirMode=get(g:,'NERDTreeChDirMode',1)
let g:NERDTreeShowHidden =1 
"let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
	  \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif




" Autocompletion	

lua << EOF

local cmp = require("cmp")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
mapping = cmp.mapping.preset.insert({
['<C-b>'] = cmp.mapping.scroll_docs(-4),
['<C-bb>'] = cmp.mapping.scroll_docs(4),
['<C-o>'] = cmp.mapping.complete(),
['<C-e>'] = cmp.mapping.abort(),
['<TAB>'] = cmp.mapping.confirm({ select = true }),
}),
snippet = {
  expand = function(args)
  require('luasnip').lsp_expand(args.body)
  end,
},
sources = cmp.config.sources({
{ name = 'nvim_lsp' },
{ name = 'luasnip' },
}, {
  { name = 'buffer' },
}),
})

EOF

" g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
let g:neovide_transparency = 0.0
let g:transparency = 70.8
let g:neovide_background_color = '#0f1117'.printf('%x', float2nr(255 * g:transparency))



" telescope 
nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fg <cmd>Telescope live_grep<cr>
lua require('core.telescope')
" set TelescopeColor = wal
