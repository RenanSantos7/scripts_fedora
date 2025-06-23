url=$(git remote get-url origin 2>/dev/null)

if [[ -z $url ]]; then
	echo '❌ Nenhuma URL remota encontrada.' >&2
	return 1
fi

# converte url ssh para https
if [[ $url == git@*:* ]]; then
	url=${url/git@/https:\/\/}
	url=${url/:/\//}
	url=${url%.git}
elif [[ $url == https://* ]]; then
	url=${url%.git}
fi

if command -v flatpak-spawn >/dev/null; then
	flatpak-spawn --host xdg-open "$url"
elif command -v xdg-open >/dev/null; then
	xdg-open "$url"
else
	echo '❌ Nenhum comando disponível para abrir o navegador.' >&2
	return 1
fi

xdg-open "$url"

