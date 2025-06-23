#!/bin/sh

# Gera o APK (modo release)
cd android
./gradlew assembleRelease || {
  echo "❌ Erro ao gerar o APK. Abortando."
  exit 1
}
cd ..

PACKAGE_JSON="./package.json"

# Lê nome do app
APP_NAME=$(grep '"name"' $PACKAGE_JSON | head -1 | sed -E 's/[^:]*: *"([^"]+)".*/\1/')

# Lê versão atual
CURRENT_VERSION=$(grep '"version"' $PACKAGE_JSON | head -1 | sed -E 's/[^0-9]*([0-9]+\.[0-9]+\.[0-9]+).*/\1/')
IFS='.' read -r MAJOR MINOR PATCH <<EOF
$CURRENT_VERSION
EOF

# Incrementa o PATCH
NEW_PATCH=$((PATCH + 1))
NEW_VERSION="$MAJOR.$MINOR.$NEW_PATCH"

# Caminhos do APK
APK_PATH="./android/app/build/outputs/apk/release/app-release.apk"
RENAMED_APK="./android/app/build/outputs/apk/release/${APP_NAME}_${CURRENT_VERSION}.apk"

# Verifica se o APK foi gerado
if [ ! -f "$APK_PATH" ]; then
  echo "❌ APK não encontrado em $APK_PATH. Abortando."
  exit 1
fi

# Renomeia o APK com nome e versão
mv "$APK_PATH" "$RENAMED_APK"

# Atualiza a versão no package.json
sed -i -E "s/\"version\": \"$CURRENT_VERSION\"/\"version\": \"$NEW_VERSION\"/" $PACKAGE_JSON

# Mensagens finais
echo "🔢 Versão atualizada: $CURRENT_VERSION → $NEW_VERSION"
echo "✅ APK gerado com sucesso! Confira em $(pwd)/android/app/build/outputs/apk/release/${APP_NAME}_${CURRENT_VERSION}.apk"

