# uv 簡単ガイド

このdotfilesでは、Pythonのプロジェクト管理とCLIツールの実行に`uv`を使う想定です。
`Brewfile`にも`uv`を宣言しています。

## まず使う

Homebrewを使う場合:

```zsh
brew install uv
uv --version
```

既存のプロジェクトで試すだけなら、まず次のようにします。

```zsh
cd path/to/project
uv run python --version
```

`uv run`はプロジェクトの依存関係と`.venv`を使って実行するため、プロジェクト作業では`uvx`よりこちらを優先します。

## プロジェクトを作る・依存を管理する

```zsh
uv init my-project
cd my-project

uv add requests
uv add --dev pytest ruff
uv run python -c 'import requests; print(requests.__version__)'
uv run pytest
```

主な操作:

```zsh
uv sync       # pyproject.toml / uv.lockから環境を同期
uv lock       # lockfileだけ更新
uv tree       # 依存関係を表示
uv remove requests
```

`pyproject.toml`と`uv.lock`はプロジェクトの設定としてGit管理し、`.venv`は通常Git管理しません。
`uv sync`や`uv run`は`.venv`や`uv.lock`を変更することがあるので、実行後は`git diff`を確認します。

## 一度だけCLIツールを使う

インストールせずに実行するなら`uvx`を使います。`uvx`は`uv tool run`の短縮形です。

```zsh
uvx ruff check .
uvx ruff@latest check .
uvx --from httpie http --version
```

頻繁に使うツールは、ユーザー用の隔離環境へインストールします。

```zsh
uv tool install ruff
uv tool list
uv tool upgrade --all
uv tool uninstall ruff
uv tool update-shell
```

プロジェクトの依存関係を見せたいテストやlintには`uv run`、独立したCLIを一時実行するには`uvx`、常用CLIをPATHへ出すには`uv tool install`、という使い分けです。

## Pythonを管理する

```zsh
uv python list
uv python install 3.12
uv python pin 3.12
uv run python --version
```

Pythonの自動ダウンロードを避けたい場合は、必要に応じて`--no-python-downloads`を使います。

## Zsh補完を更新する

このリポジトリの生成済み補完を更新する場合:

```zsh
uv generate-shell-completion zsh > .zsh/functions/uv.zsh
```

更新後は次を確認します。

```zsh
zsh -n .zsh/functions/uv.zsh
zsh scripts/dotfiles-doctor
```

## 使い分けの目安

| 目的 | コマンド |
|---|---|
| プロジェクト依存を追加 | `uv add PACKAGE` |
| プロジェクト内で実行 | `uv run COMMAND` |
| CLIを一度だけ実行 | `uvx COMMAND` |
| CLIを常用インストール | `uv tool install PACKAGE` |
| Pythonを用意 | `uv python install VERSION` |

公式ドキュメント:

- [Installation](https://docs.astral.sh/uv/getting-started/installation/)
- [Working on projects](https://docs.astral.sh/uv/guides/projects/)
- [Using tools](https://docs.astral.sh/uv/guides/tools/)
- [Installing and managing Python](https://docs.astral.sh/uv/guides/install-python/)
- [CLI reference](https://docs.astral.sh/uv/reference/cli/)
