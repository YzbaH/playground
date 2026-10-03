#!/usr/bin/env bash
# ==============================================================================
# SETUP INICIAL DO PLAYGROUND (Execute após clonar em um novo computador)
# ==============================================================================

set -e

GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}Configurando ambiente do Playground...${NC}"

# Dar permissão de execução aos scripts e hooks
chmod +x .githooks/pre-commit 2>/dev/null || true
chmod +x sync.sh 2>/dev/null || true
chmod +x new.sh 2>/dev/null || true
chmod +x setup.sh 2>/dev/null || true

# Ativar hooks customizados no Git local
git config core.hooksPath .githooks

echo -e "${GREEN}✓ Git hooks configurados com sucesso (.githooks)!${NC}"
echo -e "${GREEN}✓ Permissões de execução aplicadas a sync.sh e new.sh!${NC}"
echo -e "${CYAN}Tudo pronto para uso neste computador.${NC}"
