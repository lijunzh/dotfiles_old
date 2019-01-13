for f in split(glob('~/.config/nvim/partials/*.vim'), '\n')
	exe 'source' f
endfor

