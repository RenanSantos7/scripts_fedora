#!/bin/bash
creact() {
    if [ -z "$1" ]; then
        echo "Erro: O nome do projeto é obrigatório."
        echo "Uso: creact <nome-do-projeto> [npm|yarn|pnpm]"
        return 1
    fi
    
    local PROJECT_NAME="$1"
    local PACKAGE_MANAGER=${2:-npm}
    
    # Verificar se o gerenciador de pacotes existe
    command -v "$PACKAGE_MANAGER" >/dev/null || {
        echo "Erro: $PACKAGE_MANAGER não está instalado"
        return 1
    }
    
    # Verificar se o diretório já existe
    if [ -d "$PROJECT_NAME" ]; then
        echo "Erro: Diretório $PROJECT_NAME já existe"
        return 1
    fi
    
    echo "Criando projeto React com Vite e TypeScript: $PROJECT_NAME usando $PACKAGE_MANAGER..."
    $PACKAGE_MANAGER create vite@latest $PROJECT_NAME --template react-ts || return 1
    
    cd $PROJECT_NAME || return 1
    
    echo "Instalando dependências..."
    $PACKAGE_MANAGER install || return 1
    
    echo "Instalando bibliotecas adicionais..."
    if [ "$PACKAGE_MANAGER" = "npm" ]; then
        $PACKAGE_MANAGER install react-router-dom react-router-hash-link classnames react-icons || return 1
    else
        $PACKAGE_MANAGER add react-router-dom react-router-hash-link classnames react-icons || return 1
    fi
    
    echo "Instalando Prettier como dependência de desenvolvimento..."
    if [ "$PACKAGE_MANAGER" = "npm" ]; then
        $PACKAGE_MANAGER install -D prettier || return 1
    else
        $PACKAGE_MANAGER add -D prettier || return 1
    fi
    
    echo "Removendo arquivo src/App.css..."
    rm -f src/App.css
    
    echo "Editando index.html..."
    sed -i 's/lang="en"/lang="pt-br"/' index.html
    sed -i "s/<title>Vite App<\/title>/<title>$PROJECT_NAME<\/title>/" index.html
    
    # Adicionando o bloco <style> e <noscript> antes da div#root
    sed -i '/<div id="root">/i \
    <style>\
      noscript {\
        width: 500px;\
        height: 500px;\
        margin: 120px auto;\
        font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;\
      }\
    </style>\
    <noscript>\
      <h1>Esta página necessita de JavaScript para funcionar</h1>\
      <h2>Por favor, habilite o JavaScript</h2>\
    </noscript>' index.html
    
    # Criar .prettierrc
    echo '{
    "arrowParens": "avoid",
    "jsxSingleQuote": true,
    "printWidth": 80,
    "singleQuote": true,
    "tabWidth": 4,
    "useTabs": true
}' > .prettierrc
    echo "-> Criado prettierrc"
    
    # Limpar as pastas 'public' e 'src/assets'
    rm -rf public/* src/assets/*
    echo "-> limpadas as pastas public e src/assets"
    
    # Criar as pastas 'components', 'contexts' e 'pages'
    mkdir -p src/components src/contexts src/pages src/types src/pages/Home
    echo "-> criadas as pastas components, contexts, pages, types e Home"
    
    # Criar arquivo types
    touch src/types/index.tsx
    echo "-> criado arquivo types/index.tsx"
    
    # Criar o arquivo Home.tsx dentro de 'src/pages/Home'
    echo "export default function Home() {
    return <div>Home Page</div>
}" > src/pages/Home/index.tsx
    echo "-> criado arquivo pages/Home/index.tsx"
    
    # Criar o arquivo Base.tsx dentro de 'src/pages'
    echo "import { Outlet, ScrollRestoration } from 'react-router-dom'
export default function Base() {
    return (
        <>
            <Outlet />
            <ScrollRestoration />
        </>
    )
}" > src/pages/Base.tsx
    echo "-> criado arquivo pages/Base.tsx"
    
    # Criar o arquivo DataContext.tsx dentro de 'src/contexts'
    echo "import { createContext, useState, useContext, ReactNode } from 'react'
interface IDataContext {
	
}
const DataContext = createContext<IDataContext>(null);
export default function DataProvider ({ children }:{children: ReactNode}) {
    const [, ] = useState([]);
    
    return (
        <DataContext.Provider value={{ ,  }}>
            {children}
        </DataContext.Provider>
    )
}
export function useDataContext() {
	return useContext(DataContext);
}
" > src/contexts/DataContext.tsx
    echo "-> criado arquivo contexts/DataContext.tsx"
    
    # Modificar o arquivo App.tsx
    echo "import { RouterProvider } from 'react-router-dom'
import DataProvider from './contexts/DataContext.tsx'
import router from './router.tsx'
export default function App() {
  return (
    <DataProvider>
      <RouterProvider router={router} />
    </DataProvider>
  )
}" > src/App.tsx
    echo "-> modificado arquivo App.tsx"
    
    # Criar o arquivo router.tsx
    echo "import { createBrowserRouter } from 'react-router-dom'
import Base from './pages/Base.tsx'
import Home from './pages/Home/index.tsx'
const router = createBrowserRouter([
    {
        path: '/',
        element: <Base />,
        children: [
            {
                index: true,
                element: <Home />,
            }
        ],
    }
])
export default router" > src/router.tsx
    echo "-> criado arquivo router.tsx"
    
    # Modificar o arquivo index.css
    echo '@import url("https://renan-santos.netlify.app/styles/reset.css");' > src/index.css
    
    # Alterar o conteúdo do tsconfig.json
    cat <<EOF > tsconfig.json
{
	"compilerOptions": {
		// Projects
		
		// Language and Environment
		"target": "ESNext",
		"lib": ["ESNext", "DOM", "DOM.Iterable"],
		"jsx": "react-jsx",
		"useDefineForClassFields": true,
		
		//Modules
		"module": "NodeNext",
		"moduleResolution": "NodeNext",
		"resolveJsonModule": true,
		"allowImportingTsExtensions": true,
		
		// Js Support
		
		//Emit
		"noEmit": true,
		
		// Interop Constraints
		"isolatedModules": true,
		"esModuleInterop": true,
		"forceConsistentCasingInFileNames": true,
		
		// Type Check
		"strict": true,
		"strictNullChecks": false,
		"noUnusedLocals": false,
		"noUnusedParameters": false,
		"noFallthroughCasesInSwitch": true,
		
		// Completeness
		"skipLibCheck": true
	},
	"include": ["src"]
}
EOF
    echo "-> modificado tsconfig.json"
    
    # Iniciar um repositório git
    git init
    # Renomear a branch master para main
    git branch -m master main
    echo "-> iniciado repositório git"
    
    # Fazer commit
    git add .
    git commit -m ':tada: primeiro commit'
    code .
}
