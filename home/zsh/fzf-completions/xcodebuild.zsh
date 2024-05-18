_fzf_complete_xcodebuild() {
    # $1 is LBUFFER without the current word that contains the trigger
    local LBUFFER_NO_TRIGGER=$1
    # $prefix also exists; It's the current word without the trigger

    # http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion-Flags
    # `(z)` splits at zsh word boundaries
    local tokens=(${(z)LBUFFER})
    # xcodebuild -someFlag ,
    # 1          2         3  <- need at least 3 tokens
    if [[ ${#tokens} -le 2 ]]; then
        return
    fi

    # -1 is the trigger token (,) so we need -2
    local last_flag=${tokens[-2]}
    case "$last_flag" in
        (-project)
            # JCTODO: I feel like this is going to be useful in more places. I should extract this into a helper that takes the extension as an argument. 
            _fzf_complete -- "$@" < <(
                find . -type d -name "*.xcodeproj"
            )
        ;;
        (-target)
            # If we call `xcodebuild` and pass in a project, we can use `-list` to list a bunch of info about the project, 
            # including its targets Unfortunately, there is no way to get `xcodebuild` to output a machine readable format,
            # like JSON, so we will need to parse all that output manually. I used ChatGPT to help me write the following:
            
            # https://chatgpt.com/share/158fea6d-b65e-4722-839a-483456a428db
            local project_path=$(echo $LBUFFER_NO_TRIGGER | awk '{for (i=1; i<=NF; i++) if ($i == "-project") print $(i+1)}')
            
            if [[ -n $project_path ]]; then
                _fzf_complete -- "$@" < <(
                    # https://chatgpt.com/share/957f407d-b6a9-42eb-a236-08c45ada7f14
                    local SEARCH_STRING="Targets:"
                    xcodebuild -project $project_path -list | sed -n "/${SEARCH_STRING}/,\$p" | awk -v search_string="${SEARCH_STRING}" 'f && NF {print} $0 ~ search_string {f=1} f && !NF {exit}' | sed 's/^[[:space:]]*//'
                )
            fi
        ;;
    esac
}
