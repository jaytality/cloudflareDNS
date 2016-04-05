 #!/bin/sh
NEW_IP=`wget -O - -q http://ifconfig.me/ip`
CURRENT_IP=`cat /var/tmp/current_ip.txt`
if [ "$NEW_IP" = "$CURRENT_IP" ]
then
        echo "No Change in IP Adddress"
else
        curl https://www.cloudflare.com/api_json.html \
          -d 'a=rec_edit' \
          -d 'tkn=******cloudflare API token******' \
          -d 'email=cloudflare-email-account' \
          -d 'z=maindomain.name' \
          -d 'id=253633078' \
          -d 'type=A' \
          -d 'name=the.sub.domain.name' \
          -d 'ttl=1' \
          -d "content=$NEW_IP"
        echo $NEW_IP > /var/tmp/current_ip.txt
fi
