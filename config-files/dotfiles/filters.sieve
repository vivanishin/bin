# Emacs' sieve-manage is a delight (has info).
# Alternatively, use sieve-connect:
# sieve-connect --upload --localsieve filters.sieve -s m***r.i***a.i****s.ru -u <user> [--notlsverify]

require ["copy","fileinto"];

if header :contains "Delivered-To" "gcc-patches@gcc.gnu.org" {
  fileinto "gcc-patches";
}

# if address :is ["From", "To", "Cc"]
# "gcc-patches@gcc.gnu.org" {
  # fileinto "gcc-patches";
# }

if header :matches "Subject" ["[Spam]"] {
  fileinto "Junk";
}

# rule:[fwd-compilers]
if header :contains "from" "moodle.cloud.unihub"
{
	redirect :copy "bmk-compilers@ispras.ru";
}
