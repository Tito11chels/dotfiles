# dotfiles

## Zed / VS Code

設定本体は次の場所で管理しています。

- `zed/settings.json`
- `vscode/settings.json`

`.zshrc` を読み込んだあと、次を一度実行すると各アプリの標準設定パスへシンボリックリンクを作成できます。

```zsh
setup-editor-settings
```

対象パスは macOS では次のとおりです。

- Zed: `~/.config/zed/settings.json`
- VS Code: `~/Library/Application Support/Code/User/settings.json`

既存の設定ファイルがある場合は、同じ場所に日時付きのバックアップを作成してからリンクを作成します。以後はdotfiles側の設定を編集すれば、ZedとVS Codeの設定に反映されます。

## fzfでファイルを開く

通常の補完と同じようにTabを押すと、次のコマンドのパス引数をfzfで曖昧検索できます。

```zsh
code <Tab>
zed <Tab>
open <Tab>
```

入力途中の文字を残したまま候補を絞り込めます。`-` から始まる入力では、各コマンドの通常のオプション補完を優先します。その他のコマンドは既存のfzf-tab補完を使用します。

## Homebrewとdoctor

`Brewfile`は、CLIツール・macOSアプリ・フォント・Mac App Storeアプリをコメントで分類しています。インストールや更新を行う前に、まず確認だけ実行できます。

```zsh
brew-check
brew-install                 # 確認のみ
brew-install --apply         # Brewfileを実際に適用
brewup                       # 確認後にupdate / upgradeを実行
brew-update                  # outdatedの確認のみ
brew-update --apply          # update / upgradeを実行
brew-clean                   # cleanupのdry-run
brew-clean --apply           # 古いHomebrewバージョンを削除
```

`HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1`を設定しているため、通常の`brew upgrade`と`brewup`は`auto_updates true`のcaskを更新しません。formulaと、それ以外の更新可能なcaskは従来どおり対象になります。`--greedy`または`--greedy-auto-updates`を明示した場合は、この除外設定よりコマンドラインオプションが優先されます。

`HOMEBREW_NO_ASK=1`も設定しているため、Homebrew本体は`install`、`upgrade`、`reinstall`で確認プロンプトを表示しません。`brewup`と`brew-install --apply`にはdotfiles側の事前確認が引き続きありますが、通常の`brew upgrade`などを直接実行した場合は確認なしで処理が始まります。一時的に確認を戻す場合は`brew upgrade --ask`のように`--ask`を明示してください。

dotfilesの構文・JSON・依存・runtime管理をまとめて確認するには、次を実行します。インストールや削除は行いません。

```zsh
zsh scripts/dotfiles-doctor
zsh scripts/dotfiles-doctor --brew  # Homebrew Bundleの読み取り専用確認も実行
```

エディタ設定のリンクを試すだけなら、`setup-editor-settings --dry-run`を使えます。

## Julia / asdf

通常はHomebrewの`julia` formulaを使い、`brewup`で常にHomebrew上の最新安定版へ更新します。Juliaupは併用しません。

asdfのshimsがHomebrewよりPATHの前にあるため、ホームの`.tool-versions`では`julia system`を指定します。asdfの`system`はshimからHomebrewのJuliaへ処理を渡します。

```zsh
asdf set -u julia system
brewup
julia --version
```

`brewup`でHomebrew Juliaの実体が変わった場合、共有環境にIJuliaがあればkernelspecも自動的に再生成します。手動で再生成する場合は`julia-refresh-ijulia`を使えます。

VS CodeはPATH上のJuliaを自動検出するため、バージョン固有の`julia.executablePath`は設定していません。

パッケージは作業ディレクトリごとの`Project.toml` / `Manifest.toml`で管理します。プロジェクトを使うときは、対象ディレクトリで次を実行します。

```zsh
julia --project=.
```

初回はJuliaのPkg REPLで環境を再現します。

```julia
pkg> instantiate
```

特定バージョンが必要なプロジェクトだけasdfを使います。Julia pluginはURLを明示して追加し、対象プロジェクト内の`.tool-versions`へバージョンを保存します。

```zsh
asdf plugin add julia https://github.com/rkyleg/asdf-julia.git
asdf install julia 1.11.7
cd path/to/project
asdf set julia 1.11.7
julia --version
julia --project=.
```

プロジェクトを指定しない場合はJuliaの共有環境`@v#.#`が使われます。`JULIA_PROJECT`、`JULIA_LOAD_PATH`、`JULIA_DEPOT_PATH`、thread数はグローバルに固定していません。

Homebrew更新後にIJuliaカーネルが起動しない場合は、IJulia内ではなくterminalから再生成します。

```zsh
julia-refresh-ijulia
```

## Python / uv

uvの基本操作は[README_UV.md](README_UV.md)にまとめています。プロジェクト依存には`uv add` / `uv sync` / `uv run`、一度だけ使うCLIには`uvx`、常用CLIには`uv tool install`を使い分けます。

秘密情報はリポジトリ内に置かず、GitHub CLIやmacOS Keychainなどの管理機能を優先してください。`.env`、`*.local`、credentialsディレクトリはGitの対象外にしていますが、既に追跡された秘密情報を自動削除するものではありません。
