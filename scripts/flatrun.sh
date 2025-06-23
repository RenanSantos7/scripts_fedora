function flatrun() {
    local app_id=$(flatpak list --columns=application | grep -F -i "${1}")

    if [[ -n "${app_id}" ]]; then
        flatpak run "${app_id}" "${@:2}"
    else
        echo "Aplicação '${1}' não encontrada entre os flatpaks instalados"

        local search_results=$(flatpak search "${1}" --columns='application,version' | awk 'NR==1 || NR<=6 {print $1, $2}' | grep -i "${1}" | column -t -N "App ID",Version)
        if [[ -n "${search_results}" ]]; then
            echo "Os seguintes aplicativos correspondentes foram encontrados nos repositórios do Flatpak:"
			echo "${search_results}"
			echo ""
			echo "Para instalar um aplicativo, use:"
			echo " flatpak install app-id"
		else
			echo "Nenhum Flatpak correspondente encontrado nos repositórios."
		fi
    fi
}
