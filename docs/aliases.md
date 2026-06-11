# Алиасы терминала

Алиасы объявлены через Home Manager в
`home/programs/shell/fish.nix` и доступны в интерактивной оболочке Fish.

## Список

| Алиас | Выполняемая команда | Назначение |
| --- | --- | --- |
| `cat` | `bat` | Вывод файла с подсветкой синтаксиса |
| `du` | `dust` | Наглядный анализ занятого места |
| `find` | `fd` | Быстрый поиск файлов |
| `grep` | `rg` | Быстрый поиск текста через ripgrep |
| `la` | `eza -lah --group-directories-first --icons=auto` | Все файлы с подробной информацией |
| `ll` | `eza -lh --group-directories-first --icons=auto` | Подробный список файлов |
| `ls` | `eza --group-directories-first --icons=auto` | Обычный список файлов |
| `rebuild` | `sudo nixos-rebuild switch --flake /etc/nixos#t14` | Пересборка текущего ноутбука |
| `tree` | `eza --tree --group-directories-first --icons=auto` | Дерево каталогов |

Аргументы после алиаса передаются основной команде:

```sh
cat flake.nix
grep "nvidia" modules
find configuration.nix
ll /etc/nixos
tree --level 2
```

## Важные отличия

`cat`, `du`, `find` и `grep` заменены современными программами. Их параметры
не полностью совпадают с параметрами стандартных GNU-команд.

Оригинальную команду можно вызвать по полному пути:

```sh
/run/current-system/sw/bin/cat file.txt
/run/current-system/sw/bin/grep pattern file.txt
```

## Редактирование

Изменяй `shellAliases` в `home/programs/shell/fish.nix`, затем применяй
конфигурацию:

```sh
rebuild
```

Проверить активные алиасы в текущей оболочке:

```sh
alias
```

Git-алиасы в конфигурации пока не определены.
