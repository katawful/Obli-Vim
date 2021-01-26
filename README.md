<<<<<<< HEAD
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

## Options:
A number of options can be set:

Global options       | Description                                  | Default   |
---------------------|----------------------------------------------|-----------|
`g:ov_sync_time`     | Sets the sync time to the value from CSE     | 3         |
`g:ov_error_sign`    | Sets the error sign to one or two characters | `=>`      |
`g:ov_info_sign`     | Sets the info sign to one or two characters  | `=>`      |
`g:ov_JumpNextError` | Binding to jump to next error sign           | `<C-a>en` |
`g:ov_JumpPrevError` | Binding to jump to previous error sign       | `<C-a>ep` |
`g:ov_JumpNextInfo`  | Binding to jump to next info sign            | `<C-a>in` |
`g:ov_JumpPrevInfo`  | Binding to jump to previous info sign        | `<C-a>ip` |
`g:ov_JumpNextAll`   | Binding to jump to next all sign             | `<C-a>n`  |
`g:ov_JumpPrevAll`   | Binding to jump to previous all sign         | `<C-a>p`  |

# License
GPL v3
=======
# Obli-Vim
NeoVim/Vim plugin for Oblivion's obscript with integration into CSE ScriptSync

Currently provided as is
>>>>>>> origin/main
