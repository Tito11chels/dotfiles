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

## Python / uv

uvの基本操作は[README_UV.md](README_UV.md)にまとめています。プロジェクト依存には`uv add` / `uv sync` / `uv run`、一度だけ使うCLIには`uvx`、常用CLIには`uv tool install`を使い分けます。

秘密情報はリポジトリ内に置かず、GitHub CLIやmacOS Keychainなどの管理機能を優先してください。`.env`、`*.local`、credentialsディレクトリはGitの対象外にしていますが、既に追跡された秘密情報を自動削除するものではありません。
