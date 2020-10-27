# This run.fish script serves as a central place to store frequently run commands for this project.
# Replace command section with your own command functions.
# Source: https://github.com/mitchell/run.fish

### Config ###
# Top-level configurations, like the argument delimeter and custom global variables.

set -g run_arg_delimeter ':'

### Commands ###
# Add, edit, and remove commands freely below.
# To add a command simply create a function with this naming scheme: {run_func_prefix}_{name}.

function run_default -a arg -d 'Display this help menu'
    # This command will run in when you simply execute `run` in this repo.
    # The default command is set to help by default.
    # So you can omit this from your run.fish if you like that behavior.
    run_help $arg
end

function run_install -a bin_path -d 'Install the run script to a bin folder'
    if test -z "$bin_path"
        if test -d ~/.local/bin
            set bin_path ~/.local/bin
        else if test -d /usr/local/bin
            set bin_path /usr/local/bin
        end
    end

    echo "Installing run script to $bin_path."
    cp ./run $bin_path/
end

function run_lint -d 'Lint fish scripts'
    fish --no-execute ./run ./run.fish
end

function run_format -d 'Format fish scripts'
    fish_indent --write ./run ./run.fish
end

function run_hello -a command -d 'This is an example of a subgroup of commands'
    function hello_world -d 'The classic'
        echo 'Hello, world!'
    end

    function hello_name -a name -d 'Say hello to someone specific'
        echo "Hello, $name!"
    end

    function hello_fr -d 'Say bonjour'
        echo 'Bonjour, le monde!'
    end

    alias hello_default='hello_world'

    execute_command 'hello' $command # this command comes from the run script
end

function run_fails -d 'This command fails every time'
    false
end
