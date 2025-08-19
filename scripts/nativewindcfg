#!/bin/sh

# Instala as dependências necessárias
yarn add nativewind tailwindcss@^3.4.17 react-native-reanimated@3.16.2 react-native-safe-area-context

# Inicializa o tailwind.config.js
npx tailwindcss init

# Sobrescreve o tailwind.config.js com a configuração recomendada
cat > tailwind.config.js <<EOF
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./app/**/*.{js,jsx,ts,tsx}"],
  presets: [require("nativewind/preset")],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

# Cria o arquivo global.css com as diretivas do tailwind
cat > global.css <<EOF
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

# Configura o babel.config.js
cat > babel.config.js <<EOF
module.exports = function (api) {
  api.cache(true);
  return {
    presets: [
      ["babel-preset-expo", { 
        jsxImportSource: "nativewind" }
      ],
      "nativewind/babel",
    ],
  };
};
EOF

# Configura o metro.config.js
cat > metro.config.js <<EOF
const { getDefaultConfig } = require("expo/metro-config");
const { withNativeWind } = require('nativewind/metro');

const config = getDefaultConfig(__dirname);

module.exports = withNativeWind(config, { input: './global.css' });
EOF

# Adicione a importação do global.css
sed -i '1i import "./global.css"' App.tsx

# Configura o app.json para usar o bundler metro na web
if [ -f app.json ]; then
  # Usa jq para modificar o arquivo JSON de forma segura
  jq '.expo.web = (.expo.web // {}) + { bundler: "metro" }' app.json > tmp.json && mv tmp.json app.json
  echo "Configuração do bundler web adicionada ao app.json"
else
  echo "Arquivo app.json não encontrado. Por favor, crie-o manualmente com a configuração necessária."
fi

# Cria o arquivo de tipos para NativeWind
cat > nativewind-env.d.ts <<EOF
/// <reference types="nativewind/types" />
EOF

echo "Configuração do NativeWind concluída."
