# vim-ctrlp-tmuxcaptures

The common use case is for openning recent rendered views for a MVC framework. Works great with Rails and Phoenix.

## Usage

Add line below into your per project vimrc.

`nnoremap se :CtrlPtmuxcapturesLocate main:ui.0;app/views;erb;Started GET<cr>`

*main:ui.0* is the tmux pane ID

*app/views* is the common file prefix you want to search for

*erb* is the file extension you want to search for

*Started GET* is the delimiter to identify a start of a block
