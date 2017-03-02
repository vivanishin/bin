#! /bin/sh -

if $(find --version > /dev/null 2>&1) && $(find --version 2>/dev/null | grep GNU > /dev/null 2>&1)
then
  # We have GNU find.
  gnu_compat="-regextype posix-basic"
fi

# Remove the last downloaded html (since that month was the last existing month at the moment
# of downloading and thus may be incomplete).
# This expects htmls of the form .../...2016-08.../....html
find . $gnu_compat -regex '.*[0-9]\{4,4\}-[0-9]\{2,2\}.*[.]html' |
    sed -e 's/.*\([0-9]\{4,4\}-[0-9]\{2,2\}\).*/\1 &/g'  |
        sort -n -t '-'  -k1,2 |
            tail -2 |
                awk '{ print $2 }'  |
                    xargs rm

# Download what we don't have.
wget -r -l 1 --no-clobber https://gcc.gnu.org/ml/gcc/
wget -r -l 1 --no-clobber https://gcc.gnu.org/ml/gcc-patches/
