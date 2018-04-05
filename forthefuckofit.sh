#!/bin/bash
# apparently https://www.reddit.com/r/ProgrammerHumor/comments/89uhql/wtf_why_did_i_fail_this_interview_question/

crack="#"
kcarc=' '
i=1
j=10
for s in {1..10}
do
    for t in {10..1}
    do
        if [[ $i == 1 ]] || [[ $i == 10 ]]; then
            echo -n $crack
        else
            if [[ $t == $i ]] || [[ $t == $j ]] || [[ $t == 1 ]] || [[ $t == 10 ]]; then
                echo -n "$crack"
            else
                echo -n "$kcarc"
            fi
        fi
    done
    echo " "
    let i=(i + 1)
    let j=(j - 1)
done
