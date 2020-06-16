#!/bin/bash

pip install -r scripts/requirements_extract.txt
ERR=$?
if [ $ERR -ne 0 ]; then
   echo "Failed to install requirements: pip install: $ERR"
   exit $ERR
fi

mkdir -p extract/

# Do not extract original-mp3.tar.gz
for archive in "dev-clean.tar.gz" \
		"dev-other.tar.gz" \
		"intro-disclaimers.tar.gz" \
		"original-books.tar.gz" \
		"raw-metadata.tar.gz" \
		"test-clean.tar.gz" \
		"test-other.tar.gz" \
		"train-clean-100.tar.gz" \
		"train-clean-360.tar.gz" \
		"train-other-500.tar.gz"
do
	jug status -- scripts/extract.py $archive --output extract/
	jug execute -- scripts/extract.py $archive --output extract/ 1>> extract.out 2>> extract.err
done

rm files_count.stats
for dir in extract/*/*
do
	echo $(find $dir -type f | wc -l; echo $dir) >> files_count.stats
done

du -s extract/*/* > disk_usage.stats
