function! test#python#nose#test_file(file) abort
  return fnamemodify(a:file, ':t') =~# '^test_.*\.py$' &&
        \ (executable('nosetests') || g:test#python#runner == 'nose')
endfunction

function! test#python#nose#build_position(type, position) abort
  if a:type == 'nearest'
    let name = s:nearest_test(a:position)
    if !empty(name)
      return [a:position['file'].':'.name]
    else
      return [a:position['file']]
    endif
  elseif a:type == 'file'
    return [a:position['file']]
  else
    return []
  endif
endfunction

function! test#python#nose#build_args(args) abort
  return ['--doctest-tests'] + a:args
endfunction

function! test#python#nose#executable() abort
  return 'nosetests'
endfunction

function! s:nearest_test(position) abort
  let name = test#base#nearest_test(a:position, g:test#python#levels)
  return join(name[0] + name[1], '.')
endfunction