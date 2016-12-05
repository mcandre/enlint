# enlint - encoding linter

`enlint` helps identify strange file encodings, that may cause problems with software interoperability.

# EXAMPLES

```
$ enlint examples/
examples/hello-wrong.bat: observed utf-8 preferred: /(ascii|utf-16)/
examples/polite-russian.html: observed iso-8859-1 preferred: /(utf-8|ascii|binary|unknown)/

$ enlint -i '*.html' examples/
examples/hello-wrong.bat: observed utf-8 preferred: /(ascii|utf-16)/

$ enlint -i '*.html' -i '*.bat' examples/
$

$ enlint -h
Usage: enlint [options] [<files>]
    -i, --ignore pattern             Ignore file patterns (fnmatch)
    -h, --help                       Print usage info
    -v, --version                    Print version info
```

Note: Sometimes enlint correctly identifies a non-UTF-8 encoded file, but misidentifies the actual encoding used, due to limitations in the Unix `file` program.

We suggest using some additional programs along with context clues to identify the exact encoding used. Only when the original encoding is correctly identified can the file be correctly converted into the preferred encoding.

```
$ enlint examples/polite-russian.html
examples/polite-russian.html: observed iso-8859-1 preferred: /(utf-8|ascii|binary|unknown)/

$ file -I examples/polite-russian.html
examples/polite-russian.html: text/html; charset=iso-8859-1

$ iconv -f iso-8859-1 -t utf-8 examples/polite-russian.html | tail -n 3 | head -n 1
<p>äÏ Ó×ÉÄÁÎÉÑ! [Do svidanija!] (Goodbye!)</p>

$ enca -i -L russian examples/polite-russian.html
KOI8-R

$ iconv -f koi8-r -t utf-8 examples/polite-russian.html | tail -n 3 | head -n 1
<p>До свидания! [Do svidanija!] (Goodbye!)</p>
```

# HOMEPAGE

https://github.com/mcandre/enlint

# RUBYGEMS

https://rubygems.org/gems/enlint

# ABOUT

enlint scans large projects for strange text file encodings, which may cause issues with some software.

* The World Wide Web encourages UTF-8 encoding for electronic text content, so that web pages in any foreign languge may be rendered by Web browsers anywhere in the world. `.html` content should be UTF-8.
* ASCII is considered deprecated, though still acceptable where non-US characters are not used. `.txt` files are often ASCII.
* Windows is an outlier, deciding prematurely to use UTF-16 instead of the world's de facto format, UTF8. `.reg` files are best left in ASCII or UTF-16.

Either way, enlint can help identify which files in your projects may be in the "wrong" format, helping resolve encoding-related errors across different computer systems.

enlint is a shell wrapper around the traditional Unix [file](http://darwinsys.com/file/) program, presenting a frontend similar to modern linters like [Reek](https://github.com/troessner/reek/wiki) and [JSHint](http://jshint.com/).

* Recursive file scanning, like `jshint .`
* Optional ignore patterns, like `.gitignore`
* Configuration via per-project and per-user [dotfiles](https://github.com/mcandre/enlint/blob/master/CONFIGURE.md#dotfiles)
* Install via a standard programming language package manager

Note that when UTF-8 text contains purely ASCII characters, software will typically identify the encoding as ASCII rather than UTF-8.

# REQUIREMENTS

* [ruby](https://www.ruby-lang.org/) 2.3+
* [file](http://darwinsys.com/file/)

## Optional

* [enca](https://github.com/nijel/enca) can guess file encodings, provided a few context clues.
* [moreutils](http://joeyh.name/code/moreutils/) provides `isutf8`, a program for checking whether files are UTF-8 encoded.
* [iconv](http://www.gnu.org/savannah-checkouts/gnu/libiconv/documentation/libiconv-1.13/iconv.1.html) can be used manually to help convert files to different encodings.
* [pargs](https://github.com/mcandre/pargs)
* [editorconfig-tools](https://www.npmjs.com/package/editorconfig-tools)

# INSTALL

Install via [RubyGems](http://rubygems.org/):

```
$ gem install enlint
```

# CONFIGURE

See [CONFIGURE.md](https://github.com/mcandre/enlint/blob/master/CONFIGURE.md) for details.

# LICENSE

FreeBSD

# DEVELOPMENT

## Testing

Keep the interface working:

```
$ cucumber
```

## Linting

Keep the code tidy:

```
$ rake lint
```

## Git Hooks

See `hooks/`.
