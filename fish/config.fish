# Prompt
# https://raw.githubusercontent.com/bpinto/oh-my-fish/master/themes/cor/fish_right_prompt.fish
function _git_branch_name
        echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
        echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt --description 'Write out the prompt'
        set -l last_status $status

        if not set -q __fish_prompt_normal
                set -g __fish_prompt_normal (set_color normal)
        end

        if not test $last_status -eq 0
                set_color $fish_color_error
        end

        echo -n '> '
end

function fish_right_prompt --description 'Write out the right prompt'
        set -l cyan (set_color cyan)
        set -l red (set_color red)
        set -l normal (set_color normal)
        set -l yellow (set_color cccc00)
        set -l green (set_color 80ff00)
        set -l pink (set_color ff99ff)
        set -l dark_pink (set_color cc99ff)
        set -l dark_grey (set_color cccccc)
        set -l fish_color_cwd (set_color $fish_color_cwd)

        # PWD
        if [ (hostname) != 'kaj.local' ]
                echo -n -s $dark_grey (hostname) ':' $fish_color_cwd (prompt_pwd)
        else
                echo -n -s $fish_color_cwd (prompt_pwd)
        end
        set_color normal

        # Show git branch and dirty state
        if [ (_git_branch_name) ]
                set -l git_branch (_git_branch_name)

                if [ (_is_git_dirty) ]
                        echo -n -s $cyan ' ‹' $yellow $git_branch $red '*' $cyan '›' $normal
                else
                        echo -n -s $cyan ' ‹' $yellow $git_branch $cyan '›' $normal
                end
        end

end

# Emacs
set PATH /usr/local/opt/emacs/bin $PATH
alias emacs="env TERM=screen-16color emacsclient -t"
alias e="emacsclient -c -n"
alias emax="/usr/bin/emacs"
set EDITOR "emacs"
set ALTERNATE_EDITOR /usr/local/bin/mg

# Postgres
set PATH /Applications/Postgres.app/Contents/Versions/latest/bin $PATH

# Boot
set -x BOOT_HOME ~/.config/boot
set -x BOOT_JVM_OPTIONS "-client -XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xmx2g -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -Xverify:none"

# Go
set PATH $PATH /usr/local/opt/go/libexec/bin
set -x GOPATH /Users/daniel/Workspace/go

# Google SDK
set PATH $PATH /Users/daniel/Applications/google-cloud-sdk/bin

# Alias
alias la="ls -la"
