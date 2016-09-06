# ml-grep
# Finds messages by specified user containg specified words in gcc-patches ML archive.
# Usage:
#   ml-grep.sh name topic
# Either can be an empty string (denoted as "").
if [ $# -lt 2 ]
then
  echo "Usage: ml-grep.sh name topic"
  exit 1
fi

for i in gcc.gnu.org/ml/gcc/*/index.html
do
  echo $i | grep -v "current" > /dev/null 2>&1 || continue
  awk -v name="$1" -v topic="$2" -f getsubj.awk $i
done
