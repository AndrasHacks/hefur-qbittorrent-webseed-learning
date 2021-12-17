## Learning Torrenting Stack

- hefur
- qbittorrent-nox
- mktorrent, webseed, what not :)

### Prerequisites:
`brew install mktorrent`
`pip3 install torf-clit`

### Full flow:

Development mode start of the containers:
`docker compose down && docker compose up --build --force-recreate -d`

To create the torrent file and have it served by Hefur:
`mktorrent -p -l 22 -a "http://torrent-stack-poc-tracker-1:6969/announce" -c "test_my_torrent_setup" -w http://torrent-stack-poc-webseed-1 -o "torrent_files/test.torrent" "files/test.txt" -v`

(sometimes Hefur does not notice it got the file and needs a restart...)

Look into the torrent with torf:
`torf ./torrent_files/test.torrent` --> info hash: `87917059abfd898fec3a13d4541082a602dd70b9`


```bash
curl -i \
--header 'Referer: http://localhost:8302' \
--data 'username=admin&password=adminadmin' \
http://localhost:8302/api/v2/auth/login

// this results in a cookie: SID=3LuzCUTniEChhLH44rGG7RJhcnq2TZxn, lets use that in the next
// curl to add the torrent to the qbittorrent-nox

curl -b 'SID=3LuzCUTniEChhLH44rGG7RJhcnq2TZxn' \
--header 'Referer: http://localhost:8302' \
--header 'Content-Type: multipart/form-data' \
--request POST http://localhost:8302/api/v2/torrents/add \
--form 'urls="http://torrent-stack-poc-tracker-1:6969/file/test.txt.torrent?info_hash=87917059abfd898fec3a13d4541082a602dd70b9"'

```