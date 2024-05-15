import os

from meshroom.core import desc
import docker

def image_exists(image_name):
    """
    Checks if an image exists with a given name
    """
    client = docker.from_env()
    try:
        client.images.get(image_name)
        return True
    except docker.errors.ImageNotFound:
        return False

class DockerNode(desc.CommandLineNode):
    def __init__(self):
        super().__init__() #TODO check if docker to path

    """path to the dockerfile"""
    docker_file = None #FIXME: automatically the folder of the node that inherit condanode?    
    """docker image, will be initialised if not existing"""
    docker_image = None
        
    def buildCommandLine(self, chunk):
        cmdPrefix = ''

        #init the image name if not specified
        if self.docker_image is None:
            self.docker_image="mr_node_"+self.__class__.__name__.lower()#image name from class

        #build image 
        if not image_exists(self.docker_image):
            chunk.logger.info("Creating image "+self.docker_image)
            if (self.docker_file is None) or (not os.path.exists(self.docker_file)):
                raise RuntimeError('No docker file found.')
            build_command = "docker build "+self.docker_file+" -t "+self.docker_image
            chunk.logger.info("Building...")
            os.system(build_command)
            chunk.logger.info("Done")
        #mount point in the working dir wich is the node dir
        mount_cl = ' --mount type=bind,source="$(pwd)",target=/node_folder '
        #add the prefix to the command line
        cmdPrefix = 'docker run -it --rm --runtime=nvidia --gpus all '+mount_cl+self.docker_image+" "
        cmdSuffix = ''
        if chunk.node.isParallelized and chunk.node.size > 1:
            cmdSuffix = ' ' + self.commandLineRange.format(**chunk.range.toDict())
        return cmdPrefix + chunk.node.nodeDesc.commandLine.format(**chunk.node._cmdVars) + cmdSuffix

    def processChunk(self, chunk):
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            with open(chunk.logFile, 'w') as logF:
                cmd = self.buildCommandLine(chunk)
                chunk.status.commandLine = cmd
                chunk.saveStatusFile()
                print(' - commandLine: {}'.format(cmd))
                print(' - logFile: {}'.format(chunk.logFile))
                #popen doesnt work with docker, also move to node folder
                chunk.status.returnCode = os.system("cd "+chunk.node.internalFolder+" && "+cmd)
                logContent=""

            if chunk.status.returnCode != 0:
                with open(chunk.logFile, 'r') as logF:
                    logContent = ''.join(logF.readlines())
                raise RuntimeError('Error on node "{}":\nLog:\n{}'.format(chunk.name, logContent))
        except:
            chunk.logManager.end()
            raise
        chunk.logManager.end()