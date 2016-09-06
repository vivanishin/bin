BEGIN { FS = "\n"; RS = "\n\n" }

(tolower($3) ~ tolower(topic)) && (tolower($4) ~ tolower(name)) {
    printf ("%s %20s\t/  %s\n", getdate(FILENAME), dehtml($4), dehtml($3))
}

# Get rid of html tags
# This assumes there are no < > in the subject/author's name.
function dehtml(str,    start, end)
{
    # > not followed by a < is the sign that what follows is not a tag.
    start = match(str, />[^<]/) + 1
    # Likewise, < not preceded by a > and by the line beginning designates text end.
    end = match(str, /[^>]+</) + RLENGTH - 1
    return substr(str, start, end - start)
}

# gcc.gnu.org/ml/gcc/2016-06/index.html -> /2016-06/
function getdate(filename)
{
    if (match(filename, /\/[0-9]{4,4}-[0-9]{2,2}.?\//))
        return substr(filename, RSTART, RLENGTH)
    else
        return "/date-unprased/"
}
