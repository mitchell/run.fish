# swim.fish

swim.fish is a simple executable script and fish-based "DSL". It lets you easily compile and catalog
your project's most frequently run commands. Think `make` or `npm run`.

## Table of Contents

- [Getting Started](#getting-started)
- [Install `sw`](#install-sw)
- [Included Commands](#included-commands)
- [Self-executable swim.fish](#self-executable-swimfish)

## Getting Started

[*^ Back to Top ^*](#swimfish)

The easiest way to get started is by copy this repository's `swim.fish` to your own project's root
directory. Then replace this projects command functions with your own. They look like this:

```fish
function swim_your_command_name -a one_of n_args -d 'A sentence description of your command'
    fish shell content
    ...
end
```

The required prefix of `swim_` can be configured, by setting the `cmd_func_prefix` global variable
(located at the top of example swim.fish).

## Install `sw`

[*^ Back to Top ^*](#swimfish)

The only dependency is [fish itself](https://fishshell.com/).

The easiest way to install `sw` is by running this

`curl -fsS https://raw.githubusercontent.com/mitchell/swim.fish/master/sw >sw && chmod +x sw`

then copying `sw` to your preferred location in your binpath, like `/usr/local/bin` on .

## Included Commands

[*^ Back to Top ^*](#swimfish)

The following commands are included.

- `help`:
  - Examples:
    - `sw help`: Displays all top-level commands and their descriptions
    - `sw help <command>`: Displays the commands definition
    - `sw <command group> help`: Displays the group's commands and their descr
  - Aliases:
    - `--help`: If used with command group display group help, otherwise display command definition.
    - `-h`: Same as above
- `do`:
  - Examples:
    - `sw do <command> [arg ...], <command> [arg ...], ...`: Run the specified commands in sequence


## Self-executable swim.fish

[*^ Back to Top ^*](#swimfish)

If you wish to make your *swim.fish* file self-executable instead of installed `sw`. Then all you
have to do is add

```fish
#!/usr/bin/env fish
```

to the top of your *swim.fish*, and

```fish
curl -fsS https://raw.githubusercontent.com/mitchell/swim.fish/master/importable_sw.fish | source
run_swim_command $cmd_func_prefix $argv
```

to the bottom of your file.

Then you can run it like `./swim.fish <command>`.
