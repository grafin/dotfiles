{ config, pkgs, ... }:

{
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    ((vim_configurable.override { python = python3; }).customize{
      name = "vim";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [
          YouCompleteMe
          nerdtree
          nerdtree-git-plugin
          papercolor-theme
          vim-easytags
          vim-flake8
          vim-fugitive
          vim-fugitive
          vim-lastplace
          vim-nix
          vim-signify
          vim-tmux-focus-events
          vim-tmux-navigator
        ];
        opt = [];
      };
      vimrcConfig.customRC = ''
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
        highlight ColorColumn ctermbg=darkgray

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

        let g:ycm_key_list_stop_completion = ["<C-y>", "<TAB>"]

        let g:easytags_async = 1

        autocmd FileType make set tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
        autocmd FileType cmake set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

        match ExtraWhitespace /\s\+\%#\@<!$/
        autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
        autocmd InsertLeave * match ExtraWhitespace /\s\+$/

        " Split navigation
        map <C-j> <C-W>j
        map <C-k> <C-W>k
        map <C-h> <C-W>h
        map <C-l> <C-W>l

        map <silent><expr> <F1> (&hls && v:hlsearch ? ":nohls" : ":set hls")."\n"
        map <silent> <F2> :NERDTreeToggle<CR>
        map <F3> <C-o>
        map <F4> <C-]>
        map <F5> :YcmCompleter GoToInclude<CR>
        map <F6> :YcmCompleter GoToDefinition<CR>
        map <F7> :YcmCompleter GoToReferences<CR>
        map <F8> :YcmCompleter GetType<CR>
        map <F9> :call flake8#Flake8()<CR>
        map <F10> :call flake8#Flake8ShowError()<CR>
        map <F11> :call flake8#Flake8UnplaceMarkers()<CR>
        set pastetoggle=<F12>
      '';
    }
  )];
}
