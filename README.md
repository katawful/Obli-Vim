# Obli-Vim - A Vim/NeoVim plugin for Oblivion based script development

NeoVim/Vim plugin for Oblivion's obscript with integration into Construction Set Extender ScriptSync using pure Vimscript

## Usage
Install with your plugin manager of choice.
For [vim-plug](https://github.com/junegunn/vim-plug) add the following to your `.vimrc` or `init.vim`:
```vim
" Main plugin
Plug 'katawful/Obli-Vim', {'for': 'obse'}
" Add if you want OBSE docs integrated into your Vim session
Plug 'katawful/Obli-Vim-Docs', {'for': 'obse'}
```

### Signs:
This plugin enables "signs" that marks any messages that CSE presents to from the ScriptSync.
This gives users a more direct understanding of their script.
Example:   
![image](https://raw.githubusercontent.com/katawful/Obli-Vim-Assets/main/signs-error.png)

CSE currently only presents two possible message types, "Info" and "Error".
Because of this, there is a limit on the usefulness of these signs.

Another issue is how CSE ScriptSync works.
It creates a log file that is updated to whatever update value (TODO: link appropriate variable) you set.
This log file is what this plugin reads to perform all of its functions, including sign creation.
As a result, I have structured this plugin such that any text manipulation will remove signs until the next write to file.
This should hopefully minimize confusion.

#### Sign Jumping:
This plugin allows sign jumping for easy parsing of errors and information.
By default the following maps are like so:

```
<C-a>en " Jump to next error sign
<C-a>ep " Jump to previous error sign
<C-a>in " Jump to next info sign
<C-a>ip " Jump to previous info sign
<C-a>n " Jump to any next sign
<C-a>p " Jump to any previous sign
```
These can be changed to one's desire (TODO: link appropriate variables).

### Indent:
This plugin provides indentation by default.
OBScript does not care about indentation, but for visual reasons it is nice.
This plugin will indent on any block type, such as `Begin GameMode` and `if` blocks.
Currently this is not customizable.
If you wish to disable this, run `:setlocal indentexpr=` within a local *.obl buffer or enable it for the filetype like so in your `vimrc`/`init.vim` file:   
```vim 
augroup obl_indent
  autocmd!
  autocmd FileType obse setlocal indentexpr=
augroup END
```
### Message Log Window Support:
This plugin allows the use of floating windows to display message log info that CSE provides.
![window](https://raw.githubusercontent.com/katawful/Obli-Vim-Assets/main/single.png)   
These windows have syntax that allow for easier reading.
Like signs, these require an updated log file and thus only possible when the file is written and the log is updated.
This is called with `g:ov_ShowFloatLog` and defaults to `<C-a>l`.
Currently this is only available for NeoVim.

#### Options:
You can adjust the window style between two types:
![window-type](https://raw.githubusercontent.com/katawful/Obli-Vim-Assets/main/window-types.png)   
You can set the type with `g:ov_window_style`.
The two available options are `single` and `double`

## Options:
A number of options can be set:

Global options       | Description                                        | Default   | Options                               |
---------------------|----------------------------------------------------|-----------|---------------------------------------|
`g:ov_sync_time`     | Sets the sync time to the value from CSE           | 3         | Any integer equal to script sync time |
`g:ov_error_sign`    | Sets the error sign to one or two characters       | `=>`      | Any two characters                    |
`g:ov_info_sign`     | Sets the info sign to one or two characters        | `=>`      | Any two characters                    |
`g:ov_window_style`  | Sets the floating window style                     | `single`  | `single` or `double`                  |
`g:ov_ShowFloatLog`  | Show the log info of the current line if available | `<C-a>l`  | Any valid mapping                     |
`g:ov_JumpNextError` | Binding to jump to next error sign                 | `<C-a>en` | Any valid mapping                     |
`g:ov_JumpPrevError` | Binding to jump to previous error sign             | `<C-a>ep` | Any valid mapping                     |
`g:ov_JumpNextInfo`  | Binding to jump to next info sign                  | `<C-a>in` | Any valid mapping                     |
`g:ov_JumpPrevInfo`  | Binding to jump to previous info sign              | `<C-a>ip` | Any valid mapping                     |
`g:ov_JumpNextAll`   | Binding to jump to next all sign                   | `<C-a>n`  | Any valid mapping                     |
`g:ov_JumpPrevAll`   | Binding to jump to previous all sign               | `<C-a>p`  | Any valid mapping                     |

# License
GPL v3
