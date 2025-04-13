function __gif2mp4() {
	if [ $# -eq 0 ]; then
		return 1
	fi
	output=${2:-"${1}"}
	output=${output##*/}.mp4
	ffmpeg -f gif -i "$1" -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -y "${output}" &> /dev/null || echo "Failed"
}

__gif2mp4 "$@"
