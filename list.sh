function list(){
	echo 'PID     | Permissoes | Tam | Data modif | Nome'
	ls -GhaiNg --group-directories-first $1
}
