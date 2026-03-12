# Muss nach "bindkey -v" stehen, damit es funktioniert.
# Bindet Vervollständigung und Hotkeys für fzf ein.
# CTRL-T für den direkten Einsatz von fzf:
# $ vim (CTRL-T)
# $ open (CTRL-T)
#
# ,, für die schlaue Vervollständigung je nach Befehl:
# $ cd ,,(TAB)
#     listet Verzeichnisse auf
# $ ssh ,,(TAB)
#     listet SSH-Ziele auf
# $ kill -9 ,,(TAB)
#     listet Prozess auf
eval "$(fzf --zsh)"

# Zur Vorbereitung "dircolors -p > ~/.dircolors" ausführen und dann diese Datenbank anpassen.
# dircolors liest dann die Datenbank und erzeugt daraus Bash-Code.
if [[ -f "$HOME/.dircolors" ]]; then
	if command_exists dircolors ; then
		eval $(dircolors -b "$HOME/.dircolors")
	fi
	if command_exists gdircolors ; then
		eval $(gdircolors -b "$HOME/.dircolors")
	fi
fi

startup_status

if command_exists starship ; then
	eval "$(starship init zsh)"
fi
