# vim: ft=zsh

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

function get_date_prog() {
	date_prog=date
	if command_exists gdate ; then
		date_prog=gdate
	fi
	echo $date_prog
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
	if command_exists yt-dlp ; then
		yt-dlp -x --audio-format mp3 $@
	else
		echo_error "Please install yt-dlp: https://github.com/yt-dlp/yt-dlp"
		echo_error "pip install --user -U yt-dlp"
		echo_error "brew install yt-dlp/taps/yt-dlp"
	fi
}

# Konvertiert latin1 einfach zu utf8
function latin1_to_utf8 () {
	if command_exists iconv ; then
		tmpfile=$(mktemp)
		iconv -f latin1 -t utf8 "$1" > "$tmpfile"
		mv "$tmpfile" "$1"
	else
		echo_error "Please install iconv"
	fi
}

# Konvertiert utf8 einfach zu latin1
function utf8_to_latin1 () {
	if command_exists iconv ; then
		tmpfile=$(mktemp)
		iconv -f utf8 -t latin1 "$1" > "$tmpfile"
		mv "$tmpfile" "$1"
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
	if [[ "$OSTYPE" == darwin* ]]; then
		sudo shutdown -s +"$1"
	else
		echo_error "Funktioniert gerade nur auf macOS."
	fi
}

function webserver_status () {
	local current_webserver=$(curl -sI localhost | grep "Server" | cut -d ' ' -f 2)
	if [[ -n "$current_webserver" ]]; then
		echo
		print -P -- "\tlokaler Webserver: $current_webserver"
	fi
}

function landscape_status () {
	if command_exists landscape-sysinfo ; then
		echo
		landscape-sysinfo --exclude-sysinfo-plugins=LandscapeLink | sed 's/^\s*/\t/'
	fi
}

function my_screenfetch () {
	screenfetch_cmd="$DOTFILES/scripts/neofetch/neofetch"
	if command_exists $screenfetch_cmd ; then
		$screenfetch_cmd
	fi
}

function path_status () {
	print -P -- "\t%F{004}aktueller Pfad:%f"
	echo $PATH | tr -s ':' '\n' | awk '{print "\t" $0 }'
}

function create_directory_if_not_exists() {
	if [[ ! -d $1 ]]; then
		mkdir -p $1
	fi
}

function startup_status () {
	if [[ ! -f "$HOME/.no_screenfetch" ]]; then
		my_screenfetch
	fi
	path_status
	landscape_status
	webserver_status
}

function fix_file_permissions () {
	# Ordner kriegen 755:
	find . -type d -exec chmod 775 {} \;
	# Dateien kriegen 644:
	find . -type f -exec chmod 644 {} \;
}

function say_with_music_control () {
	ivol 30
	say "$1"
	ivol 100
}

function countdown() {
	date_prog=$(get_date_prog)
	t=$(seconds.py $@)
	t_now=$($date_prog +%s)
	t_end=$(($t_now + $t));

	while [ "$t_end" -ge "$t_now" ]; do
		d=$(($t_end - $t_now))
		echo -ne "$($date_prog -u --date @"$d" +%H:%M:%S)\r";
		t_now=$($date_prog +%s)

		sleep 0.1
	done

	if [[ "$OSTYPE" == darwin* ]]; then
		osascript -e 'display notification "Zeit ist abgelaufen" with title "Countdown fertig"'
		afplay "/System/Library/Sounds/Glass.aiff"
	fi
}

function stopwatch() {
	date_prog=$(get_date_prog)
	t_start=$($date_prog +%s);

	while true; do
		t_now=$($date_prog +%s)
		d=$(( $t_now - $t_start ))
		t="$($date_prog -u --date @"$d" +%H:%M:%S)\r"
		echo -ne $t;
		sleep 0.1
	done
}

function ssh-add-all() {
	ssh-add $(ls $HOME/.ssh/id^*.pub)
}
