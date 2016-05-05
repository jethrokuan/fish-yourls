function __shorten_usage
  echo "Usage: shorten <url>       <keyword>     shorten a URl with optional keyword"
  echo "               -D/--delete <keyword>     delete a short URL by keyword"
  echo "               -h/--help                 show this help menu"
  functions -e __shorten_usage
end

function shorten -d "Shorten URL" -a url keyword
  if test -z "$YOURLS_DOMAIN"
    printf "Please set YOURLS_DOMAIN to your domain name, e.g. tk.sg"
    return 1
  end
  
  if test -z "$YOURLS_SIG"
    printf "Please set YOURLS_SIG to your given signature. Please visit your_domain/admin/tools.php."
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
    case -D --delete
      set -l key "$argv[2]"
      set -l deleted (fish -c "command curl --max-time 5 -s \"http://$YOURLS_DOMAIN/yourls-api.php?signature=$YOURLS_SIG&action=delete&shorturl=$key&format=simple\"  ^ /dev/stderr & await")
      if test -z "$deleted"
        echo "✘ Nothing was deleted."
      else
        echo "✓ Deleted http://$YOURLS_DOMAIN/$key"
      end
      return 0
  end

  set -l url_regex "(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]"

  if echo "$url" | grep -q -E $url_regex
    set -l url "$url"
  else
    echo "shorten: I can only handle proper urls." > /dev/stderr
    return 1
  end

  set -l curl_cmd

  if set -q keyword 
    set curl_cmd "command curl --max-time 5 -s \"http://$YOURLS_DOMAIN/yourls-api.php?signature=$YOURLS_SIG&action=shorturl&url=$url&keyword=$keyword&format=simple\" ^ /dev/stderr & await"
  else
    set curl_cmd "command curl --max-time 5 -s \"http://$YOURLS_DOMAIN/yourls-api.php?signature=$YOURLS_SIG&action=shorturl&url=$url&format=simple\" ^ /dev/stderr  & await"
  end

  set -l result (fish -c "$curl_cmd")

  if test ! -z "$result"
    printf "✓ Short URL created: %s\n" "$result"
  else
    printf "✘ Something went wrong!"
  end
end
