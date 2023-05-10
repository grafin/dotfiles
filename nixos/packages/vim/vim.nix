{ config, pkgs, ... }:

let
  omnisharp-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "omnisharp-vim";
    version = "unstable-2022-04-05";
    src = pkgs.fetchFromGitHub {
      owner = "OmniSharp";
      repo = "omnisharp-vim";
      rev = "08d85b86978cb02d5faf3d266bf3fb233e98d463";
      sha256 = "0kdycajw21igkwzgfnp9kj8ksgw1xhg5l945bk1k0lcbsv5m5awk";
    };
    meta.homepage = "https://github.com/OmniSharp/omnisharp-vim";
  };
in {
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    nodejs-16_x
    (neovim.override {
      vimAlias = true;
      configure = {
        packages.myPlugins = with pkgs.vimPlugins; {
          start = [
            coc-cmake
            coc-css
            coc-go
            coc-html
            coc-json
            coc-nvim
            coc-pyright
            coc-snippets
            coc-spell-checker
            coc-tsserver
            coc-yaml
            copilot-vim
            lightline-vim
            nerdtree
            nerdtree-git-plugin
            omnisharp-vim
            papercolor-theme
            typescript-vim
            vim-easytags
            vim-flake8
            vim-fugitive
            vim-lastplace
            vim-nix
            vim-obsession
            vim-polyglot
            vim-prosession
            vim-signify
            vim-snippets
            vim-tmux-focus-events
            vim-tmux-navigator
            vimproc-vim
          ];
          opt = [];
        };
      customRC = ''
        set nocompatible
        filetype off

        set exrc
        set secure
        set encoding=utf-8
        set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
        set backspace=indent,eol,start
        set mouse=a

        set number
        set colorcolumn=80,120
        set signcolumn=yes
        highlight ColorColumn ctermbg=darkgray
        set noshowmode
        set laststatus=2
        let g:lightline = {"colorscheme": "PaperColor",}

        syntax on
        set t_Co=256
        autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
        set background=light
        colorscheme PaperColor

        set updatetime=100

        highlight link Flake8_Error      Error
        highlight link Flake8_Warning    WarningMsg
        highlight link Flake8_Complexity WarningMsg
        highlight link Flake8_Naming     WarningMsg
        highlight link Flake8_PyFlake    WarningMsg

        let g:flake8_show_in_gutter = 1
        let g:flake8_show_in_file = 1
        let g:flake8_show_quickfix = 1

        let g:NERDTreeDirArrowExpandable = ""
        let g:NERDTreeDirArrowCollapsible = ""
        let g:NERDTreeIgnore = ["__pycache__"]

        let g:easytags_async = 1

        let g:OmniSharp_server_path = "${omnisharp-roslyn}/src/OmniSharp.exe"
        let g:OmniSharp_log_dir = $HOME."/.local/share/omnisharp/log"
        let g:OmniSharp_server_use_mono = 1

        autocmd FileType c set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
        autocmd FileType cmake set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
        autocmd FileType cpp set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
        autocmd FileType css set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
        autocmd FileType golang set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
        autocmd FileType html set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
        autocmd FileType javascript set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
        autocmd FileType lua set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
        autocmd FileType make set tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
        autocmd FileType typescript set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

        match ExtraWhitespace /\s\+\%#\@<!$/
        autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
        autocmd InsertLeave * match ExtraWhitespace /\s\+$/

        " vim-coc configuration
        " Use tab for trigger completion with characters ahead and navigate.
        " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
        inoremap <silent><expr> <TAB>
              \ coc#pum#visible() ? coc#pum#next(1):
              \ <SID>check_back_space() ? "\<Tab>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Use <c-space> to trigger completion.
        inoremap <silent><expr> <c-space> coc#refresh()

        " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
        " Coc only does snippet and additional edit on confirm.
        " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>"

        " Configure github copilot
        let g:copilot_node_command = "${nodejs-16_x}/bin/node"

        " Split navigation
        map <C-j> <C-W>j
        map <C-k> <C-W>k
        map <C-h> <C-W>h
        map <C-l> <C-W>l

        " Use `[c` and `]c` to navigate diagnostics
        nmap <silent> [c <Plug>(coc-diagnostic-prev)
        nmap <silent> ]c <Plug>(coc-diagnostic-next)

        map <silent><expr> <F1> (&hls && v:hlsearch ? ":nohls" : ":set hls")."\n"
        map <silent> <F2> :NERDTreeToggle<CR>
        map <F3> <C-o>
        map <F4> <C-]>

        nmap <silent> <F5> <Plug>(coc-implementation)
        nmap <silent> <F6> <Plug>(coc-definition)
        nmap <silent> <F7> <Plug>(coc-references)
        nmap <silent> <F8> <Plug>(coc-type-definition)

        map <F9> :call flake8#Flake8()<CR>
        map <F10> :call flake8#Flake8ShowError()<CR>
        map <F11> :call flake8#Flake8UnplaceMarkers()<CR>
        set pastetoggle=<F12>
      '';
    };
  })
  mono
  neovim-remote
  nodePackages.typescript
  nodePackages.coc-tsserver
  omnisharp-roslyn
  sumneko-lua-language-server
  ];
}
