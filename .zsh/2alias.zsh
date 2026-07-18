alias ls="lsd -A"
alias ll="lsd -Al"
alias cat="bat"

# neovimがインストールされている場合はnvimを優先
if command -v nvim >/dev/null 2>&1; then
    alias vim="nvim"
fi

# rgは標準のgrepと引数・終了コードが異なるため、grep自体は上書きしない。
alias rgrep="rg --color=auto"

tx() {
    emulate -L zsh

    local force=0
    local dry_run=0
    local source target i
    local -a sources=(
        "$HOME/latexconfig/.textlintrc.json"
        "$HOME/latexconfig/latexindent.yaml"
    )
    local -a targets=(
        "$PWD/.textlintrc.json"
        "$PWD/latexindent.yaml"
    )

    while (( $# > 0 )); do
        case "$1" in
            --force) force=1 ;;
            --dry-run) dry_run=1 ;;
            -h|--help)
                print 'usage: tx [--dry-run] [--force]'
                return 0
                ;;
            *)
                print -u2 "tx: unknown option: $1"
                return 2
                ;;
        esac
        shift
    done

    for source in "${sources[@]}"; do
        if [[ ! -f "$source" ]]; then
            print -u2 "tx: template not found: $source"
            return 1
        fi
    done

    for target in "${targets[@]}"; do
        if [[ -e "$target" && $force -eq 0 ]]; then
            print -u2 "tx: refusing to overwrite $target (use --force to allow it)"
            return 1
        fi
    done

    if (( dry_run )); then
        print "Would copy:"
        for (( i = 1; i <= $#sources; i++ )); do
            print "  ${sources[$i]} -> ${targets[$i]}"
        done
        return 0
    fi

    for (( i = 1; i <= $#sources; i++ )); do
        cp "${sources[$i]}" "${targets[$i]}" || return 1
    done
}

alias tt="tree -N ."
alias nv="nvim ."

# # Homebrew 実行時に pyenv/anyenv/asdf などの shims を PATH から一時的に除外するエイリアス
# alias brew="env PATH=${PATH/\/Users\/$USER\/\.*env:/} brew"

# ここから便利エイリアスの例（用途に応じて追加）
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

mkcd() {
    emulate -L zsh
    if (( $# != 1 )); then
        print -u2 'usage: mkcd DIRECTORY'
        return 2
    fi
    mkdir -p -- "$1" && builtin cd -- "$1"
}
alias mkcd=mkcd

brew-check() {
    emulate -L zsh
    local dotfiles_dir="${DOT_DIR:-$HOME/dotfiles}"
    local brewfile="${1:-$dotfiles_dir/Brewfile}"
    command brew bundle check --file="$brewfile" --verbose
}

_dotfiles_confirm() {
    emulate -L zsh
    local reply
    read -q "reply?$1 [y/N] " || { print; return 1; }
    print
}

brew-install() {
    emulate -L zsh
    local apply=0
    local dotfiles_dir="${DOT_DIR:-$HOME/dotfiles}"
    local brewfile
    if [[ ${1-} == '--apply' ]]; then
        apply=1
        shift
    fi
    brewfile="${1:-$dotfiles_dir/Brewfile}"
    if (( ! apply )); then
        print "Dry run only. Use 'brew-install --apply [Brewfile]' to install."
        brew-check "$brewfile"
        return $?
    fi
    _dotfiles_confirm "Install or update the entries in $brewfile?" || return 1
    command brew bundle install --file="$brewfile"
}

julia-refresh-ijulia() {
    emulate -L zsh
    local julia_exe

    if ! command brew list --formula julia >/dev/null 2>&1; then
        print -u2 'julia-refresh-ijulia: Homebrew julia is not installed'
        return 1
    fi

    julia_exe="$(command brew --prefix julia)/bin/julia"
    if [[ ! -x "$julia_exe" ]]; then
        print -u2 "julia-refresh-ijulia: executable not found: $julia_exe"
        return 1
    fi

    "$julia_exe" -e '
        using Pkg
        if haskey(Pkg.project().dependencies, "IJulia")
            Pkg.build("IJulia")
        else
            println("IJulia is not installed in ", Base.active_project(), "; skipping kernelspec rebuild")
        end
    '
}

brew-update() {
    emulate -L zsh
    local julia_before='' julia_after='' julia_exe
    if [[ ${1-} != '--apply' ]]; then
        print "Dry run only. Use 'brew-update --apply' to update formulae and casks."
        command brew outdated
        return $?
    fi
    _dotfiles_confirm 'Run brew update and brew upgrade?' || return 1

    if command brew list --formula julia >/dev/null 2>&1; then
        julia_exe="$(command brew --prefix julia)/bin/julia"
        [[ -e "$julia_exe" ]] && julia_before="${julia_exe:A}"
    fi

    command brew update && command brew upgrade || return $?

    if command brew list --formula julia >/dev/null 2>&1; then
        julia_exe="$(command brew --prefix julia)/bin/julia"
        [[ -e "$julia_exe" ]] && julia_after="${julia_exe:A}"
    fi

    if [[ -n "$julia_after" && "$julia_after" != "$julia_before" ]]; then
        julia-refresh-ijulia || print -u2 'WARN Julia was updated, but the IJulia kernelspec refresh failed'
    fi
}

brew-clean() {
    emulate -L zsh
    if [[ ${1-} != '--apply' ]]; then
        print "Dry run only. Use 'brew-clean --apply' to remove old Homebrew versions."
        command brew cleanup --dry-run
        return $?
    fi
    _dotfiles_confirm 'Remove old Homebrew versions and caches?' || return 1
    command brew cleanup
}

# brewupは確認後に実際のformulae/cask更新を実行する。
# auto_updates trueのcaskはHOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKSにより除外される。
# 更新対象の確認だけを行う場合はbrew-updateを使う。
brewup() { brew-update --apply; }
