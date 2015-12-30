#!/usr/bin/python
import sys
def state_to(newstate):
    global state, prev_state, states
    state, prev_state = newstate, state 
    if DEBUG:
        states += [newstate]

#FIXME: deal with comments //...
lines = []
for line in sys.stdin:
    line = line.replace("\\\\", "\\")
    lines += [line]

illegal, regular, in_string, after_backslash, in_regex, after_backslash_in_regex, in_brackets, in_one_line_comment, in_asterisk_comment, after_slash, expect_slash = "illegal", "regular", "in_string", "after_backslash", "in_regex", "after_backslash_in_regex", "in_brackets", "in_one_line_comment", "in_asterisk_comment", "after_slash", "expect_slash"
state, prev_state = regular, illegal
states = [regular]
res_string = ""
DEBUG = "DEBUG" in sys.argv
for line in lines:
    gen = (a for a in line)
    for i in gen:
        if state == regular:
            if i == "'":
                state_to(in_string)
                res_string += i
            elif i == "\\":
                state_to(after_backslash)
            elif i == "/":
                state_to(after_slash)
                res_string += i
            else:
                res_string += i 
        elif state == after_slash:
            if i == "/":
                state_to(in_one_line_comment)
            elif i == "*":
                state_to(in_asterisk_comment)
            elif i == "\\":
                state_to(after_backslash_in_regex)
            elif i == '[':
                state_to(in_brackets)
            else:
                state_to(in_regex)        
            res_string += i
        elif state == in_one_line_comment:
            if i == "\\":
                state_to(after_backslash)
            else:
                res_string += i
        elif state == in_asterisk_comment:
            if i == "*":
                state_to(expect_slash)
            res_string += i 
        elif state == expect_slash:
            if i == "/":
                state_to(regular)
            else:
                state_to(prev_state)
            res_string += i
        elif state == in_string:
            if i == "'":
                state_to(regular)
            res_string += i
        elif state == after_backslash:
            if i == "n":
                res_string += "\n"
                state_to(regular)
            elif i == '"':
                res_string += '"'
                state_to(prev_state)
            elif i == "t":
                res_string += "\t"
                state_to(prev_state)
            else:
                err = i
                try:
                    for j in xrange(30):
                        err += gen.next()
                finally:
                    if DEBUG:
                        print >> sys.stderr, states
                    print >> sys.stderr, err
                    print res_string
                    raise Exception("UNHANDLED CHARACTER AFTER BACKSLASH: \\" + i + "\nprev state = " + str(prev_state)) 
        elif state == in_regex:
            if i == "/":
                state_to(regular)
            elif i == '[':
                state_to(in_brackets)
            elif i == '\\':
                state_to(after_backslash_in_regex)
            res_string += i
        elif state == after_backslash_in_regex:
            state_to(in_regex)
            res_string += i
        elif state == in_brackets:
            if i == "]":
                state_to(in_regex)
            res_string += i

if DEBUG:
    print >> sys.stderr, states
print res_string
#print res_string.replace("\n\n", "\n")
#line = line.replace("\\n", "\n")
#line = line.replace('\\"', '\"')
