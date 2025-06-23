LimparArquivos() {
  # Verifica se o parâmetro obrigatório foi passado
  if [[ -z "$1" ]]; then
    echo "Uso: LimparArquivos <regex_nome> [extensao_regex]"
    return 1
  fi

  local padrao_nome="$1"
  local extensao_regex="${2:-.*}"
  local encontrou=0

  # Busca recursiva por arquivos
  for arquivo in **/*(.); do
    nome_base="${arquivo##*/}"
    nome_sem_ext="${nome_base%.*}"
    extensao=""
    [[ "$nome_base" == *.* ]] && extensao=".${nome_base##*.}"

    if [[ "$nome_sem_ext" =~ $padrao_nome ]] && [[ "$extensao" =~ $extensao_regex ]]; then
      echo "Enviando para a lixeira: $arquivo"
      gio trash "$arquivo"
      encontrou=1
    fi
  done

  if [[ $encontrou -eq 0 ]]; then
    echo "Nenhum arquivo correspondente ao padrão foi encontrado."
  fi
}

