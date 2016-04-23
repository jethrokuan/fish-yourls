function shorten -d "Shorten URL" -a url keyword
  if test -z "$YOURLS_DOMAIN"
    printf "shorten needs a web domain to function"
    return 1
  end
  
  if test -z "$YOURLS_SIG"
    printf "needs a signature to function"
    return 1
  end

  curl "http://$YOURLS_DOMAIN/yourls-api.php?signature=$YOURLS_SIG&action=shorturl&url=$url&keyword=$keyword&format=simple"
end
