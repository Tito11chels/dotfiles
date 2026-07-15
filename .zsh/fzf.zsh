# fzfの基本設定
export FZF_DEFAULT_OPTS="
  --height 40%
  --reverse
  --border
  --color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af7
  --color=fg+:#c0caf5,bg+:#292e42,hl+:#7dcfff
  --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff
  --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a
"

# 現行fzfのZsh統合（Ctrl-T/Ctrl-R/Alt-Cと **<Tab> の曖昧補完）
# Homebrew未導入の環境でも、シェル全体の起動は継続する。
if (( $+commands[fzf] )); then
  source <(fzf --zsh)
fi

# code / zed / open のパス引数でも、cdと同じ感覚でTab補完する。
# fzf-completionは通常「**<Tab>」で起動するため、対象コマンドだけ
# Tab押下時にトリガーを自動付与する。他のコマンドは既存のfzf-tabへ委譲する。
_dotfiles_fzf_command_tab() {
  emulate -L zsh
  setopt localoptions noshwordsplit noposixbuiltins

  local -a tokens
  local command current_token
  tokens=(${(z)LBUFFER})
  command=${tokens[1]-}
  command=${command##*/}

  if [[ $LBUFFER == *' ' ]]; then
    current_token=''
  else
    current_token=${tokens[-1]-}
  fi

  case "$command" in
    code|zed|open)
      # -から始まる入力は、各CLIの通常のオプション補完を優先する。
      if [[ $current_token != -* && $+widgets[fzf-completion] -eq 1 ]]; then
        LBUFFER="${LBUFFER}**"
        zle fzf-completion
        return $?
      fi
      ;;
  esac

  if (( $+widgets[fzf-tab-complete] )); then
    zle fzf-tab-complete
  elif (( $+widgets[zic-completion] )); then
    zle zic-completion
  else
    zle ${fzf_default_completion:-expand-or-complete}
  fi
}

if (( $+widgets[fzf-completion] )); then
  zle -N dotfiles-fzf-command-tab _dotfiles_fzf_command_tab
  for keymap in emacs viins vicmd; do
    bindkey -M "$keymap" '^I' dotfiles-fzf-command-tab
  done
fi
