#!/bin/bash

if [[ ! -d "node_modules" ]]; then
	echo "Pasta 'node_modules' não encontrada. Abortando..."
	return
fi

rm -rf node_modules package-lock.json
echo "🚮 Limpadas dependências"

yarn

# Adiciona o .prettierrc
cat <<EOL > .prettierrc
{
	"arrowParens": "avoid",
	"jsxSingleQuote": true,
	"printWidth": 80,
	"singleQuote": true,
	"tabWidth": 4,
	"useTabs": true
}
EOL
echo "🧹 Arquivo .prettierrc criado"

rm -rf .git
git init
git add .
git commit -m ":tada: commit inicial"

code .

exit

