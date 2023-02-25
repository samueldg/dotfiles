import warnings


# Temporary fix for https://github.com/xonsh/xonsh/issues/4409
warnings.filterwarnings(
    'ignore',
    message='There is no current event loop',
    category=DeprecationWarning,
    module='prompt_toolkit',
)

source-bash ~/.bash_profile

xontrib load vox

# Disable alias warning:
#    Skipping application of 'foo' alias from 'bash' [...]
$FOREIGN_ALIASES_SUPPRESS_SKIP_MESSAGE = True

# Customize multiline prompt appearance
$MULTILINE_PROMPT = '`·.,¸,.·*¯`·.,¸,.·*¯'

# Custom prompt_toolkit style definitions
$XONSH_STYLE_OVERRIDES['completion-menu'] = 'bg:#333333 #EEEEEE'

# Don't lazy load prompt-toolkit's color-input support.
$ENABLE_ASYNC_PROMPT = False

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


aliases['fuck'] = _fuck
aliases['upall'] = _upall


if $(command -v oh-my-posh):
    $OH_MY_POSH_HOME = $(brew --prefix oh-my-posh).strip()
    execx($(oh-my-posh init xonsh --config "$OH_MY_POSH_HOME/themes/slimfat.omp.json"))
