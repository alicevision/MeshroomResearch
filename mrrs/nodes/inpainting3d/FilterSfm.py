__version__ = "1.0"

from meshroom.core import desc
from meshroom.core.utils import VERBOSE_LEVEL

import json
import os


class FilterSfm(desc.Node):
    #size = desc.DynamicNodeSize('inputFiles')

    category = 'Inpainting 3D'
    documentation = '''
TODO
'''

    inputs = [
        desc.File(
            name="sfmData",
            label="SfmData",
            description="TODO",
            value="",
            exposed=True,
        ),
        desc.IntParam(
            name="intrinsicId",
            label="Intrinsic ID",
            description="TODO",
            value=0,
            exposed=True,
        )
    ]

    outputs = [
        desc.File(
            name="filteredSfmData",
            label="Filtered Sfm Data",
            description="TODO",
            value=os.path.join(desc.Node.internalFolder, 'sfm.sfm'),
        ),
    ]

    def processChunk(self, chunk):
        try:
            #chunk.logManager.start(chunk.node.verboseLevel.value)

            sfmData = json.load(open(chunk.node.sfmData.value, 'r'))
            intrinsicID = chunk.node.intrinsicId.value

            views = []
            for view in sfmData["views"]:
                if int(view["intrinsicId"]) == intrinsicID:
                    views.append(view)

            output = sfmData
            output["views"] = views

            with open(chunk.node.filteredSfmData.value, 'w') as f:
                json.dump(output, f, indent=4)

        finally:
            chunk.logManager.end()
