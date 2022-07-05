
# VIM CHEATSHEET
By: Theodor Blom
for my personal .vimrc

## General Keybindings

### Movement
- Arrows are disabled
    -> hjkl

- Jump back to previous cursor position
    -> \\

- Navigate split views
    -> CTRL + hjkl

- Delete current buffer
    -> \D

- Goto file under cursor
    -> gf

### Modes
- Exit insert-mode
    -> jj

- Remove search highlighting
    -> //

## Plugins

### NERDTree
- Toggle NERDTree
    -> CTRL + n

### Vim Surround
- Add surroundings to word (with cursor on word)
    -> ysiw + [surround]

- Add surroundings to current line
    -> yss + [surround]

- Add surroundings to visual-mode block (with block selected)
    -> S + [surround]

- Change surroundings (with cursor in between)
    -> cs + [current surround] + [new surround]
    -> use 't' to target more complex surround

- Delete surroundings
    -> ds + [current surround]

### Vim Fugitive
- Call any git command from Vim
    -> :Git + [command]

- Open split with staged version of file
    -> :G(v)diffsplit

### Vimtex
- Enable auto-compilation
    -> \ll

- Clear auxilary files
    -> \lc

- Move between matching delimiters
    -> %

- Close current environment from insert-mode
    -> ]]

- Toggle starred command/environment
    -> ts + c/e

- Change surrounding command/environment/delimiter
    -> cs + c/e/d

- Delete surrounding command/environment/delimiter
    -> ds + c/e/d

### NERDCommenter
- Toggle comment state of visual-mode selection
    -> \c<space>

- Comment visual-mode selection sexily
    -> \cs

### CocVim
- Get definition/type-definition/implementation/references of symbol (with cursor on symbol)
    -> g + d/y/i/r

- Rename symbol (with cursor on symbol)
    -> \rn

- Format selected code
    -> \f

- Apply AutoFix to current line
    -> \qf

- Apply codeAction to selected region or entire buffer
    -> \a (+ c)

- Apply codeLens to current line
    -> \cl

- CoCList mappings for diagnostics/extensions/commands/outline/symbols
    -> <space> + a/e/c/o/s 

#### Coc-snippets
- Save visual selected code as snippet
    -> \x

- Paste snippet based on trigger
    -> CTRL + j 





    
