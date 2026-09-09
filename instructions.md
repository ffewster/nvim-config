# Managing plugins (vim.pack)

This config uses Neovim's built-in `vim.pack`, not `lazy.nvim`. There's no
`:Lazy` dashboard — updates go through `:lua vim.pack.update(...)`, which opens
an interactive confirmation buffer instead of a floating UI.

Two categories of plugin here, updated differently:

- **Core kickstart plugins** (`init.lua`, `lua/kickstart/plugins/*.lua`) —
  no explicit commit pin from us, so they float on whatever
  branch/tag/range upstream's `init.lua` specifies.
- **Custom plugins** (`lua/custom/plugins/*.lua`) — pinned to an exact commit
  hash, so they never move until you edit the hash yourself.

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

1. Edit the `version = '<hash>'` field in its `lua/custom/plugins/*.lua` file
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

Delete its `vim.pack.add` call (and any `require`/setup) from the relevant
file, then:
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

| File | Plugin | Pinned commit |
|---|---|---|
| `claude.lua` | claudecode.nvim | `2390c6e45c4789072c293ac69de051d169668b29` |
| `comment.lua` | Comment.nvim | `e30b7f2008e52442154b66f7c519bfd2f1e32acb` |
| `copilot-chat.lua` | CopilotChat.nvim | `004ced055d8db59561cfcddc5f141ccd8d5a033b` |
| `copilot.lua` | copilot.lua | `901a6c564abb45c7703401ecc6416bb0d15afd37` |
| `markdown-render.lua` | render-markdown.nvim | `4663eb3ecd538bd5062628fb6d95bbe6bdca78f6` |
| `neo-tree-config.lua` | neo-tree.nvim | `f3f3bf73414e400cf9fc13fda50f00404a8f8ab1` |
| `neo-tree-config.lua` | nui.nvim | `10fc361835c856ba4233ef5ea135b919bf3dce97` |
| `sleuth.lua` | vim-sleuth | `be69bff86754b1aa5adcbb527d7fcd1635a84080` |
| `snacks.lua` | snacks.nvim | `882c996cf28183f4d63640de0b4c02ec886d01f2` |
| `tabs.lua` | barbar.nvim | `53b5a2f34b68875898f0531032fbf090e3952ad7` |
| `theme.lua` | gruvbox.nvim | `154eb5ff5b96d0641307113fa385eaf0d36d9796` |

This table goes stale the moment you bump a pin — treat it as a snapshot from
the last time this doc was written, not a live source of truth. `nvim-pack-lock.json`
is the actual source of truth.

## Optional: a fancier UI

[pack.nvim](https://github.com/igmrrf/pack.nvim) wraps `vim.pack` in a
floating dashboard closer to what `lazy.nvim`'s `:Lazy` gave you. As of writing
it's very new (single maintainer, a handful of stars) and would sit in the
critical path of every plugin loading, so it hasn't been added here — the
built-in confirmation buffer above covers most of the same workflow already.
