"""Functions for working with QMK's submodules.
"""
from milc import cli

# This is a custom workaround to fix paths since qmk_firmware is checked in with git subtree.
# The function will remove the subtree prefix from a given path.
# It is used to run the submodule commands as if they were run from the qmk_firmware repo root.
# With these modifications it is assumed that the script is executed from the qmk firmware root directory.
def remove_subtree_prefix(
    path,
    # TODO: configure prefix here (should be the same one as used by the subtree command).
    # Ideally, this should come from cli args.
    prefix='keyboard/qmk/firmware/',
):
    return path.replace(prefix, '', 1)

def status():
    """Returns a dictionary of submodules.

    Each entry is a dict of the form:

        {
            'name': 'submodule_name',
            'status': None/False/True,
            'githash': '<sha-1 hash for the submodule>'
            'shorthash': '<short hash for the submodule>'
            'describe': '<output of `git describe --tags`>'
            'last_log_message': 'log message'
            'last_log_timestamp': 'timestamp'
        }

    status is None when the submodule doesn't exist, False when it's out of date, and True when it's current
    """
    submodules = {}
    gitmodule_config = cli.run(['git', 'config', '-f', '.gitmodules', '-l'], timeout=30)
    for line in gitmodule_config.stdout.splitlines():
        key, value = line.split('=', maxsplit=2)
        sanitized_submodule = remove_subtree_prefix(value)
        if key.endswith('.path'):
            submodules[sanitized_submodule] = {'name': sanitized_submodule, 'status': None}

    git_cmd = cli.run(['git', 'submodule', 'status'], timeout=30)
    for line in git_cmd.stdout.splitlines():
        status = line[0]
        githash, submodule = line[1:].split()[:2]
        sanitized_submodule = remove_subtree_prefix(submodule)
        submodules[sanitized_submodule]['githash'] = githash

        if status == '-':
            submodules[sanitized_submodule]['status'] = None
        elif status == '+':
            submodules[sanitized_submodule]['status'] = False
        elif status == ' ':
            submodules[sanitized_submodule]['status'] = True
        else:
            raise ValueError('Unknown `git submodule status` sha-1 prefix character: "%s"' % status)

    submodule_logs = cli.run(['git', 'submodule', '-q', 'foreach', 'git --no-pager log --no-show-signature --pretty=format:"$sm_path%x01%h%x01%ad%x01%s%x0A" --date=iso -n1'])
    for log_line in submodule_logs.stdout.splitlines():
        r = log_line.split('\x01')
        sanitized_submodule = remove_subtree_prefix(r[0])
        submodules[sanitized_submodule]['shorthash'] = r[1] if len(r) > 1 else ''
        submodules[sanitized_submodule]['last_log_timestamp'] = r[2] if len(r) > 2 else ''
        submodules[sanitized_submodule]['last_log_message'] = r[3] if len(r) > 3 else ''

    submodule_tags = cli.run(['git', 'submodule', '-q', 'foreach', '\'echo $sm_path `git describe --tags`\''])
    for log_line in submodule_tags.stdout.splitlines():
        r = log_line.split()
        sanitized_submodule = remove_subtree_prefix(r[0])
        submodules[sanitized_submodule]['describe'] = r[1] if len(r) > 1 else ''

    return submodules


def update(submodules=None):
    """Update the submodules.

        submodules
            A string containing a single submodule or a list of submodules.
    """
    git_sync_cmd = ['git', 'submodule', 'sync']
    git_update_cmd = ['git', 'submodule', 'update', '--init']

    if submodules is None:
        # Update everything
        git_sync_cmd.append('--recursive')
        git_update_cmd.append('--recursive')
        cli.run(git_sync_cmd, check=True)
        cli.run(git_update_cmd, check=True)

    else:
        if isinstance(submodules, str):
            # Update only a single submodule
            git_sync_cmd.append(submodules)
            git_update_cmd.append(submodules)
            cli.run(git_sync_cmd, check=True)
            cli.run(git_update_cmd, check=True)

        else:
            # Update submodules in a list
            for submodule in submodules:
                cli.run([*git_sync_cmd, submodule], check=True)
                cli.run([*git_update_cmd, submodule], check=True)
