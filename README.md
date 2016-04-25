# fish-yourls
CLI for [YOURLS].

[![asciicast](https://asciinema.org/a/1t3k1xxlxxtnn8xn7a7zoc8k4.png)](https://asciinema.org/a/1t3k1xxlxxtnn8xn7a7zoc8k4)

## Installation
With [fisherman]:
```fish
fisher jethrokuan/fish-yourls
```

## Variables
```fish
set -U YOURLS_DOMAIN example.com
set -U YOURLS_SIG acctoken
```

## Usage
``` bash
shorten <url>       <keyword>     shorten a URl with optional keyword
        -D/--delete <keyword>     delete a short URL by keyword
        -h/--help                 show this help menu
```

[YOURLS]:https://yourls.org/
[fisherman]:https://github.com/fisherman/fisherman
