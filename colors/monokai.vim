" A lot of this was copied more or less directly from ayu-theme/ayu-vim
" and a lot of it was repurposed to fit

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "monokai"

" Palette ------------------------------------------------------------------ {{{
let s:none      = {'hex':"NONE",'cterm':"NONE"}

let s:bg0       = {'hex':"#272822",'cterm':00}
let s:bg1       = {'hex':"#3e3d32",'cterm':08}
let s:bg2       = {'hex':"#64635a",'cterm':08}

let s:red       = {'hex':"#f92672",'cterm':01}
let s:orange    = {'hex':"#fd9714",'cterm':09}

let s:green     = {'hex':"#a6e22e",'cterm':02}
let s:turquoise = {'hex':"#30d5c8",'cterm':10} " madeup

let s:amber     = {'hex':"#e69f66",'cterm':03} " light-orange
let s:yellow    = {'hex':"#e6db74",'cterm':11}

let s:blue      = {'hex':"#66d9ef",'cterm':04}
let s:blue      = {'hex':"#6a14a91",'cterm':04}

let s:magenta   = {'hex':"#fd5ff0",'cterm':05}
let s:rose      = {'hex':"#fc9d9a",'cterm':13} " madeup

let s:cyan      = {'hex':"#a1efe4",'cterm':06}

let s:fg0       = {'hex':"#f8f8f2",'cterm':07}
let s:fg1       = {'hex':"#cfcfc2",'cterm':15}
let s:fg2       = {'hex':"#75715e",'cterm':15} " comment

let s:palette = {}

" Expand this to support { 'gui'=HEX, 'cterm'=256 }
let s:palette.bg        = s:bg0
let s:palette.comment   = s:fg2
let s:palette.markup    = s:amber
let s:palette.constant  = s:yellow
let s:palette.tag       = s:blue
let s:palette.regexp    = s:turquoise
let s:palette.string    = s:green
let s:palette.function  = s:yellow
let s:palette.special   = s:rose
let s:palette.keyword   = s:orange

let s:palette.error     = s:red
let s:palette.accent    = s:orange
let s:palette.panel     = s:bg1
let s:palette.line      = s:bg1
let s:palette.guide     = s:bg2
let s:palette.fg        = s:fg0
let s:palette.fg_idle   = s:fg1
let s:palette.selection = s:fg2

function! s:build_prim(hi_elem, field)
  let l:vname = "s:" . a:hi_elem . "_" . a:field
  let l:gui_assign = "gui".a:hi_elem."=".s:palette[a:field]["hex"]
  let l:cterm_assign = "cterm".a:hi_elem."=".s:palette[a:field]["cterm"]
  exe "let " . l:vname . " = ' " . l:gui_assign . "'"
endfunction

let s:bg_none = ' guibg=NONE ctermbg=NONE'
let s:fg_none = ' guifg=NONE ctermfg=NONE'
for [key_name, d_value] in items(s:palette)
  call s:build_prim('bg', key_name)
  call s:build_prim('fg', key_name)
endfor
" }}}

" Formatters --------------------------------------------------------------- {{{
let s:none   = "NONE"
let s:t_none = "NONE"
let s:n      = "NONE"
let s:c      = ",undercurl"
let s:r      = ",reverse"
let s:s      = ",standout"
let s:b      = ",bold"
let s:u      = ",underline"
let s:i      = ",italic"

exe "let s:fmt_none = ' gui=NONE".          " cterm=NONE".          " term=NONE"        ."'"
exe "let s:fmt_bold = ' gui=NONE".s:b.      " cterm=NONE".s:b.      " term=NONE".s:b    ."'"
exe "let s:fmt_bldi = ' gui=NONE".s:b.      " cterm=NONE".s:b.      " term=NONE".s:b    ."'"
exe "let s:fmt_undr = ' gui=NONE".s:u.      " cterm=NONE".s:u.      " term=NONE".s:u    ."'"
exe "let s:fmt_undb = ' gui=NONE".s:u.s:b.  " cterm=NONE".s:u.s:b.  " term=NONE".s:u.s:b."'"
exe "let s:fmt_undi = ' gui=NONE".s:u.      " cterm=NONE".s:u.      " term=NONE".s:u    ."'"
exe "let s:fmt_curl = ' gui=NONE".s:c.      " cterm=NONE".s:c.      " term=NONE".s:c    ."'"
exe "let s:fmt_ital = ' gui=NONE".s:i.      " cterm=NONE".s:i.      " term=NONE".s:i    ."'"
exe "let s:fmt_stnd = ' gui=NONE".s:s.      " cterm=NONE".s:s.      " term=NONE".s:s    ."'"
exe "let s:fmt_revr = ' gui=NONE".s:r.      " cterm=NONE".s:r.      " term=NONE".s:r    ."'"
exe "let s:fmt_revb = ' gui=NONE".s:r.s:b.  " cterm=NONE".s:r.s:b.  " term=NONE".s:r.s:b."'"
" }}}

" Vim Highlighting: (see :help highlight-groups) --------------------------- {{{

exe "hi! Normal"        .s:fg_fg          .s:bg_bg          .s:fmt_none
exe "hi! ColorColumn"   .s:fg_none        .s:bg_line        .s:fmt_none
" comment
exe "hi! PreProc"       .s:fg_tag         .s:bg_none        .s:fmt_none
exe "hi! Comment"       .s:fg_comment     .s:bg_none        .s:fmt_none
" function
exe "hi! Function"      .s:fg_function    .s:bg_none        .s:fmt_none
" string, regexp
exe "hi! String"        .s:fg_string      .s:bg_none        .s:fmt_none
" keyword
exe "hi! Keyword"       .s:fg_keyword     .s:bg_none        .s:fmt_none
exe "hi! Statement"     .s:fg_keyword     .s:bg_none        .s:fmt_none
" markup
" constant
" tag
" error
" accent
" panel
" line
" guide
" fg
" fg_idle
" selection
"
" Conceal, Cursor, CursorIM
exe "hi! CursorColumn"  .s:fg_none        .s:bg_line        .s:fmt_none
exe "hi! CursorLine"    .s:fg_none        .s:bg_line        .s:fmt_undr
exe "hi! CursorLineNr"  .s:fg_accent      .s:bg_line        .s:fmt_none
exe "hi! LineNr"        .s:fg_guide       .s:bg_none        .s:fmt_none
exe "hi! Directory"     .s:fg_fg_idle     .s:bg_none        .s:fmt_none
exe "hi! DiffAdd"       .s:fg_string      .s:bg_panel       .s:fmt_none
exe "hi! DiffChange"    .s:fg_tag         .s:bg_panel       .s:fmt_none
exe "hi! DiffText"      .s:fg_fg          .s:bg_panel       .s:fmt_none
exe "hi! ErrorMsg"      .s:fg_fg          .s:bg_error       .s:fmt_stnd
exe "hi! VertSplit"     .s:fg_bg          .s:bg_none        .s:fmt_none
exe "hi! Folded"        .s:fg_fg_idle     .s:bg_panel       .s:fmt_none
exe "hi! FoldColumn"    .s:fg_none        .s:bg_panel       .s:fmt_none
exe "hi! SignColumn"    .s:fg_none        .s:bg_panel       .s:fmt_none
"   Incsearch"
exe "hi! MatchParen"    .s:fg_fg          .s:bg_bg          .s:fmt_undr
exe "hi! ModeMsg"       .s:fg_string      .s:bg_none        .s:fmt_none
exe "hi! MoreMsg"       .s:fg_string      .s:bg_none        .s:fmt_none
exe "hi! NonText"       .s:fg_guide       .s:bg_none        .s:fmt_none
exe "hi! Pmenu"         .s:fg_fg          .s:bg_selection   .s:fmt_none
exe "hi! PmenuSel"      .s:fg_fg          .s:bg_selection   .s:fmt_revr
"   PmenuSbar"
"   PmenuThumb"
exe "hi! Question"      .s:fg_string      .s:bg_none        .s:fmt_none
exe "hi! Search"        .s:fg_bg          .s:bg_constant    .s:fmt_none
exe "hi! SpecialKey"    .s:fg_selection   .s:bg_none        .s:fmt_none
exe "hi! SpellCap"      .s:fg_tag         .s:bg_none        .s:fmt_undr
exe "hi! SpellLocal"    .s:fg_keyword     .s:bg_none        .s:fmt_undr
exe "hi! SpellBad"      .s:fg_error       .s:bg_none        .s:fmt_undr
exe "hi! SpellRare"     .s:fg_regexp      .s:bg_none        .s:fmt_undr
exe "hi! StatusLine"    .s:fg_fg          .s:bg_panel       .s:fmt_none
exe "hi! StatusLineNC"  .s:fg_fg_idle     .s:bg_panel       .s:fmt_none
exe "hi! WildMenu"      .s:fg_bg          .s:bg_markup      .s:fmt_none
exe "hi! TabLine"       .s:fg_fg          .s:bg_panel       .s:fmt_revr
"   TabLineFill"
"   TabLineSel"
exe "hi! Title"         .s:fg_keyword     .s:bg_none        .s:fmt_none
exe "hi! Visual"        .s:fg_none        .s:bg_selection   .s:fmt_none
"   VisualNos"
exe "hi! WarningMsg"    .s:fg_error       .s:bg_none        .s:fmt_none
" }}}
