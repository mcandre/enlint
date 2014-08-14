# enlint - encoding linter

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

* Recursive file search by default
* Optional ignore patterns
* Install via a standard programming language package manager

# EXAMPLES

```
$ enlint examples/
examples/polite-russian.html: observed iso-8859-1 preferred: /(utf-8|ascii|binary|unknown)/
```

# REQUIREMENTS

* [Ruby](https://www.ruby-lang.org/) 2+
* [file](http://darwinsys.com/file/)

## Optional

* [iconv](http://www.gnu.org/savannah-checkouts/gnu/libiconv/documentation/libiconv-1.13/iconv.1.html)

`iconv` can be used manually to help convert files to different encodings.

# INSTALL

Install via [RubyGems](http://rubygems.org/):

```
$ gem install enlint
```

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
