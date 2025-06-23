#!/bin/bash

function setup_spa_redirects() {
	if [ ! -f package.json ]; then
		echo "❌ Nenhum 'package.json' encontrado nesta pasta."
		return 1
	fi

	# Verifica se react e react-dom estão no package.json
	if ! grep -q '"react"' package.json || ! grep -q '"react-dom"' package.json; then
		echo "❌ Este projeto não parece usar React (faltando 'react' ou 'react-dom' no package.json)."
		return 1
	fi

	# Se passou nas verificações, segue com os argumentos
	for arg in "$@"; do
		if [ "$arg" == "netlify" ]; then
			mkdir -p public
			echo '/*    /index.html   200' > public/_redirects
			echo "✅ Arquivo 'public/_redirects' criado para Netlify"
		elif [ "$arg" == "vercel" ]; then
			cat <<EOF > vercel.json
{
	"rewrites": [
		{ "source": "/(.*)", "destination": "/" }
	]
}
EOF
			echo "✅ Arquivo 'vercel.json' criado para Vercel"
		else
			echo "⚠️ Parâmetro desconhecido: '$arg'. Use 'netlify' ou 'vercel'."
		fi
	done
}

