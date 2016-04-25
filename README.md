# fish-yourls
CLI for [YOURLS].

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
