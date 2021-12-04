let b:app = {}

function! b:app.start() abort
  setlocal shortmess+=I
  setlocal t_ve=

  highlight EndOfBuffer ctermfg=0
  call popup_clear()
  let popup_winid = popup_create('', {})
  call win_execute(popup_winid, 'set wincolor=none')
  call win_execute(popup_winid, 'highlight AppLabel  ctermfg=gray')
  call win_execute(popup_winid, 'highlight AppNumber ctermfg=magenta')
  call win_execute(popup_winid, 'syntax match AppLabel  /Count:/')
  call win_execute(popup_winid, 'syntax match AppNumber /\d\+/')

  call s:disable_allkeys_in_buffer_as_far_as_possible()
  nnoremap <silent><buffer><CR>  :<C-u>call b:app.countup()<CR>
  nnoremap <silent><buffer>q     :<C-u>call b:app.exit()<CR>
  nnoremap <silent><buffer><C-c> :<C-u>call b:app.exit_emergent()<CR>

  let self.count       = 0
  let self.popup_winid = popup_winid
  call self.update_screen()
endfunction

function! b:app.countup() abort
  let self.count += 1
  call self.update_screen()
endfunction

function! b:app.update_screen() abort
  let lines = map(range(3), {_ -> ''})
  let lines[0] = '[Tally Counter]'
  let lines[2] = printf('  Count: %d', self.count)
  call popup_settext(self.popup_winid, lines)
endfunction

function! b:app.exit() abort
  setlocal t_ve&
  quit!
endfunction

function! b:app.exit_emergent() abort
  setlocal t_ve&
  call popup_clear()
  mapclear <buffer>
endfunction

function! s:disable_allkeys_in_buffer_as_far_as_possible()
  let keys = []
  call extend(keys, ['<CR>', '<Space>', '<Tab>', '<BS>', '<Del>', '<Up>', '<Down>', '<Left>', '<Right>'])
  call extend(keys, map(range(33, 126),                    {_, nr -> escape(nr2char(nr), '|')}))
  call extend(keys, map(range(33, 126),                    {_, nr -> printf('g%s', escape(nr2char(nr), '|'))}))
  call extend(keys, map(range(char2nr('a'), char2nr('z')), {_, nr -> printf('<C-%s>', escape(nr2char(nr), '|'))}))
  for key in keys
    execute printf('nnoremap <silent><buffer>%s <NOP>', key)
  endfor
endfunction

call b:app.start()
