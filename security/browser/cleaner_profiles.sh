#!bin/bash
# Run this in the folder that have the profiles of browser
cleanb() {
find . -depth -name "cache2" -type d -exec rm -r {} \;
find . -type f -name "storage-sync-v2.sqlite" -delete
find . -type f -name "storage-sync-v2.sqlite-shm" -delete
find . -type f -name "storage-sync-v2.sqlite-wal" -delete
find . -depth -name "datareporting" -type d -exec rm -r {} \;
find . -depth -name "safebrowsing" -type d -exec rm -r {} \;
find . -depth -name "security_state" -type d -exec rm -r {} \;
find . -depth -name "sessionstore-backups" -type d -exec rm -r {} \;
find . -depth -name "startupCache" -type d -exec rm -r {} \;
find . -depth -name "storage" -type d -exec rm -r {} \;
find . -type f -name "addonStartup.json.lz4" -delete
find . -type f -name "cert9.db" -delete
find . -type f -name "content-prefs.sqlite" -delete
find . -type f -name "cookies.sqlite-wal" -delete
find . -type f -name "favicons.sqlite" -delete
find . -type f -name "formhistory.sqlite" -delete
find . -type f -name "key4.db" -delete
find . -type f -name "permissions.sqlite" -delete
find . -type f -name "places.sqlite" -delete
find . -type f -name "places.sqlite-wal" -delete
find . -type f -name "protections.sqlite" -delete
find . -type f -name "storage.sqlite" -delete
find . -type f -name "webappsstore.sqlite" -delete
}
cleanb
