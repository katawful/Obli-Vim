# Obli-Vim - A Vim/NeoVim plugin for Oblivion based script development

NeoVim/Vim plugin for Oblivion's obscript with integration into Construction Set Extender ScriptSync using pure Vimscript

## Installation:
Install with your plugin manager of choice.
For [vim-plug](https://github.com/junegunn/vim-plug) add the following to your `.vimrc` or `init.vim`:
```vim
" Main plugin
Plug 'katawful/Obli-Vim', {'for': 'obse'}
" Add if you want OBSE docs integrated into your Vim session
Plug 'katawful/Obli-Vim-Docs', {'for': 'obse'}
```
It is recommended that you read either this page or the help file (TODO: add help file) before using.

## Setting up ScriptSync:
This plugin assumes you have installed Construction Set Extender and have run it at least once.

Inside `Oblivion\Data\OBSE\Plugins\Construction Set Extender.ini`, change the following section with this:
```ini
[BGSEE::ScriptEditor::ScriptSync]
ScriptFileExtension=.obl
AutoDeleteLogs=1
ExistingFileHandlingOp=Keep
AutoSyncInterval=3
AutoSyncChanges=1
```
Set `AutoSyncInterval` to an integer value above 0 that you think is appropriate.
[`g:ov_sync_time`](#scriptsync-time) must be this value.

You can disable the ScriptSync features with [`g:ov_disable_cse`](#global-options).

### ScriptSync Time:
CSE's ScriptSync generates a log file that gets updated whenever the externally edited script file gets updated and read by CSE.
By default, this plugin defaults to `3`.
Adjust to match your preferences with ScriptSync with [`g:ov_sync_time`](#global-options).

### Signs:
This plugin enables "signs" that marks any messages that CSE presents to from the ScriptSync.
This gives users a more direct understanding of their script.
Example:   
![image](https://raw.githubusercontent.com/katawful/Obli-Vim-Assets/main/signs-error.png)

CSE currently only presents two possible message types, "Info" and "Error".
Because of this, there is a limit on the usefulness of these signs.

Another issue is how CSE ScriptSync works.
It creates a log file that is updated to whatever update value you set.
This log file is what this plugin reads to perform all of its functions, including sign creation.
As a result, I have structured this plugin such that any text manipulation will remove signs until the next write to file.
This should hopefully minimize confusion.

#### Sign Jumping:
This plugin allows sign jumping for easy parsing of errors and information.
By default the following maps are like so:

```
\en " Jump to next error sign
\ep " Jump to previous error sign
\in " Jump to next info sign
\ip " Jump to previous info sign
\n " Jump to any next sign
\p " Jump to any previous sign
```
These can be [changed](#global-options).

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
This is called with `g:ov_ShowFloatLog` and defaults to `\l`.
This is supported on any installation of Vim/NeoVim, although there are some minor differences.
These windows are just information, any interaction is unintended if possible.

By default the mapping is `\l`, and can be changed with [`g:ov_ShowFloatLog`](#global-options)

#### Floating Window Differences:
Vim and NeoVim both integrated floating windows in completely different manners.
See Vim: `:h popup` and NeoVim: `:h api-floatwin`.
For this reason, behaviors are slightly different.

Vim: The windows in this plugin are simple 'popup' windows.
You cannot interact with this window, and it is closed by changing the line the cursor is on.

NeoVim: The windows in this plugin are generic NeoVim floating windows.
You can interact with these windows, but all alphabetical keys and some others will close it.


#### Window Options:
You can adjust the window style between two types:
![window-type](https://raw.githubusercontent.com/katawful/Obli-Vim-Assets/main/window-types.png)   
You can set the type with `g:ov_window_style`.
The two available options are `single` and `double`.
Note: due to unforeseen font trouble, gVim users will only be able to use `double` border lines.

### Completion:
There is basic function completion that is activated through `:h i_CTRL-X_CTRL-U` (hitting `<C-x><C-u>` in insert mode).
This will only complete function names, there is no processing for this to give the correct syntax.
![complete](https://raw.githubusercontent.com/katawful/Obli-Vim-Assets/main/back.png)

## Using this plugin:
As explained above, this plugin uses a log file generated by CSE in order to perform the more IDE-like features.
Features involving signs (jumping and log info) only appear after the sync time after a file write.
These signs **will** disappear if you perform any normal mode function or insert any text.
To see the signs again, simply resave the file even if there aren't any changes.

It is also suggested to change the default bindings to a more reasonable leader.
Your global `<leader` is recommended, but a `:h <LocalLeader>` for this filetype is preferred.

## Global Options:
A number of options can be set:

Global options       | Description                                   | Default  | Options                               |
---------------------|-----------------------------------------------|----------|---------------------------------------|
`g:ov_disable_cse`   | Disables ScriptSync features                  | 0        | 1 or 0                                |
`g:ov_sync_time`     | Sets the sync time to the value from CSE      | 3        | Any integer equal to script sync time |
`g:ov_error_sign`    | Sets the error sign to one or two characters  | `=>`     | Any two characters                    |
`g:ov_info_sign`     | Sets the info sign to one or two characters   | `=>`     | Any two characters                    |
`g:ov_window_style`  | Sets the floating window style                | `single` | `single` or `double`                  |
`g:ov_ShowFloatLog`  | Show the log of the current line if available | `\l`     | Any valid mapping                     |
`g:ov_JumpNextError` | Binding to jump to next error sign            | `\en`    | Any valid mapping                     |
`g:ov_JumpPrevError` | Binding to jump to previous error sign        | `\ep`    | Any valid mapping                     |
`g:ov_JumpNextInfo`  | Binding to jump to next info sign             | `\in`    | Any valid mapping                     |
`g:ov_JumpPrevInfo`  | Binding to jump to previous info sign         | `\ip`    | Any valid mapping                     |
`g:ov_JumpNextAll`   | Binding to jump to next all sign              | `\n`     | Any valid mapping                     |
`g:ov_JumpPrevAll`   | Binding to jump to previous all sign          | `\p`     | Any valid mapping                     |

# License
GPL v3
