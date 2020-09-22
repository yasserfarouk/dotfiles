let Grep_Default_Options = '-IR'
let Grep_Skip_Files = 'ctags* *.tmp tmp* *.log *.db'
let Grep_Skip_Dirs = '.git node_modules tmp .history'
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
