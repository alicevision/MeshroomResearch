"""
This class defines a node made to build and call conda before running a CL node.
"""

import os
from meshroom.core import desc

class CondaNode(desc.CommandLineNode):
    def __init__(self):
        super().__init__() #TODO check if conda to path

    @property
    def env_file(self):
        """path to yaml file, needs to be set in inherited class"""
        raise NotImplementedError("You must ovewrite env_file in the inherited CondaNode")

    def buildCommandLine(self, chunk):#move in processChunk?
        cmdPrefix = ''
        #create the env in the folder above the node
        env_path=os.path.join(chunk.node.internalFolder, "../conda_env")
        if not os.path.exists(env_path):
            chunk.logger.info("Creating conda env")
            if not os.path.exists(self.env_file):
                raise RuntimeError('No yaml file found.')
            make_env_command = "conda env create --prefix {env_path} --file {env_file}".format(env_path=env_path, env_file=self.env_file)
            os.system(make_env_command)

        #add the prefix to the command line
        cmdPrefix = 'conda run --no-capture-output -p {env_path} '.format(env_path=env_path)
        cmdSuffix = ''
        if chunk.node.isParallelized and chunk.node.size > 1:
            cmdSuffix = ' ' + self.commandLineRange.format(**chunk.range.toDict())
        return cmdPrefix + chunk.node.nodeDesc.commandLine.format(**chunk.node._cmdVars) + cmdSuffix
