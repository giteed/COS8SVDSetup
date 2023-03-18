# .bash_aliases

# --> Использовать ~/.bash_ali_hosts
. ~/.bash_ali_hosts ;

#-----------------------------------
# User specific aliases and functions
# unalias name - удалить алиас
#-----------------------------------

# df -h , free -h , ip , who , type

# clear , update /root/.bashrc , ls , cd , tree
alias c='clear'
alias l.='ls -lhd --color=auto .*'
alias l..='ls -lhd --color=auto .* *'
alias ll='ls -lh --color=auto'
alias lll='tree -Csuh | more' 
alias ls='ls -h --color=auto'
alias ff='GLIG_ASTRX_ON && ff-f'
alias lk='GLIG_ASTRX_OF && lk-f'
alias ..='cd ..'
alias path='echo -e ${PATH//:/\\n}'

# grep , wget
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias xzegrep='xzegrep --color=auto'
alias xzfgrep='xzfgrep --color=auto'
alias xzgrep='xzgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias zgrep='zgrep --color=auto'
alias wget='wget -c'

# cp , mv , mc , rm , mkdir
alias cp='cp -i'
alias mv='mv -i'
alias mc='. /usr/libexec/mc/mc-wrapper.sh'

# Не удалять корень и предупреждать об удалении файлов
alias rm='rm -I --preserve-root'

# Защита от изменения прав для /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias mkdir='mkdir -p'

# yum
alias ypr='GLIG_ASTRX_ON && ypr-f'

# 
alias tsync='/root/test-lab/tsync.sh'
alias dell='sudo /root/vdsetup.2/bin/utility/del.sh'

