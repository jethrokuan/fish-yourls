function shorten -d "Shorten URL" -a url keyword
  if test -z "$YOURLS_DOMAIN"
    printf "Please set YOURLS_DOMAIN to your domain name, e.g. tk.sg"
    return 1
  end
  
  if test -z "$YOURLS_SIG"
    printf "Please set YOURLS_SIG to your given signature"
    return 1
  end

  curl "http://$YOURLS_DOMAIN/yourls-api.php?signature=$YOURLS_SIG&action=shorturl&url=$url&keyword=$keyword&format=simple"
end
