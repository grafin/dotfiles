{ config, pkgs, ... }:

{
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
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
            coc-python
            coc-spell-checker
            coc-yaml
            lightline-vim
            nerdtree
            nerdtree-git-plugin
            papercolor-theme
            vim-easytags
            vim-flake8
            vim-fugitive
            vim-lastplace
            vim-nix
            vim-obsession
            vim-polyglot
            vim-prosession
            vim-signify
            vim-tmux-focus-events
            vim-tmux-navigator
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
        let g:lightline = {'colorscheme': 'PaperColor',}

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

        autocmd FileType make set tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
        autocmd FileType cmake set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

        match ExtraWhitespace /\s\+\%#\@<!$/
        autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
        autocmd InsertLeave * match ExtraWhitespace /\s\+$/

        " vim-coc configuration
        " Use tab for trigger completion with characters ahead and navigate.
        " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
        inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Use <c-space> to trigger completion.
        inoremap <silent><expr> <c-space> coc#refresh()

        " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
        " Coc only does snippet and additional edit on confirm.
        inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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
  })];
}
