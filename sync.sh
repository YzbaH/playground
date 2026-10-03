#!/usr/bin/env bash
# ==============================================================================
# SCRIPT DE SINCRONIZAÇÃO RÁPIDA: PC <-> NOTEBOOK
# ==============================================================================
# Uso:
#   ./sync.sh              -> Puxa atualizações e envia alterações locais automaticamente
#   ./sync.sh pull         -> Apenas puxa as alterações da outra máquina
#   ./sync.sh push "msg"   -> Salva e envia com mensagem personalizada

set -e

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

HOST=$(hostname)
DATE=$(date "+%d/%m/%Y %H:%M")

echo -e "${CYAN}=== Sincronizando Playground ($HOST) ===${NC}"

# Garantir que hooks locais estão ativos
git config core.hooksPath .githooks 2>/dev/null || true

ACTION="${1:-all}"
MSG="${2:-sync ($HOST): $DATE}"

do_pull() {
    echo -e "${YELLOW}>> Puxando alterações remotas (rebase + autostash)...${NC}"
    if git pull --rebase --autostash origin main; then
        echo -e "${GREEN}✓ Atualizado com sucesso!${NC}"
    else
        echo -e "${RED}Erro ao puxar alterações. Verifique possíveis conflitos com 'git status'.${NC}"
        exit 1
    fi
}

do_push() {
    # Verificar se há alterações locais
    if [ -n "$(git status --porcelain)" ]; then
        echo -e "${YELLOW}>> Alterações locais detectadas:${NC}"
        git status -s
        echo -e "${YELLOW}>> Adicionando arquivos e commitando...${NC}"
        git add .
        
        # O pre-commit hook roda aqui
        if git commit -m "$MSG"; then
            echo -e "${GREEN}✓ Commit realizado: '$MSG'${NC}"
        else
            echo -e "${RED}Falha no commit (possivelmente bloqueado pelos safeguards).${NC}"
            exit 1
        fi
    else
        echo -e "${CYAN}>> Nenhuma alteração local nova para commitar.${NC}"
    fi

    echo -e "${YELLOW}>> Enviando commits para o GitHub...${NC}"
    if git push origin main; then
        echo -e "${GREEN}✓ Sincronização concluída com sucesso!${NC}"
    else
        echo -e "${RED}Erro ao enviar para o repositório remoto. Tente puxar primeiro com './sync.sh pull'.${NC}"
        exit 1
    fi
}

case "$ACTION" in
    pull)
        do_pull
        ;;
    push)
        MSG="${2:-sync ($HOST): $DATE}"
        do_push
        ;;
    all)
        do_pull
        do_push
        ;;
    *)
        # Se passou uma mensagem direta: ./sync.sh "minha mensagem"
        MSG="$ACTION"
        do_pull
        do_push
        ;;
esac

echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN}Pronto para programar!${NC}"
