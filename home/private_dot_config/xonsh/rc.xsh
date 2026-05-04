import os
import tempfile
from contextlib import contextmanager

from xonsh.tools import chdir
from pathlib import Path

source-bash ~/.bash_profile --overwrite-alias

xontrib load vox

# Customize multiline prompt appearance
$MULTILINE_PROMPT = "`·.,¸,.·*¯`·.,¸,.·*¯"

# Custom prompt_toolkit style definitions
$XONSH_STYLE_OVERRIDES["completion-menu"] = "bg:#333333 #EEEEEE"

# Add Homebrew bash completions path
$BASH_COMPLETIONS.insert(0, "/usr/local/etc/bash_completion.d")

# Python exception handling
$XONSH_TRACEBACK_LOGFILE = None
$XONSH_SHOW_TRACEBACK = False

SCRIPTS_DIR = Path("~/dev/scripts").expanduser()



@contextmanager
def temp_fifo():
    """Create a temporary FIFO that auto-cleans on exit"""
    with tempfile.TemporaryDirectory() as tmpdir:
        fifo_path = os.path.join(tmpdir, 'myfifo')
        os.mkfifo(fifo_path)
        yield fifo_path


@aliases.register("fuck")
def _fuck(args, stdin=None):
    sudo @$(history show -1)


@aliases.register("upall")
def _upall(args, stdin=None):
    if $(which chezmoi):
        rich -p "Updating chezmoi" --panel "rounded" --panel-style "green"
        chezmoi update -v
    if $(which brew):
        rich -p "Updating Homebrew" --panel "rounded" --panel-style "green"
        brew update
        brew upgrade
    if $(which gcloud):
        rich -p "Updating gcloud" --panel "rounded" --panel-style "green"
        gcloud components update --quiet
    if $(which uv):
        rich -p "Updating uv" --panel "rounded" --panel-style "green"
        uv self update
        uv tool upgrade --all
    if $(which claude):
        rich -p "Updating Claude Code" --panel "rounded" --panel-style "green"
        claude update


@aliases.register("cw")
def _cw(args, stdin=None):
    directory = args[0] if args else "."

    if gf`{directory}/*.code-workspace`:
        cursor @(gf`{directory}/*.code-workspace`[0])
    else:
        cursor @(directory)


@aliases.register("llmd")
def _llmd(args):
    with temp_fifo() as fifo:
        uv run f"{SCRIPTS_DIR}/md_stream_textual.py" f"{fifo}" &
        llm @(args) > f"{fifo}"

@aliases.register("rufff")
def _rufff(args):
    ruff check . && ruff format --check .

if $(which starship):
    execx($(starship init xonsh))
