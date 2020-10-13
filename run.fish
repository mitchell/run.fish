# This run.fish script serves as a central place to store frequently run commands for this project.
# Source: https://github.com/mitchell/run.fish

### Config ###
# Top-level configurations, like function prefixes and argument delimeters
#
set -g run_arg_delimeter ':'

function define_aliases
    alias run_h='run_hello'
    alias run_l='run_lang'

    alias lang_f='lang_fr'
end


### Commands ###
# Add, edit, and remove commands freely below.
# To add a command simply create a function with this naming scheme: {run_func_prefix}_{name}.
#
function run_default -d 'Say bonjour to run.fish user'
    run_lang fr:'run.fish user'
end

function run_hello -d 'Say hello to the world'
    echo 'hello, world!'
end

function run_hey -a name -d 'Say hey to someone specific'
    echo "hey, $name!"
end

function run_lang -a command -d 'Groups lang subcommands'
    function lang_en -d 'Say hello in english'
        run_hello
    end

    function lang_fr -a name -d 'Say hello the world or someone specific, in french'
        if test -n "$name"
            echo "bonjour, $name!"
        else
            echo 'bonjour, le monde!'
        end
    end

    execute_command 'lang' $command
end
