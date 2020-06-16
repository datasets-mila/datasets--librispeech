#!/bin/bash

# This script is meant to be used with the command 'datalad run'

wget http://www.openslr.org/resources/12/md5sum.txt

for file_url in "http://www.openslr.org/resources/12/dev-clean.tar.gz dev-clean.tar.gz" \
                "http://www.openslr.org/resources/12/dev-other.tar.gz dev-other.tar.gz" \
                "http://www.openslr.org/resources/12/test-clean.tar.gz test-clean.tar.gz" \
                "http://www.openslr.org/resources/12/test-other.tar.gz test-other.tar.gz" \
                "http://www.openslr.org/resources/12/train-clean-100.tar.gz train-clean-100.tar.gz" \
                "http://www.openslr.org/resources/12/train-clean-360.tar.gz train-clean-360.tar.gz" \
                "http://www.openslr.org/resources/12/train-other-500.tar.gz train-other-500.tar.gz" \
                "http://www.openslr.org/resources/12/intro-disclaimers.tar.gz intro-disclaimers.tar.gz" \
                "http://www.openslr.org/resources/12/original-mp3.tar.gz original-mp3.tar.gz" \
                "http://www.openslr.org/resources/12/original-books.tar.gz original-books.tar.gz" \
                "http://www.openslr.org/resources/12/raw-metadata.tar.gz raw-metadata.tar.gz"
do
        echo ${file_url} | git-annex addurl -c annex.largefiles=anything --raw --batch --with-files
done

md5sum -c md5sum.txt
