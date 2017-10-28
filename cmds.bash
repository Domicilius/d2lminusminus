#!/bin/bash
touch ../botideas
touch maintainerfile
randint=`dice 9`

read nick chan saying
if `echo $saying | grep -i '\bneed a\b' | grep -i '\bbot\b' > /dev/null` ; then
    echo "PRIVMSG $chan :$nick: you could write it... :^D"
    echo "$nick: $saying" >> ../botideas
elif `echo $saying | grep -i 'bot \bneeds\b' > /dev/null` ; then
    echo "PRIVMSG $chan :$nick: make a pull request :^D"
    echo "$nick: $saying" >> ../botideas
elif `echo $saying | grep -i 'bot' | grep -i 'should' | grep -i 'have' > /dev/null` ; then
    echo "PRIVMSG $chan :$nick: you could write it... :^D"
    echo "$nick: $saying" >> ../botideas
elif `echo $saying | grep -i 'feature \brequest\b' > /dev/null` ; then
    echo "PRIVMSG $chan :$nick: make a pull request :^D"
    echo "$nick: $saying" >> ../botideas
elif `echo $saying | grep -i '^nabb: botideas' > /dev/null` ; then
    chop=$(shuf -n 1 ../botideas)
    name=$(echo $chop | rev | cut -d ':' -f 2- | rev)
    says=$(echo $chop | rev | cut -d ':' -f 1 | rev)
    name=$(echo $name | sed s/[Aa]/4/g | sed s/[Ee]/3/g | sed s/[oO]/0/g | sed s/[iI]/1/g)
    chop=\"$name:$says\"
    echo "PRIVMSG $chan :$nick: $chop"   
elif `echo $saying | grep -i 'nabb: source' > /dev/null` ; then
    echo "PRIVMSG $chan :$nick: http://goo.gl/IIQt53 is my source file"
elif `echo $saying | grep -i '!dropthemic\b' > /dev/null` ; then
    echo "PRIVMSG $chan :OOOOH! You just got *served*!"
elif `echo $saying | grep -i 'nabb: are you a bot?' > /dev/null` ; then
    echo "PRIVMSG $chan :$nick: I sure am :^)"
elif `echo $saying | grep -i '!domsmugnessquotient' > /dev/null` ; then
    echo "PRIVMSG $chan :I think we all know..."
elif `echo $saying | grep -i 'sudo make me a sandwich' > /dev/null` ; then
    echo "PRIVMSG $chan :That isn't the way that works and you know it :^)"
elif `echo $saying | grep -i 'accio corndog' > /dev/null` ; then
    echo "PRIVMSG zb :zb buy corndog as $nick"
    echo "PRIVMSG $chan :got it! Fetching..."
elif `echo $saying | grep -i 'accio corn dog' > /dev/null` ; then
    echo "PRIVMSG zb :zb buy corndog as $nick"
    echo "PRIVMSG $chan :got it! Fetching..."
elif `echo $saying | grep -i 'nabb: make me a sandwich' > /dev/null` ; then
    if [ "$nick" = dom ] ; then
        echo "PRIVMSG $chan :$nick: Sure thing, buddy."
    elif [ "$nick" = relsqui ] ; then
        echo "PRIVMSG $chan :$nick: Alright, I *guess* I can make you a sandwich."
    elif [ "$nick" = Aatrox ] ; then
        echo "PRIVMSG $chan :$nick: I've got a Nature Valley bar, is that good enough?"
    elif [ "$nick" = sweets ] ; then
        echo "PRIVMSG $chan :$nick: Though I cannot give you proof that sandwiches exist, I do believe they are out there, and that we are not alone in the universe."
    elif [ "$nick" = wheezl ] ; then
        echo "PRIVMSG $chan :$nick: OK, here you go!"
    elif [ "$nick" = squid ] ; then
        echo "PRIVMSG $chan :$nick: Here's two pieces of SPAM bread with a nice thick slice of SPAM in the middle. De-lish."
    elif [ "$nick" = Envy ] ; then
        echo "PRIVMSG $chan :$nick: I cast Bread, floating 3 green mana, play Jelly, go up to 5, tutor for Peanut Butter, present lethal. Responses?"
    elif [ "$nick" = mancat ] ; then
        echo "PRIVMSG $chan :$nick: Make your own dang sandwich, Mannius J Aberforth Catt Felinus Jr!"
    elif [ "$nick" = tombat ] ; then
        echo "PRIVMSG $chan :$nick: Here you go. Its a hip new combination, but its pretty underground, you've probably never heard of it."
    elif [ "$nick" = thyme ] ; then
        echo "PRIVMSG $chan :$nick: Alright, its sandwich thyme."
    elif [ "$nick" = Reeves ] ; then
        echo "PRIVMSG $chan :$nick: I've always got time to make sandwiches for Neo."
    elif [ "$nick" = fouric ] ; then
        echo "PRIVMSG $chan :$nick: ((((((((((sandwich))))))))))"
    else
       echo "PRIVMSG $chan :$nick: Ehhhhh, I dunno."
    fi        
elif `echo $saying | grep -i '^nabb: help$' > /dev/null` ; then
    echo "PRIVMSG $chan :$nick: Reminds people complaining about bots that they could improve them as well."
    echo "PRIVMSG $chan :$nick: Also keeps track of who owns what bot. Ask dom for details. source: http://goo.gl/IIQt53"
elif `echo $saying | grep -i 'nabb: join\b' > /dev/null` ; then
    if [ "$nick" = dom ] ; then
        channel=`echo $saying | cut -d ' ' -f 3`
        chankey=`echo $saying | cut -d ' ' -f 4`
        echo "JOIN $channel $chankey"
    fi
elif `echo $saying | grep -i 'nabb: leave\b' > /dev/null` ; then
    if [ "$nick" = dom ] ; then
        channel=`echo $saying | cut -d ' ' -f 3`
        echo "PART $channel"
    fi
elif `echo $saying | grep -i 'nabb: dice\b' > /dev/null` ; then
        numberwang=`echo $saying | cut -d ' ' -f 3`
        newnumberwang=`dice $numberwang`
        echo "PRIVMSG $chan :$nick: $newnumberwang"
elif `echo $saying | grep -i 'nabb: spam\b' > /dev/null` ; then
    ticket=`echo $saying | cut -d ' ' -f 3` 
    if [ "$nick" = dom ] ; then
        if [[ $ticket =~ ^[0-9]{6}$ ]] ; then 
            snot -F SPAM $ticket
        fi 
    fi
elif `echo $saying | grep -i '^nabb:' | grep -i 'who ' | grep 'runs\|owns\|maintains' | grep "?" > /dev/null` ; then
    lookbot=$(echo `cat maintainerfile | grep $(echo $saying | sed s/nabb:// | awk -F 'runs|owns|maintains' '{print $2}' | sed s/?//g | tr '[:upper:]' '[:lower:]')` | cut -d ' ' -f 2- | tr '[:upper:]' '[:lower:]')
    lookerlook=$(echo $saying | sed s/nabb:// | awk -F 'runs|owns|maintains' '{print $2}' | sed s/?// | tr '[:upper:]' '[:lower:]' | sed s/^[[:space:]]*//)
    if ! grep "$lookerlook" maintainerfile >/dev/null; then
        echo "PRIVMSG $chan :$nick: I don't know anything about $lookerlook."
        continue
    else
        echo "PRIVMSG $chan :$nick: [$lookbot] run(s), own(s) or maintain(s) $lookerlook."
    fi
elif `echo $saying | grep -i '^nabb:' | grep 'run\|own\|maintain' | grep $'don\'t\|doesn\'t'> /dev/null` ; then
    saying=$(echo $saying | sed s/nabb://g | tr '[:upper:]' '[:lower:]')
    runner=$(echo $saying | awk -F 'run|own|maintain' '{print $1}' | tr '[:upper:]' '[:lower:]' | awk -F "don\'t|doesn\'t" '{print $1}' | sed s/^[[:space:]]*//)
    bot=$(echo $saying | awk -F 'run|own|maintain' '{print $2}' | tr '[:upper:]' '[:lower:]' | sed s/^[[:space:]]*//)
    if [ "$name" = I ] ; then
        runner=$nick
    fi
    if [ "$name" = i ] ; then
        runner=$nick
    fi
    echo "PRIVMSG $chan :$nick: $bot $runner"
    sed "/^$bot.*/ s/$runner, //" -i maintainerfile
    sed "/^$bot.*/ s/, $runner$//" -i maintainerfile
    sed "/^$bot.*/ s/ $runner$//" -i maintainerfile
elif `echo $saying | grep -i '^nabb:' | grep 'forget' > /dev/null` ; then
    if ! "$nick" = dom ; then
        continue
    fi
    bot=$(echo $saying | awk -F 'forget' '{print $2}' | tr '[:upper:]' '[:lower:]' | sed s/^[[:space:]]//)
    sed "/^$bot.*$/d" -i maintainerfile
    echo "PRIVMSG $chan :$nick: I forgot about $bot."
elif `echo $saying | grep -i '^nabb:' | grep 'run\|own\|maintain' > /dev/null` ; then
    saying=$(echo $saying | sed s/nabb://g | tr '[:upper:]' '[:lower:]')
    lookbot=$(echo $saying | awk -F 'run[s]?|own[s]?|maintain[s]?' '{print $1}'| tr '[:upper:]' '[:lower:]' | sed s/[[:space:]]*$//)
    if [ "$lookbot" = who ] ; then
        echo "PRIVMSG $chan :$nick: ask again, with a question mark at the end :^)"
        exit
    fi
    if [ "$lookbot" = i ] ; then
        nickadd=$nick
    else
        nickadd=$lookbot
    fi
    lookerlookbot=$(echo $saying | awk -F 'run[s]?|own[s]?|maintain[s]?' '{print $2}' | tr '[:upper:]' '[:lower:]' | sed s/^[[:space:]]//)
    grep -q "$lookerlookbot" maintainerfile && sed "/^$lookerlookbot.*/ s/$/, $nickadd/" -i maintainerfile || echo "$lookerlookbot $nickadd" >> maintainerfile
    echo "PRIVMSG $chan :$nick: Noted. I've added it to my record."
elif `echo $saying | grep -i 'assigned' | grep -i 'mwilliam' > /dev/null` ; then
    if [ "$nick" = _ ] ; then
        echo $saying | cut -d ' ' -f 3 >> ~/open/watchtix
    fi
elif `echo $saying | grep -i 'updated by' > /dev/null` ; then
    if [ "$nick" = _ ] ; then
        tik=`echo $saying | cut -d ' ' -f 1`
        if `grep -i $tik ~/open/watchtix > /dev/null` ; then
            echo "PRIVMSG #snot :thyme: ^"
        fi
    fi
fi


