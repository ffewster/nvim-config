# Managing plugins (vim.pack)

This config uses Neovim's built-in `vim.pack`, not `lazy.nvim`. There's no
`:Lazy` dashboard — updates go through `:lua vim.pack.update(...)`, which opens
an interactive confirmation buffer instead of a floating UI.

Two categories of plugin here, updated differently:

- **Core kickstart plugins** (`init.lua`, `lua/kickstart/plugins/*.lua`) —
  no explicit commit pin from us, so they float on whatever
  branch/tag/range upstream's `init.lua` specifies.
- **Custom plugins** — every `vim.pack.add()` call for them lives in one
  place, `lua/custom/plugins/init.lua`, each pinned to an exact commit hash so
  none of them move until you edit the hash yourself. The individual files
  (`claude.lua`, `comment.lua`, etc.) only contain `require(...).setup{}` and
  keymaps — they don't call `vim.pack.add` themselves. This is deliberate:
  those files load in an unspecified order (see the auto-discovery loop
  comment in `init.lua`), so the `add()` calls have to happen earlier, in the
  one file guaranteed to run first.

## Everyday commands

Check what's installed (name, current rev, path, spec):
```vim
:lua =vim.pack.get()
```

Preview + apply updates for everything (opens confirmation buffer, downloads first):
```vim
:lua vim.pack.update()
```

Update just one plugin (name from `vim.pack.get()`, not the file name):
```vim
:lua vim.pack.update({ 'Comment.nvim' })
```

Preview without downloading (e.g. after only editing a `version` field):
```vim
:lua vim.pack.update({ 'Comment.nvim' }, { offline = true })
```

Skip the confirmation buffer and apply immediately:
```vim
:lua vim.pack.update({ 'Comment.nvim' }, { force = true })
```

### In the confirmation buffer

- `]]` / `[[` — jump between plugin sections
- `gO` — outline of all plugins in the buffer
- `K` on a pending change — hover for changelog/details
- `gra` on a plugin — code actions: update / skip / delete it
- `:write` — apply everything shown; `:quit` — discard

## Bumping one of our pinned custom plugins

1. Edit its `version = '<hash>'` entry in `lua/custom/plugins/init.lua`
   — set it to a newer commit, a tag, or a branch name if you want it to float.
2. Relaunch nvim (or `:restart`). This only updates the *target* in
   `nvim-pack-lock.json`, not the plugin on disk yet.
3. `:lua vim.pack.update({ 'PluginName' })`, review the diff, `:write` to apply
   (or `:quit` to discard — then revert your edit too, or it'll nag again).

## Freezing / unfreezing a plugin

- **Freeze**: set `version` to its current revision (`rev` field from
  `vim.pack.get()` or `nvim-pack-lock.json`), then restart.
- **Unfreeze**: set `version` to a branch name (e.g. `'main'`) or a range
  (`vim.version.range('1.*')`), restart, then run `vim.pack.update()`.

## Reverting a bad update

```sh
git checkout HEAD -- nvim-pack-lock.json   # nvim-pack-lock.json is tracked in git
```
```vim
:restart
:lua vim.pack.update({ 'PluginName' }, { offline = true, target = 'lockfile' })
```
Review and confirm.

## Removing a plugin

Delete its entry from the `vim.pack.add {}` block in
`lua/custom/plugins/init.lua`, delete its own file under
`lua/custom/plugins/` (the `require(...).setup{}`/keymaps), then:
```vim
:lua vim.pack.del({ 'PluginName' })
```

## Where things live

- Lockfile: `nvim-pack-lock.json` (tracked in this repo — un-ignored on
  purpose, see `.gitignore`).
- Update history: `nvim-pack.log` under `:lua print(vim.fn.stdpath('log'))`.
- Plugin checkouts (plain git repos): `~/.local/share/nvim/site/pack/core/opt/<name>/`
- Docs: `:help vim.pack`, `:help vim.pack-examples`, `:help vim.pack-lockfile`

## Current custom plugin pins

Live in `lua/custom/plugins/init.lua`, in one `vim.pack.add {}` block at the
top of the file — that's the single source of truth for which custom plugins
exist and what they're pinned to, so there's no separate table here to go
stale.

## Optional: a fancier UI

[pack.nvim](https://github.com/igmrrf/pack.nvim) wraps `vim.pack` in a
floating dashboard closer to what `lazy.nvim`'s `:Lazy` gave you. As of writing
it's very new (single maintainer, a handful of stars) and would sit in the
critical path of every plugin loading, so it hasn't been added here — the
built-in confirmation buffer above covers most of the same workflow already.
