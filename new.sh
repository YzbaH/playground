#!/usr/bin/env bash
# ==============================================================================
# CRIADOR DE MINI-PROJETOS NO PLAYGROUND
# ==============================================================================
# Uso:
#   ./new.sh meu-experimento
#   ./new.sh python scraper-simples
#   ./new.sh cpp teste-arvore
#   ./new.sh web teste-layout

set -e

TYPE="blank"
NAME=""

if [ -z "$1" ]; then
    echo "Uso: ./new.sh [tipo] <nome-do-projeto>"
    echo "Tipos disponíveis: blank, python, cpp, web, notebook"
    exit 1
fi

if [ -z "$2" ]; then
    NAME="$1"
    TYPE="blank"
else
    TYPE="$1"
    NAME="$2"
fi

# Sanitizar nome
DIR="$NAME"

if [ -d "$DIR" ]; then
    echo "Aviso: A pasta '$DIR' já existe."
    exit 1
fi

mkdir -p "$DIR"

case "$TYPE" in
    python)
        cat << 'EOF' > "$DIR/main.py"
def main():
    print("Playground Python Script running...")

if __name__ == "__main__":
    main()
EOF
        touch "$DIR/requirements.txt"
        ;;
    cpp)
        cat << 'EOF' > "$DIR/main.cpp"
#include <iostream>

int main() {
    std::cout << "Playground C++ running...\n";
    return 0;
}
EOF
        cat << 'EOF' > "$DIR/Makefile"
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++17 -O2

all: main

main: main.cpp
	$(CXX) $(CXXFLAGS) -o main main.cpp

clean:
	rm -f main *.o
EOF
        ;;
    notebook)
        cat << 'EOF' > "$DIR/README.md"
# Notebook Experiment

Inicie seu Jupyter ou VS Code Notebook nesta pasta.
EOF
        ;;
    web)
        cat << 'EOF' > "$DIR/index.html"
<!DOCTYPE html>
<html lang="pt-br">
<head>
  <meta charset="UTF-8">
  <title>Playground Web</title>
</head>
<body>
  <h1>Playground Web</h1>
  <script src="script.js"></script>
</body>
</html>
EOF
        cat << 'EOF' > "$DIR/script.js"
console.log("Playground web running...");
EOF
        touch "$DIR/style.css"
        ;;
    *)
        cat << EOF > "$DIR/README.md"
# $NAME

Experimento criado em $(date "+%d/%m/%Y").
EOF
        ;;
esac

echo "✓ Novo projeto criado em: $DIR/ (tipo: $TYPE)"
