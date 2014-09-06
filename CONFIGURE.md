# Configuration

EnLint offers multiple ways to resolve preferences:

1. Command-line flags (`enlint -i`)
2. Dotfiles (`.enlintignore`, `.enlintrc.yml`)
3. Built-in defaults (`DEFAULT_IGNORES`, `DEFAULT_RULES`)

Any command-line flags that are present override the same settings in dotfiles and built-in defaults.

# Command-line flags

Run `enlint -h` or `enlint --help` for a full list, or refer to the source code for `bin/enlint`.

```
$ enlint -h
Usage: enlint [options] [<files>]
    -i, --ignore pattern             Ignore file names matching Ruby regex pattern
    -h, --help                       Print usage info
    -v, --version                    Print version info
```

# Dotfiles

EnLint automatically applies any `.enlintignore` and/or `.enlintrc.yml` configuration files in the same directory as a file being scanned, or a parent directory (`../.enlintignore`, `../.enlintrc.yml`), up to `$HOME/.enlintignore`, `$HOME/.enlintrc.yml`, if any such files exist.

## `.enlintignore`

Samples:

* [examples/.enlintignore](https://github.com/mcandre/enlint/blob/master/examples/www-arabic/.enlintignore)

A `.enlintignore` may contain Ruby regex patterns of files and/or folders to exclude from scanning, one pattern per line.

## `.enlintrc.yml`

Samples:

* [examples/.enlintrc.yml](https://github.com/mcandre/enlint/blob/master/examples/.enlintrc.yml)

`.enlintrc.yml` may contain a number of keys:

* `rules` may be a list of rules.

A rule is a two element list, of a filename pattern and an encoding preference.

Filename patterns and encoding preferences are each Ruby regexps.

# Built-in defaults

`rules` defaults to:

```
[
  [/\.reg$/, /(ascii|utf-16)/],
  [/\.bat$/, /(ascii|utf-16)/],
  [/\.ps1$/, /(ascii|utf-16)/],
  [/.*/, /(utf-8|ascii|binary|unknown)/]
]
```
