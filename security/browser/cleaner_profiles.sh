#!bin/bash
cleanb() {
# Put this file inside the dir that contain the profiles of browser
find . -depth -name "cache2" -type d -exec rm -r {} \;
find . -depth -name "datareporting" -type d -exec rm -r {} \;
find . -depth -name "safebrowsing" -type d -exec rm -r {} \;
find . -depth -name "security_state" -type d -exec rm -r {} \;
find . -depth -name "sessionstore-backups" -type d -exec rm -r {} \;
find . -depth -name "startupCache" -type d -exec rm -r {} \;
find . -depth -name "storage" -type d -exec rm -r {} \;
find . -depth -name "addonStartup.json.lz4" -type d -exec rm -r {} \;
find . -depth -name "cert9.db" -type d -exec rm -r {} \;
find . -depth -name "content-prefs.sqlite" -type d -exec rm -r {} \;
find . -depth -name "cookies.sqlite-wal" -type d -exec rm -r {} \;
find . -depth -name "favicons.sqlite" -type d -exec rm -r {} \;
find . -depth -name "formhistory.sqlite" -type d -exec rm -r {} \;
find . -depth -name "key4.db" -type d -exec rm -r {} \;
find . -depth -name "permissions.sqlite" -type d -exec rm -r {} \;
find . -depth -name "places.sqlite" -type d -exec rm -r {} \;
find . -depth -name "places.sqlite-wal" -type d -exec rm -r {} \;
find . -depth -name "protections.sqlite" -type d -exec rm -r {} \;
find . -depth -name "storage.sqlite" -type d -exec rm -r {} \;
find . -depth -name "webappsstore.sqlite" -type d -exec rm -r {} \;
}
cleanb
