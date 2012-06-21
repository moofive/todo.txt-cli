#!/bin/bash

test_description='test the default priority feature

This test makes sure that default priorities can be set
and that if TODOTXT_DEFAULT_PRIORITY is undefined, no 
priority is automatically added.'

. ./test-lib.sh

#
# Add and list
#
test_todo_session 'cmd line no default priority' <<EOF
>>> TODOTXT_DEFAULT_PRIORITY= todo.sh add no default priority
1 no default priority
TODO: 1 added.

>>> todo.sh list
1 no default priority
--
TODO: 1 of 1 tasks shown
EOF


test_todo_session 'cmd line with default priority' <<EOF
>>> TODOTXT_DEFAULT_PRIORITY=D todo.sh add 'default priority'
2 (D) default priority
TODO: 2 added.

>>> todo.sh -p list
2 (D) default priority
1 no default priority
--
TODO: 2 of 2 tasks shown

>>> todo.sh -npf del 2
2 (D) default priority
TODO: 2 deleted.

>>> todo.sh -p ls
1 no default priority
--
TODO: 1 of 1 tasks shown
EOF

test_todo_session 'cmd line with default property override' <<EOF
>>> TODOTXT_DEFAULT_PRIORITY=D todo.sh add '(B) overridden priority'
2 (B) overridden priority
TODO: 2 added.

>>> TODOTXT_DEFAULT_PRIORITY=D todo.sh -p list
2 (B) overridden priority
1 no default priority
--
TODO: 2 of 2 tasks shown
EOF

test_tick

test_done
