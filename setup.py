from setuptools import setup

setup(
    name='xontrib-sacredx',
    version='0.1.0',
    url='https://github.com/ahundt/sacredx',
    license='MIT',
    author='Andrew Hundt',
    author_email='ATHundt@gmail.com',
    description='run reproducible experiments in xonsh by integrating with https://github.com/IDSIA/sacred',
    packages=['xontrib'],
    package_dir={'xontrib': 'xontrib'},
    package_data={'xontrib': ['*.xsh']},
    platforms='any',
)
