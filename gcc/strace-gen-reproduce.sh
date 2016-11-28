#! /bin/bash -

usage_and_exit()
{
  cat <<- EOF
	Usage:

		$0 <strace-log-filename> [<repro-script-filename>]

	The first argument is an strace log obtained with strace -v (for environment
	variables). It creates a script (named as the second argument if specified,
	otherwise 'reproduce.sh') in the current directory.

	The generated script sets up the environment and invokes the first program
	whose invocation failed in the strace log with the same arguments.

	The failing program is started in a GDB session. To override this, specify
	GGA environment variable e.g.:

		GGA="" ./reproduce.sh
	EOF
  exit $1
}

if [ $# -lt 1 ]; then
  usage_and_exit 0
fi

newline() {
  echo >> "$1"
}

strace_log=$1
repro_script=${2:-reproduce.sh}

echo '#! /bin/bash -' > "$repro_script"
newline "$repro_script"
echo "# !! generated with $0 !!" >> "$repro_script"
newline "$repro_script"

fail_pid_first=$(cat "$strace_log" | grep 'exited with' | grep -v 'exited with 0' | head -1 | awk '{print $1}')
grep "$fail_pid_first" "$strace_log" | strace-exports.sh >> "$repro_script"

newline "$repro_script"
echo 'source common.sh' >> "$repro_script"
echo 'GA="gdb --args"' >> "$repro_script"
newline "$repro_script"

printf '${GGA-$GA} ' >> "$repro_script"
grep "$fail_pid_first" "$strace_log" |
  grep execve |
    sed -e 's;execve;;g' |
      grep -v resumed |
        sed -e 's;\].*$;;g' |
          command-reparse.py >> "$repro_script"

chmod +x "$repro_script"
