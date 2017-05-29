class people::flyingbuddha::git
{
    # Set github config
    git::config::global {
        'user.name' :                        value => 'flyingbuddha';
        'user.email' :                       value => 'me@mikeholloway.co.uk';
        'core.editor':                       value => 'vim';
        'color.ui':                          value => 'true';

        # Aliases
        'alias.ci':                          value => 'commit';
        'alias.co':                          value => 'clone';
        'alias.st':                          value => 'status';

        # use diffmerge as diff tool
        'diff.tool':                         value => 'diffmerge';
        'difftool.diffmerge.cmd':            value => 'diffmerge "$LOCAL" "$REMOTE"';
        'merge.tool':                        value => 'diffmerge';
        'mergetool.diffmerge.cmd':           value => 'diffmerge --merge --result="$MERGED" "$LOCAL" "$(if test -f "$BASE"; then echo "$BASE"; else echo "$LOCAL"; fi)" "$REMOTE"';
        'mergetool.diffmerge.trustExitCode': value => true;

        # push 2.0
        'push.default':                      value => 'simple';
    }
}
