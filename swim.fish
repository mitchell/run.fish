# This swim.fish script serves as a central place to store frequently run commands for this project.
# Replace Commands section with your own command functions.
# Source: https://github.com/mitchell/swim.fish

# Configuration

# These are the currently configurable settings of the sw script.
# Both contain their defaults and can be omitted from your swim.fish.
set -g cmd_func_prefix 'swim' # Set the function prefix for defining tasks
set -g task_arg_delimeter '.' # Set the argument delimeter for tasks

# Commands

function swim_default -a arg -d 'Display this help menu'
    # This command will run in when you simply execute `sw` in this repo.
    # The default command is set to help by default.
    # So you can omit this from your swim.fish if you like that behavior.
    swim_help $arg
end

function swim_install -d 'Install the sw script to a bin folder'
    argparse --max-args 0 'p/bin_path=' -- $argv
    set -l sudo_needed true
    set -l bin_path /usr/local/bin

    if test -n "$_flag_p"
        set sudo_needed false
        set bin_path $_flag_p
    else if test -d ~/.local/bin
        set sudo_needed false
        set bin_path ~/.local/bin
    end

    echo "Installing sw script to $bin_path."
    set -l cp_cmd cp ./sw $bin_path/

    if $sudo_needed
        sudo $cp_cmd
    else
        $cp_cmd
    end
end

function swim_lint -d 'Lint fish scripts'
    fish --no-execute ./sw ./swim.fish
end

function swim_format -d 'Format fish scripts'
    fish_indent --write ./sw ./swim.fish
end

function swim_hello -d 'This is an example of a subgroup of commands'
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

    run_command 'hello' $argv # this command comes from the sw script
end

function swim_fails -d 'This command fails every time'
    false
end
