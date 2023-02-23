import random
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

PROMPT_CHARACTERS = [
    '♔ ',
    '♕ ',
    '♙ ',
    '፨ ',
    '∆',
    '∞',
    'ツ',
]

$PROMPT_FIELDS['prompt_cursor'] = random.choice(PROMPT_CHARACTERS)

$PROMPT = (
    '{env_name:{} }' +
    '{BOLD_GREEN}{user}@{hostname}' +
    '{BOLD_BLUE} {cwd}{branch_color}{curr_branch: {}}' +
    '{RESET} {BOLD_BLUE}{prompt_cursor}' +
    '{RESET} '
)

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


aliases['fuck'] = _fuck


if $(command -v oh-my-posh):
    $OH_MY_POSH_HOME = $(brew --prefix oh-my-posh).strip()
    execx($(oh-my-posh init xonsh --config "$OH_MY_POSH_HOME/themes/slimfat.omp.json"))
