# Памятка по управлению NixOS-конфигурацией

Репозиторий находится в:

```text
/etc/nixos
```

Текущий компьютер использует хост:

```text
t14
```

Основная команда применения:

```sh
cd /etc/nixos
sudo nixos-rebuild switch --flake .#t14 --accept-flake-config
```

## Как устроена конфигурация

Главные точки входа:

| Путь | Назначение |
| --- | --- |
| `flake.nix` | Inputs, formatter и список компьютеров |
| `host/t14/` | Настройки текущего ноутбука |
| `host/i5-5060/` | Заготовка для Intel i5 и RTX 5060 |
| `modules/` | Системные настройки NixOS |
| `home/` | Пользовательские настройки Home Manager |
| `docs/` | Инструкции и документация |

Системный уровень `modules/` отвечает за:

- загрузчик и ядро;
- драйверы и оборудование;
- пользователей;
- сеть и VPN;
- Niri, greetd и системные сервисы;
- программы, доступные всей системе.

Пользовательский уровень `home/` отвечает за:

- Kitty, fish и starship;
- tmux, btop и yazi;
- Git, delta, fzf и zoxide;
- Gruvbox-тему;
- пользовательские конфиги Niri и Noctalia;
- программы и dotfiles пользователя `mrgnl`.

## Как установить GUI-программу

Открой:

```text
modules/packages/gui/apps.nix
```

Добавь имя пакета в список:

```nix
environment.systemPackages = with pkgs; [
  firefox
  obsidian
  spotify
];
```

Проверить существование пакета:

```sh
nix search nixpkgs имя-пакета
```

Или точнее:

```sh
nix eval --raw nixpkgs#имя-пакета.name
```

После изменения выполни проверки и `switch`.

## Как установить системную CLI-программу

Используй одну из категорий:

```text
modules/packages/cli/core.nix
modules/packages/cli/archive.nix
modules/packages/cli/diagnostics.nix
```

Сюда кладутся программы, которые должны быть доступны также root и в
восстановительной консоли.

Пример:

```nix
environment.systemPackages = with pkgs; [
  curl
  git
  ripgrep
];
```

## Как установить пользовательскую CLI-программу

Используй подходящий файл:

```text
home/packages/development.nix
home/packages/documents.nix
home/packages/monitoring.nix
home/packages/networking.nix
home/packages/shell-helpers.nix
```

Пример:

```nix
home.packages = with pkgs; [
  gh
  neovim
];
```

Такие программы принадлежат пользовательскому окружению Home Manager.

## Как настроить отдельную программу

Настройки программ находятся в:

```text
home/programs/
```

Примеры:

```text
home/programs/terminal/kitty.nix
home/programs/shell/fish.nix
home/programs/shell/starship.nix
home/programs/btop/
home/programs/yazi/
home/programs/git/
```

Если программа требует нескольких файлов, создай отдельную директорию:

```text
home/programs/program-name/default.nix
home/programs/program-name/settings.nix
home/programs/program-name/theme.nix
```

Подключи её в:

```text
home/profiles/terminal.nix
```

## Как изменить Niri

Конфиги находятся в:

```text
home/desktop/niri/
```

Назначение файлов:

| Файл | Содержимое |
| --- | --- |
| `keybinds.nix` | Горячие клавиши |
| `input.nix` | Клавиатура, мышь и тачпад |
| `display.nix` | Мониторы |
| `layout.nix` | Размеры, рамки и расположение окон |
| `rules.nix` | Правила приложений и окон |
| `animation.nix` | Анимации |
| `autostart.nix` | Автозапуск программ |
| `misc.nix` | Остальные настройки |

После изменения проверь итоговый конфиг:

```sh
niri validate -c ~/.config/niri/config.kdl
```

## Как изменить Gruvbox-тему

Основная палитра:

```text
home/common/colors.nix
```

GTK, иконки и курсор:

```text
home/common/theme/
```

Настройки отдельных приложений лежат рядом с приложениями:

```text
home/programs/btop/theme.nix
home/programs/yazi/flavor-gruvbox.nix
home/programs/terminal/kitty.nix
```

## Обязательные проверки

Сначала перейди в репозиторий:

```sh
cd /etc/nixos
```

Проверить форматирование:

```sh
nix fmt --accept-flake-config -- --ci
```

Автоматически отформатировать:

```sh
nix fmt .
```

Проверить все flake outputs:

```sh
nix flake check --accept-flake-config
```

Проверить сборку текущего компьютера без применения:

```sh
nixos-rebuild dry-build --flake .#t14 --accept-flake-config
```

Применить конфигурацию:

```sh
sudo nixos-rebuild switch --flake .#t14 --accept-flake-config
```

## Как проверить систему после switch

Показать упавшие systemd-сервисы:

```sh
systemctl --failed
```

Проверить Home Manager:

```sh
systemctl status home-manager-mrgnl.service
```

Посмотреть подробный журнал Home Manager:

```sh
journalctl -u home-manager-mrgnl.service -b --no-pager
```

Проверить VPN:

```sh
systemctl status wg-quick-awg0.service
ip addr show awg0
```

## Как откатиться

Показать поколения системы:

```sh
sudo nixos-rebuild list-generations
```

Откатить активную конфигурацию:

```sh
sudo nixos-rebuild switch --rollback
```

Также предыдущее поколение можно выбрать в меню загрузчика.

## Как работать с Git

Посмотреть изменения:

```sh
git status --short --branch
git diff
```

Добавить изменения:

```sh
git add путь-к-файлу
```

Создать commit. Сообщение пишется на английском в повелительном наклонении:

```sh
git commit -m "add spotify and obsidian"
git commit -m "fix niri window rules"
git commit -m "update terminal theme"
```

Отправить изменения:

```sh
git push -u origin "$(git branch --show-current)"
```
```

Если push отклонён из-за удалённых изменений, сначала не используй force.
Проверь историю и интегрируй изменения:

```sh
git fetch origin main
git log --oneline --graph --decorate --all -n 15
git merge origin/main
git push -u origin main
```

## Безопасный порядок работы

Для любого изменения используй один порядок:

```text
1. Изменить нужный файл.
2. Запустить nix fmt -- --ci.
3. Запустить nix flake check.
4. Запустить nixos-rebuild dry-build.
5. Посмотреть git diff.
6. Создать commit.
7. Запустить nixos-rebuild switch.
8. Проверить systemctl --failed.
9. Отправить commit в GitHub.
```

Не удаляй случайно:

```text
host/t14/hardware-configuration.nix
flake.lock
/etc/amnezia/awg0.conf
```

Файл `/etc/amnezia/awg0.conf` содержит секреты и не должен попадать в Git.
