export ZSHHOME="$ZSHHOME:$HOME/dotfiles/.zsh"

if  [ -d $ZSHHOME -a -r $ZSHHOME -a \
     -x $ZSHHOME ];
then
    for i in $ZSHHOME/*; do
    [[ ${i##*/} = *.zsh]] &&
        [ \( -f $i \) -a \( -r $i \) ] && . $i
    done
fi