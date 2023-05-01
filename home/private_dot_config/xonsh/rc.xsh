import warnings


source-bash ~/.bash_profile

xontrib load vox

# Disable alias warning:
#    Skipping application of 'foo' alias from 'bash' [...]
$FOREIGN_ALIASES_SUPPRESS_SKIP_MESSAGE = True

# Customize multiline prompt appearance
$MULTILINE_PROMPT = '`·.,¸,.·*¯`·.,¸,.·*¯'

# Custom prompt_toolkit style definitions
$XONSH_STYLE_OVERRIDES['completion-menu'] = 'bg:#333333 #EEEEEE'

# Add Homebrew bash completions path
$BASH_COMPLETIONS.insert(0, '/usr/local/etc/bash_completion.d')

# Python exception handling
$XONSH_TRACEBACK_LOGFILE = None
$XONSH_SHOW_TRACEBACK = False


def _fuck(args, stdin=None):
    sudo @$(history show -1)


def _upall(args, stdin=None):
    if $(command -v chezmoi):
        chezmoi update
    if $(command -v brew):
        brew update && brew upgrade
    if $(command -v gcloud):
        gcloud components update --quiet
    if $(command -v pipx):
        pipx upgrade-all


def _openbb(args, stdin=None):
    # Can't call it directly because of the space in the path:
    # https://github.com/xonsh/xonsh/issues/4481
    $["/Applications/OpenBB Terminal/OpenBB Terminal"]


def _cw(args, stdin=None):
    directory = args[0] if args else "."

    if gf`{directory}/*.code-workspace`:
        code @(gf`{directory}/*.code-workspace`[0])
    else:
        code @(directory)
    


aliases['fuck'] = _fuck
aliases['upall'] = _upall
aliases['openbb'] = _openbb
aliases['cw'] = _cw


if $(command -v oh-my-posh):
    $OH_MY_POSH_HOME = $(brew --prefix oh-my-posh).strip()
    execx($(oh-my-posh init xonsh --config "$OH_MY_POSH_HOME/themes/slimfat.omp.json"))
