import xonsh
import builtins
from xonsh.contexts import Functor

__all__ = ()
__version__ = '0.1.0'

class SacredXonsh(object):
    """A class representing a call to run IDSIA/sacred
    """

    def __init__(self, experiment, run=None, **kwargs):
        self.experiment = experiment
        if run is None:
          self.run = experiment._create_run()
        self.kwargs = kwargs

    def __call__(self):
        self.run.add_artifact(filename=builtins.__xonsh_history__.file, name='xonsh_history')
        # TODO(ahundt) maybe do something like: self.run.info['xonsh_history'] = file_contents
        return self.run(self.kwargs)

def sacredx(args, stdin, stdout, stderr):
    """An IDSA/sacred experiment launcher with xonsh history.

    This function implements the command line command.
    """
    # TODO(ahundt) arg parsing, incorporate distributed here?

    sx = SacredXonsh(args)
    return sx()


aliases['sacredx'] = sacredx

def sacredxd(args, stdin, stdout, stderr):
    """A distributed IDSA/sacred experiment launcher with xonsh history."""
    # TODO(ahundt) use https://github.com/xonsh/xonsh/blob/master/xontrib/distributed.py
    def _run_helper(args):
        from sacred.settings import SETTINGS
        SETTINGS.CAPTURE_MODE = 'sys'
        config_updates, named_configs = args
        experiment.run(config_updates=config_updates, named_configs=named_configs)

    raise ValueError('Not yet implemented')


aliases['sacredxd'] = sacredxd

def sacredx(*a, args=(), kwargs=None, rtn='', **kw):
    """Runs IDSIA/sacred, capturing xonsh history

    This is the normal python function version.

    Parameters
    ----------
    args : Sequence of str, optional
        A tuple of argument names.
    rtn : str, optional
        Name of object to return.
    a, kw : Sequence and Mapping
        All other arguments and keyword arguments are used to construct
        and run the experiment.
    Returns
    -------
    dsub : DSubmitter
        An instance of the DSubmitter context manager.
    """
    sx = SacredXonsh(*a, **kw)
    return sx()


