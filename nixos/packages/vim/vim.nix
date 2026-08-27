{ config, pkgs, ... }:

let
  python3Env = pkgs.python3.withPackages (ps: with ps; [ pynvim ]);


#  remote-nvim = pkgs.vimUtils.buildVimPlugin {
#    pname = "remote-nvim";
#    version = "unstable-2024-12-16";
#    src = pkgs.fetchFromGitHub {
#      owner = "amitds1997";
#      repo = "remote-nvim.nvim";
#      rev = "ffbf91f6132289a8c43162aba12c7365c28d601c";
#      sha256 = "00phk7jgg1hrr3vrr5k19kx1a23srwxiqf3nl6gn4v9f7kn900pj";
#    };
#    meta.homepage = "https://github.com/amitds1997/remote-nvim.nvim";
#    dontPatchShebangs = true;
#  };

in {
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    nodejs
    (neovim.override {
      vimAlias = true;
      withPython3 = true;
      extraPython3Packages = ps: with ps; [ pynvim ];
      configure = {
        packages.myPlugins = with pkgs.vimPlugins; {
          start = [
            CopilotChat-nvim
            coc-cmake
            coc-css
            coc-html
            coc-json
            # coc-lua removed: manages own server install, bad for NixOS
            coc-nvim
            coc-pyright
            coc-rust-analyzer
            coc-snippets
            coc-spell-checker
            coc-yaml
            copilot-vim
            lightline-vim
            lsp_lines-nvim
            nerdtree
            nerdtree-git-plugin
            # nui-nvim # remote-nvim dependencie
            nvim-gdb
            nvim-jqx
            papercolor-theme
            # plenary-nvim # remote-nvim dependencie
            # remote-nvim
            # telescope-nvim # remote-nvim dependencie
            typescript-vim
            vim-fugitive
            vim-go
            vim-lastplace
            vim-nix
            vim-obsession
            # vim-polyglot # removed: conflicts with Neovim 0.11 built-in filetype.lua
            vim-prosession
            vim-signify
            vim-snippets
            vim-tmux-focus-events
            vim-tmux-navigator
          ];
          opt = [];
        };
      customLuaRC = ''
        vim.g.python3_host_prog = '${python3Env}/bin/python3'

        -- @TODO require("remote-nvim").setup()
        require("CopilotChat").setup({
          mappings = {
            complete = {
              insert = '<Tab>',
            },
            close = {
              normal = 'q',
              insert = '<C-c>',
            },
            reset = {
              normal = '<C-r>',
              insert = '<C-r>',
            },
            submit_prompt = {
              normal = '<CR>',
              insert = '<C-s>',
            },
            toggle_sticky = {
              detail = 'Makes line under cursor sticky or deletes sticky line.',
              normal = 'gr',
            },
            accept_diff = {
              normal = '<C-y>',
              insert = '<C-y>',
            },
            jump_to_diff = {
              normal = 'gj',
            },
            quickfix_diffs = {
              normal = 'gq',
            },
            yank_diff = {
              normal = 'gy',
              register = '"',
            },
            show_diff = {
              normal = 'gd',
            },
            show_info = {
              normal = 'gi',
            },
            show_context = {
              normal = 'gc',
            },
            show_help = {
              normal = 'gh',
            },
          },
        })
      '';
      customRC = ''
        set exrc
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
        set notermguicolors
        autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
        set background=light
        colorscheme PaperColor

        set updatetime=100

        let g:NERDTreeDirArrowExpandable = ""
        let g:NERDTreeDirArrowCollapsible = ""
        let g:NERDTreeIgnore = ["__pycache__"]

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
        let g:copilot_node_command = "${nodejs}/bin/node"
        " let g:copilot_proxy = "localhost:1337"

        " Split navigation
        map <C-j> <C-W>j
        map <C-k> <C-W>k
        map <C-h> <C-W>h
        map <C-l> <C-W>l

        " Use `[c` and `]c` to navigate diagnostics
        nmap <silent> ]c :call CocAction('diagnosticNext')<cr>
        nmap <silent> [c :call CocAction('diagnosticPrevious')<cr>

        map <silent><expr> <F1> (&hls && v:hlsearch ? ":nohls" : ":set hls")."\n"
        map <silent> <F2> :NERDTreeToggle<CR>
        map <F3> <C-o>
        map <F4> <C-]>

        nmap <silent> <F5> <Plug>(coc-implementation)
        nmap <silent> <F6> <Plug>(coc-definition)
        nmap <silent> <F7> <Plug>(coc-references)
        nmap <silent> <F8> <Plug>(coc-type-definition)
        nmap <silent> <F9> :CocDiagnostics<CR>
        nmap <F10> <Plug>(coc-rename)
        nmap <F11> <Plug>(coc-codelens-action)

        " Declarative coc.nvim configuration via nix store paths
        autocmd VimEnter * call coc#config('diagnostic-languageserver.filetypes', {'dockerfile': 'hadolint'})
        autocmd VimEnter * call coc#config('snippets.ultisnips.pythonPrompt', v:false)
        autocmd VimEnter * call coc#config('rust-analyzer.server.path', '${rust-analyzer}/bin/rust-analyzer')
        autocmd VimEnter * call coc#config('languageserver.ccls', {
              \ 'command': '${ccls}/bin/ccls',
              \ 'filetypes': ['c', 'cc', 'cpp', 'objc', 'objcpp'],
              \ 'rootPatterns': ['.ccls', 'compile_commands.json', '.git/', '.hg/'],
              \ 'initializationOptions': {
              \   'cache': {'directory': '/tmp/ccls'},
              \   'client': {'snippetSupport': v:true}
              \ }
              \ })
        autocmd VimEnter * call coc#config('languageserver.golang', {
              \ 'command': '${gopls}/bin/gopls',
              \ 'rootPatterns': ['go.mod', '.vim/', '.git/', '.hg/'],
              \ 'filetypes': ['go']
              \ })
        autocmd VimEnter * call coc#config('languageserver.typescript', {
              \ 'command': '${typescript-language-server}/bin/typescript-language-server',
              \ 'args': ['--stdio'],
              \ 'filetypes': ['typescript', 'typescriptreact', 'javascript', 'javascriptreact'],
              \ 'rootPatterns': ['tsconfig.json', 'jsconfig.json', 'package.json', '.git/']
              \ })
        autocmd VimEnter * call coc#config('languageserver.lua', {
              \ 'command': '${lua-language-server}/bin/lua-language-server',
              \ 'filetypes': ['lua'],
              \ 'rootPatterns': ['.luarc.json', '.git/'],
              \ 'settings': {
              \   'Lua': {
              \     'runtime': {'version': 'LuaJIT'},
              \     'workspace': {'library': []}
              \   }
              \ }
              \ })

        " nvim-gdb
        function! NvimGdbNoTKeymaps()
          tnoremap <silent> <buffer> <esc> <c-\><c-n>
        endfunction

        let g:nvimgdb_config_override = {
          \ 'key_next': 'n',
          \ 'key_step': 's',
          \ 'key_finish': 'f',
          \ 'key_continue': 'c',
          \ 'key_until': 'u',
          \ 'key_breakpoint': 'b',
          \ 'set_tkeymaps': "NvimGdbNoTKeymaps",
          \ }
      '';
    };
  })
  gopls
  hadolint
  neovim-remote
  typescript
  typescript-language-server
  rr
  rust-analyzer
  lua-language-server
  ];

  environment.pathsToLink = [
    "/share/lua-language-server"
  ];
}
