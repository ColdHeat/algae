# algae

algae is a simple wrapper around [SeaweedFS](https://github.com/seaweedfs/seaweedfs) to provide an intuitive way to create an S3 server.

algae does not provide any functionality on top of seaweedfs, it just wraps the official Docker image and issues the commands to do the following:

* Create a single bucket
* Create an access key ID and secret key to use to access that bucket
* Do the above without having an AGPL license (unlike Minio)

## Usage

1. Modify docker-compose.yml to have your desired `ACCESS_KEY_ID`, `SECRET_KEY`, `BUCKET_NAME`.
2. docker compose up
3. Access SeaweedFS S3 on 127.0.0.1:8333

## Notes

It is not a goal of this project to add any significant functionality to SeaweedFS. The goal is just an easy to setup local S3 server.