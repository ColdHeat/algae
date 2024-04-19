#!/bin/sh

check_port() {
    host="$1"
    port="$2"

    # Try to connect to the port
    nc -z "$host" "$port" >/dev/null 2>&1

    # Check the exit status of nc
    return $?
}

# Dynamic configuration worked much better but leaving this here in case we could use it later
sed -i "s/ACCESS_KEY_ID/$ACCESS_KEY_ID/g" /config.json
sed -i "s/SECRET_KEY/$SECRET_KEY/g" /config.json
sed -i "s/BUCKET_NAME/$BUCKET_NAME/g" /config.json

echo Starting with: "$@"

sh /entrypoint.sh $@ | /dev/stdout 2>&1 &

while ! check_port "127.0.0.1" "18888"; do
    echo "seaweed is not ready, waiting..."
    sleep 3
done

echo "seaweed is ready, waiting 3 more seconds before bootstrapping"
sleep 3
echo "s3.bucket.create -name $BUCKET_NAME" | weed shell
echo "s3.configure -access_key=$ACCESS_KEY_ID -secret_key=$SECRET_KEY -buckets=$BUCKET_NAME -user=me -actions=Read,Write,List,Tagging,Admin -apply" | weed shell
tail -f /dev/stdout