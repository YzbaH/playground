# 🧪 Playground Monorepo

Repositório centralizado e sincronizado para testes rápidos, rascunhos, estudos, scripts e ideias sem burocracia.

---

## ⚡ Como funciona o fluxo PC <-> Notebook

### 1. No Notebook (Primeira vez)
Clone o repositório e rode o setup para ativar os safeguards:
```bash
git clone git@github.com:YzbaH/playground.git
cd playground
./setup.sh
```

---

### 2. No dia a dia (Sincronização com 1 comando)

Criamos um utilitário [`sync.sh`](file:///home/absy/Projects/playground/sync.sh) que cuida de tudo:

* **Sincronizar tudo (puxa da nuvem e envia suas alterações locais):**
  ```bash
  ./sync.sh
  ```
* **Apenas puxar alterações feitas no outro computador:**
  ```bash
  ./sync.sh pull
  ```
* **Salvar e enviar com mensagem personalizada:**
  ```bash
  ./sync.sh push "ajuste no script de teste"
  ```

*(Se preferir usar o Git tradicional, comandos como `git pull --rebase` e `git push` continuam funcionando normalmente).*

---

## 🚀 Criando novos experimentos

Para não perder tempo criando pastas e arquivos do zero, use [`new.sh`](file:///home/absy/Projects/playground/new.sh):

```bash
# Pasta em branco simples
./new.sh meu-teste

# Projeto com template Python (main.py + requirements.txt)
./new.sh python scraper-olx

# Projeto com template C++ (main.cpp + Makefile)
./new.sh cpp teste-grafos

# Template Web (HTML + CSS + JS)
./new.sh web mini-calculadora
```

---

## 🛡️ Safeguards Ativos (Pre-Commit Hook)

Para que o repositório continue leve e seguro ao longo dos anos, há verificações automáticas antes de cada commit:

1. **Bloqueio de arquivos gigantes (> 25MB):**
   * Impede que datasets (`.csv`, `.parquet`), vídeos ou pesos de modelos (`.pt`, `.bin`) quebrem o histórico do Git.
2. **Proteção contra vazamento de credenciais:**
   * Bloqueia arquivos `.env`, chaves privadas (`id_rsa`, `.pem`) e tokens de API no código.
3. **Alerta de `.git` aninhado:**
   * Avisa caso você tenha dado `git clone` em algum projeto dentro do playground para evitar corrupção de submódulos.

> **Precisa forçar um commit de teste mesmo assim?**
> Use `git commit --no-verify` (ou `-f`).

---

## 💡 E se um rascunho virar um projeto sério?

Se algum projeto pequeno crescer e você quiser torná-lo um repositório independente no GitHub:

```bash
# Exemplo: desmembrar a pasta 'meu-projeto'
cd /home/absy/Projects
cp -r playground/meu-projeto .
cd meu-projeto
git init
git add .
git commit -m "Initial commit from playground"
gh repo create meu-projeto --private --source=. --remote=origin --push
```
Depois é só deletar a pasta de dentro do `playground/` e rodar `./sync.sh`.
