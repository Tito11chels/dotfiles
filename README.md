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
