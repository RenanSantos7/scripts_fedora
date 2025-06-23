function git-commit() {
	if [[ -z "$1" ]]; then
		echo "Obrigatória mensagem de commit"
		return
	fi
	
	git add . && git commit -m "$1"
}
