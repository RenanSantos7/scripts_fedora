function rndoc() {
	if [[ -z "$1" ]]; then
		xdg-open https://reactnative.dev/
		return
	fi
	
	xdg-open https://reactnative.dev/docs/"$1" 2> /dev/null
}

