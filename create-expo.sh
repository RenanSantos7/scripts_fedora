function create-expo() {
	if [[ -z "$1" ]]; then
		echo 'Obrigatório nome do projeto'
		return 1
	fi
	
	npx create-expo-app@latest "$1" --template blank-typescript
	
	setuprn()
}
