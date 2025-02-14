import warnings
from xonsh.tools import chdir

warnings.filterwarnings(
    'ignore',
    message='There is no current event loop',
    category=DeprecationWarning,
    module='prompt_toolkit',
)

source-bash ~/.bash_profile --overwrite-alias

xontrib load vox

# Customize multiline prompt appearance
$MULTILINE_PROMPT = '`·.,¸,.·*¯`·.,¸,.·*¯'

# Custom prompt_toolkit style definitions
$XONSH_STYLE_OVERRIDES['completion-menu'] = 'bg:#333333 #EEEEEE'

# Add Homebrew bash completions path
$BASH_COMPLETIONS.insert(0, '/usr/local/etc/bash_completion.d')

# Python exception handling
$XONSH_TRACEBACK_LOGFILE = None
$XONSH_SHOW_TRACEBACK = False


@aliases.register("fuck")
def _fuck(args, stdin=None):
    sudo @$(history show -1)


@aliases.register("upall")
def _upall(args, stdin=None):
    if $(command -v chezmoi):
        rich -p "Updating chezmoi" --panel 'rounded' --panel-style 'green'
        chezmoi update -v
    if $(command -v brew):
        rich -p "Updating Homebrew" --panel 'rounded' --panel-style 'green'
        brew update
        brew upgrade
    if $(command -v gcloud):
        rich -p "Updating gcloud" --panel 'rounded' --panel-style 'green'
        gcloud components update --quiet
    if $(command -v uv):
        rich -p "Updating uv" --panel 'rounded' --panel-style 'green'
        uv self update
        uv tool upgrade --all


@aliases.register("openbb")
def _openbb(args, stdin=None):
    # Can't call it directly because of the space in the path:
    # https://github.com/xonsh/xonsh/issues/4481
    $["/Applications/OpenBB Terminal/OpenBB Terminal"]


@aliases.register("cw")
def _cw(args, stdin=None):
    directory = args[0] if args else "."

    if gf`{directory}/*.code-workspace`:
        code @(gf`{directory}/*.code-workspace`[0])
    else:
        code @(directory)


@aliases.register("llmd")
def _llmd(args):
    llm @(args) | rich --markdown --text-left --width 100 -

@aliases.register("rufff")
def _rufff(args):
    ruff check . && ruff format --check .

if $(command -v starship):
    execx($(starship init xonsh))
