function __shorten_usage
  echo "Usage: shorten <url> <keyword>"
  functions -e __shorten_usage
end

function shorten -d "Shorten URL" -a url keyword
  if test -z "$YOURLS_DOMAIN"
    printf "Please set YOURLS_DOMAIN to your domain name, e.g. tk.sg"
    return 1
  end
  
  if test -z "$YOURLS_SIG"
    printf "Please set YOURLS_SIG to your given signature"
    return 1
  end

  if set -q argv[3]
    echo "shorten: I wasn't expecting this argument '$argv[3]'." > dev/stderr
    __shorten_usage > /dev/stderr
  end

  switch "$argv[1]"
    case -h --help
      __shorten_usage > /dev/stdout
      return
  end

  switch "$url"
    case http{,s}://\?\*
      set -l url
    case \*
      echo "shorten: I can only handle proper urls." > /dev/stderr
      return 1
  end

  switch "$keyword"
    case ""
      set keyword "blank"
    case \*
      set keyword "$argv[2]"
  end

  if test $keyword = "blank"
    curl "http://$YOURLS_DOMAIN/yourls-api.php?signature=$YOURLS_SIG&action=shorturl&url=$url&format=simple"
  else
    curl "http://$YOURLS_DOMAIN/yourls-api.php?signature=$YOURLS_SIG&action=shorturl&url=$url&keyword=$keyword&format=simple"
  end
end
