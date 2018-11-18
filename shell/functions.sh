function echo_error() {
	printf "%s\n" "$*" >&2;
}

function source_if_exists() {
	if [[ -f "$1" ]]; then
		source "$1"
	fi
}

# Überprüft, ob der Befehl existiert.
# Sollte man wie folgt nutzen:
# if command_exists foo ; then
# 	do_stuff
# fi
function command_exists() {
	command -v "$1" > /dev/null 2>&1
}

# Überprüft die Existenz von Verzeichnissen und füge sie zu $path hinzu
function add_to_path() {
	if [[ -d "$1" ]]; then
		path=("$1" $path)
	fi
}

# Öffnet alle von git als "modifiziert" markierten Dateien in vim (als Tabs)
function gim () {
	vim $(git ls-files -m) -p
}

# fzf ist der fuzzy file finder
function f() {
	if command_exists fzf ; then
		e $(fzf)
	else
		echo_error "Please install fzf: https://github.com/junegunn/fzf"
	fi
}

# Lädt ein Youtube-Video als MP3 herunter
function youtube-mp3 () {
	if command_exists youtube-dl ; then
		youtube-dl -x --audio-format mp3 $@
	else
		echo_error "Please install youtube-dl: https://rg3.github.io/youtube-dl/"
	fi
}

# Konvertiert latin1 einfach zu utf8
function latin1_to_utf8 () {
	if command_exists iconv ; then
		filename=$(basename "$1")
		extension="${filename##*.}"
		filename="${filename%.*}"

		iconv -f latin1 -t utf8 "$1" > "$filename"_utf8."$extension"
	else
		echo_error "Please install iconv"
	fi
}

# Konvertiert utf8 einfach zu latin1
function utf8_to_latin1 () {
	if command_exists iconv ; then
		filename=$(basename "$1")
		extension="${filename##*.}"
		filename="${filename%.*}"

		iconv -f utf8 -t latin1 "$1" > "$filename"_latin1."$extension"
	else
		echo_error "Please install iconv"
	fi
}

# Zeigt einen vernünftigen Kalender an
# "vernünftig" heißt dabei
# -i: Tage werden von links nach rechts und oben nach unten aufgelistet
# -K: Kalenderwochen werden angezeigt
# -s 1: Montag ist der erste Tag der Woche
function mcal () {
	if command_exists gcal ; then
		gcal -i -K -s 1 $1
	else
		echo_error "Please install gcal"
	fi
}

# Versetzt das System nach "$1" Minuten in den Schlafmodus
function einschlafen() {
	if [[ "$OSTYPE" == "darwin" ]]; then
		sudo shutdown -s +"$1"
	else
		echo_error "Funktioniert gerade nur auf macOS."
	fi
}

function virtualenvwrapper_status () {
	if [[ -n $VIRTUALENVWRAPPER_SCRIPT ]]; then
		echo
		print -P -- "\tvirtualenvwrapper: %F{002}✓%f"
		print -P -- "\t%F{004}Python:%f\t\t$VIRTUALENVWRAPPER_PYTHON"
		print -P -- "\t%F{004}virt. Envs:%f\t$WORKON_HOME"
		print -P -- "\t%F{004}Projekte:%f\t$PROJECT_HOME"
		if [[ -n "$(workon)" ]]; then
			print -P -- "\t%F{004}aktuelle Projekte:%f"
			echo -n "\t"
			workon | paste -s - | sed 's/\t/    /g' | fmt
		fi
	fi
}

function apache_status () {
	if [[ $(curl -sI localhost | grep "Server") =~ "Apache" ]]; then
		echo
		print -P -- "\tlokaler Apache: %F{002}✓%f"
	fi
}

function landscape_status () {
	if command_exists landscape-sysinfo ; then
		echo
		landscape-sysinfo --exclude-sysinfo-plugins=LandscapeLink | sed 's/^\s*/\t/'
	fi
}

function my_screenfetch () {
	screenfetch_cmd="$DOTFILES/scripts/screenfetch/screenfetch-dev"
	if command_exists $screenfetch_cmd ; then
		$screenfetch_cmd
	fi
}

function path_status () {
	print -P -- "\t%F{004}aktueller Pfad:%f"
	echo $PATH | tr -s ':' '\n' | awk '{print "\t"$0 }'
}

function create_directory_if_not_exists() {
	if [[ ! -d $1 ]]; then
		mkdir -p $1
	fi
}

function startup_status () {
	clear
	my_screenfetch
	path_status
	landscape_status
	virtualenvwrapper_status
	apache_status
}
