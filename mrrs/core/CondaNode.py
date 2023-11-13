"""
This class defines a node made to build and call conda before running a CL node.
Conda needs to be installed and callable via "conda"
"""

import os
from meshroom.core import desc

class CondaNode(desc.CommandLineNode):
    # def __init__(self):
    #     super().__init__() #TODO check if conda to path

    @property
    def env_file(self):
        """path to yaml file, needs to be set in inherited class"""
        raise NotImplementedError("You must ovewrite env_file in the inherited CondaNode")

    @property
    def env_path(self):
        """path to the conda env, will be initialised if not existing"""
        return None

    def curate_env_command(self):
        """
        Used to unset all rez defined env that messes up with conda.
        """
        cmd=""
        for env_var in os.environ.keys():
            if ((("py" in env_var) or  ("PY" in env_var)) 
                and ("REZ" not in env_var) and ("." not in env_var) and ("-" not in env_var)):
                if env_var.endswith("()"):#function get special treatment
                    cmd+='unset -f '+env_var[10:-2]+'; '
                else:
                    cmd+='unset '+env_var+'; '
        return cmd

    def buildCommandLine(self, chunk):
        cmdPrefix = ''
        #create the env in the folder above the node
        if self.env_path is None:
            env_path=os.path.join(chunk.node.internalFolder, "../conda_env")
        else:
            env_path=self.env_path
        if not os.path.exists(env_path):
            chunk.logger.info("Creating conda env")
            if not os.path.exists(self.env_file):
                raise RuntimeError('No yaml file found.')
            make_env_command = self.curate_env_command()+" conda config --set channel_priority strict; "+" conda env create --prefix {env_path} --file {env_file}".format(env_path=env_path, env_file=self.env_file)   
            print("Building env")
            print(make_env_command)
            os.system(make_env_command)
        #add the prefix to the command line
        cmdPrefix = self.curate_env_command()+' conda run --no-capture-output -p {env_path} '.format(env_path=env_path)
        cmdSuffix = ''
        if chunk.node.isParallelized and chunk.node.size > 1:
            cmdSuffix = ' ' + self.commandLineRange.format(**chunk.range.toDict())
        return cmdPrefix + chunk.node.nodeDesc.commandLine.format(**chunk.node._cmdVars) + cmdSuffix

    def processChunk(self, chunk):
        try:
            with open(chunk.logFile, 'w') as logF:
                cmd = self.buildCommandLine(chunk)
                chunk.status.commandLine = cmd
                chunk.saveStatusFile()
                print(' - commandLine: {}'.format(cmd))
                print(' - logFile: {}'.format(chunk.logFile))
                # chunk.subprocess = psutil.Popen(shlex.split(cmd), stdout=logF, stderr=logF, cwd=chunk.node.internalFolder)

                # chunk.statThread.proc = chunk.subprocess
                # stdout, stderr = chunk.subprocess.communicate()
                # chunk.subprocess.wait()

                # chunk.status.returnCode = chunk.subprocess.returncode

                #unset doesnt work with subprocess, and removing the variables from the env dict does not work either
                chunk.status.returnCode = os.system(cmd)
                logContent=""

            if chunk.status.returnCode != 0:
                with open(chunk.logFile, 'r') as logF:
                    logContent = ''.join(logF.readlines())
                raise RuntimeError('Error on node "{}":\nLog:\n{}'.format(chunk.name, logContent))
        except:
            raise
        finally:
            chunk.subprocess = None