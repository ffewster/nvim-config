# Managing plugins (vim.pack)

This config uses Neovim's built-in `vim.pack`, not `lazy.nvim`. There's no
`:Lazy` dashboard — updates go through `:lua vim.pack.update(...)`, which opens
an interactive confirmation buffer instead of a floating UI.

Every plugin here — core kickstart ones and custom ones alike — is added the
same way: bare `src`, no version pin, tracked via `nvim-pack-lock.json` like
everything else. Nothing moves until you deliberately run
`vim.pack.update(...)`, whether that's one plugin by name or everything at
once. `version` only shows up on a spec where it's a genuine branch/tag
selection (e.g. `neo-tree.nvim` defaults to `main`, but the stable line is the
separate `v3.x` branch — same idea as `nvim-treesitter`'s `version = 'main'`
in `init.lua`), never as a freeze mechanism.

- **Core kickstart plugins** — added in `init.lua` and
  `lua/kickstart/plugins/*.lua`, as upstream ships them.
- **Custom plugins** — every `vim.pack.add()` call for them lives in one
  place, `lua/custom/plugins/init.lua`. The individual files (`claude.lua`,
  `comment.lua`, etc.) only contain `require(...).setup{}` and keymaps — they
  don't call `vim.pack.add` themselves. This is deliberate: those files load
  in an unspecified order (see the auto-discovery loop comment in `init.lua`),
  so the `add()` calls have to happen earlier, in the one file guaranteed to
  run first.

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

## Switching a plugin's version/source, or freezing it

1. Edit its spec (in `init.lua` or `lua/custom/plugins/init.lua`) — set
   `version` to a commit, tag, branch, or a range like
   `vim.version.range('1.*')` if you want a ceiling; set it to an exact commit
   to freeze it in place.
2. Relaunch nvim (or `:restart`). This only updates the *target* in
   `nvim-pack-lock.json`, not the plugin on disk yet.
3. `:lua vim.pack.update({ 'PluginName' })`, review the diff, `:write` to apply
   (or `:quit` to discard — then revert your edit too, or it'll nag again).

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

## Custom plugin list

Lives in `lua/custom/plugins/init.lua`, in one `vim.pack.add {}` block at the
top of the file — that's the single source of truth for which custom plugins
exist and how each is specced, so there's no separate table here to go stale.

## Optional: a fancier UI

[pack.nvim](https://github.com/igmrrf/pack.nvim) wraps `vim.pack` in a
floating dashboard closer to what `lazy.nvim`'s `:Lazy` gave you. As of writing
it's very new (single maintainer, a handful of stars) and would sit in the
critical path of every plugin loading, so it hasn't been added here — the
built-in confirmation buffer above covers most of the same workflow already.
