command Todo s,^,\[ \] , | nohlsearch
command Forward s,\[.\],\[>\], | nohlsearch
command Delete s,\[.\],\[✗\], | nohlsearch
command Done s,\[.\],\[✓\], | nohlsearch
command Date put=strftime('@ %F %R %Z')
