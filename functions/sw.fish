function sw -d 'The fish-based project script runner'
    argparse --ignore-unknown 'i-init' -- $argv
    set -g cmd_func_prefix 'swim'

    if test -n "$_flag_init"
        curl -fsS https://raw.githubusercontent.com/mitchell/swim.fish/master/swim.fish.example >swim.fish
        return
    end

    if test -f ./swim.fish
        source ./swim.fish
    else
        echo 'No swim.fish found. Run `sw --init` make one.'
        return 1
    end

    run_swim_command $cmd_func_prefix $argv
end

function run_swim_command -a prefix
    argparse --ignore-unknown 'h/help' -- $argv
    set -l command $argv[2]
    set -l func $prefix\_$command
    set -l args $argv[3..-1]

    define_included_functions $prefix

    if functions -q $func
        if test -n "$_flag_h"
            if test ($func is_group) = 'is-group' >/dev/null 2>&1
                $func $args --help
            else
                $prefix\_help $command
            end
        else
            $func $args
        end
    else if test -n "$_flag_h"
        $prefix\_help
    else if functions -q $prefix\_default
        $prefix\_default $args
    else
        echo "
$prefix command '$command' does not exist
Try 'help' command or -h/--help flags"
        return 127
    end
end

function define_included_functions -a prefix
    set -l prefix $prefix

    function $prefix\_do -V prefix -d 'Perform a list of commands separated by commas'
        for command in (string split ',' "$argv")
            if test -z "$command"
                continue
            end

            set -l command (string trim "$command")

            echo "Running '$command' ..."
            run_swim_command $prefix (string split ' ' $command)
            or return $status
        end
    end

    function _$prefix\_commands -V prefix -d 'List all available commands'
        set -l names (functions --names | grep "^$prefix\_")

        for name in $names
            set -l details (functions -D -v $name)
            set -l description $details[5]
            set -l short_name (string replace $prefix\_ '' $name)

            if test (string length $short_name) -ge 8
                echo $short_name\t$description
            else
                echo $short_name\t\t$description
            end
        end
    end

    function $prefix\_help -a command -V prefix -d 'Print help menu or command definition'
        if test -n "$command"
            functions $prefix\_$command
        else
            echo 'Here are the available commands:'\n
            _$prefix\_commands
            echo \n"To see a command's definition do `run help {command}`"
            echo "To see a subcommand group's help menu do `run {command} help`"
        end
    end

    function $prefix\_is_group -d 'Tells executor whether this is a subcommand group'
        echo 'is-group'
    end
end
